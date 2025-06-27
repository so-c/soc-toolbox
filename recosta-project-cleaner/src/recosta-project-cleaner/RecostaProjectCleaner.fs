// Learn more about F# at http://docs.microsoft.com/dotnet/fsharp

open System

// Define a function to construct a message to print
let from whom =
    sprintf "from %s" whom

module RecostaProjectCleaner =
    open System.Text.Json
    open System.Text.Json.Nodes

    let cleanJson (input: string) : string =
        let doc = JsonNode.Parse(input)
        let fileItems = doc["file-items"] :?> JsonArray
        let layers = doc["layers"] :?> JsonArray
        // p-valueをすべて集める
        let usedIk =
            layers
            |> Seq.collect (fun layer ->
                let layerObjects = layer["layer-objects"] :?> JsonArray
                layerObjects
                |> Seq.choose (fun obj ->
                    let props = obj["properties"]
                    if isNull props then None else
                    let file = props["File"]
                    if isNull file then None else
                    let pval = file["p-value"]
                    if isNull pval then None else
                    Some (pval.ToString().Trim('"'))))
            |> Set.ofSeq
        // file-itemsから未使用ikを除去し、新ノードとして複製
        let newFileItems =
            fileItems
            |> Seq.filter (fun item ->
                let ik = item["ik"].ToString().Trim('"')
                Set.contains ik usedIk)
            |> Seq.map (fun item -> JsonNode.Parse(item.ToJsonString()))
            |> Seq.toArray
        doc["file-items"] <- JsonArray(newFileItems)
        doc.ToJsonString()

[<EntryPoint>]
let main argv =
    let message = from "F#" // Call the function
    printfn "Hello world %s" message
    0 // return an integer exit code