module RecostaProjectCleaner.Domain

open System
open System.Text.Json.Nodes

// Using single-case discriminated unions for type safety and expressiveness
type Ik = Ik of string

type FileItem = {
    Ik: Ik
    // Keep the original JSON node to reconstruct the output without losing data
    OriginalNode: JsonNode
}

type LayerObject = {
    // An object might not have a file reference
    UsedFileIk: Ik option
}

type Layer = {
    Objects: LayerObject list
}

type Project = {
    FileItems: FileItem list
    Layers: Layer list
}

module Project =
    let getUsedIks (project: Project) : Set<Ik> =
        project.Layers
        |> List.collect (fun layer -> layer.Objects)
        |> List.choose (fun obj -> obj.UsedFileIk)
        |> Set.ofList

    let clean (project: Project) : Project =
        let usedIks = getUsedIks project
        let cleanedFileItems =
            project.FileItems
            |> List.filter (fun item -> Set.contains item.Ik usedIks)
        { project with FileItems = cleanedFileItems }

module JsonParser =
    let private toIk (jsonNode: JsonNode) : Ik =
        Ik (jsonNode.ToString().Trim([|'"'|]))

    let private toFileItem (jsonNode: JsonNode) : FileItem = {
        Ik = toIk jsonNode["ik"]
        OriginalNode = jsonNode
    }

    let private toLayerObject (jsonNode: JsonNode) : LayerObject = {
        UsedFileIk =
            match jsonNode["properties"] with
            | null -> None
            | props ->
                match props["File"] with
                | null -> None
                | file ->
                    match file["p-value"] with
                    | null -> None
                    | pval -> Some (toIk pval)
    }

    let private toLayer (jsonNode: JsonNode) : Layer = {
        Objects =
            jsonNode["layer-objects"]
            :?> JsonArray
            |> Seq.map toLayerObject
            |> List.ofSeq
    }

    let fromString (json: string) : Project = {
        FileItems =
            JsonNode.Parse(json)["file-items"]
            :?> JsonArray
            |> Seq.map toFileItem
            |> List.ofSeq
        Layers =
            JsonNode.Parse(json)["layers"]
            :?> JsonArray
            |> Seq.map toLayer
            |> List.ofSeq
    }
