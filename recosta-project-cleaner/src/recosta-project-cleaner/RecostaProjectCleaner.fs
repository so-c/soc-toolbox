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
    let printUsage () =
        printfn "Usage: RecostaProjectCleaner <input.ccproj> [output.ccproj] [--force]"
        1
    match Array.toList argv with
    | [input] when input.EndsWith(".ccproj") ->
        let output =
            let baseName =
                if input.EndsWith(".ccproj") then input.Substring(0, input.Length - 7) else input
            baseName + ".cleaned.ccproj"
        let force = false
        // ...処理本体へ...
        try
            let inputJson = System.IO.File.ReadAllText(input)
            let cleaned = RecostaProjectCleaner.cleanJson inputJson
            if System.IO.File.Exists(output) && not force then
                printfn $"Error: Output file '%s{output}' already exists. Use --force to overwrite."
                1
            else
                System.IO.File.WriteAllText(output, cleaned)
                printfn $"Cleaned project written to '%s{output}'"
                0
        with e ->
            printfn $"Error: %s{e.Message}"
            1
    | [input; output] when input.EndsWith(".ccproj") && output.EndsWith(".ccproj") ->
        let force = false
        // ...処理本体へ...
        try
            let inputJson = System.IO.File.ReadAllText(input)
            let cleaned = RecostaProjectCleaner.cleanJson inputJson
            if System.IO.File.Exists(output) && not force && input = output then
                printfn $"Error: Output file '%s{output}' already exists. Use --force to overwrite."
                1
            else
                System.IO.File.WriteAllText(output, cleaned)
                printfn $"Cleaned project written to '%s{output}'"
                0
        with e ->
            printfn $"Error: %s{e.Message}"
            1
    | [input; output; flag] when input.EndsWith(".ccproj") && output.EndsWith(".ccproj") && flag = "--force" ->
        // 上書き許可
        try
            let inputJson = System.IO.File.ReadAllText(input)
            let cleaned = RecostaProjectCleaner.cleanJson inputJson
            System.IO.File.WriteAllText(output, cleaned)
            printfn $"Cleaned project written to '%s{output}' (overwritten)"
            0
        with e ->
            printfn $"Error: %s{e.Message}"
            1
    | [input; flag] when input.EndsWith(".ccproj") && flag = "--force" ->
        let output =
            let baseName =
                if input.EndsWith(".ccproj") then input.Substring(0, input.Length - 7) else input
            baseName + ".cleaned.ccproj"
        try
            let inputJson = System.IO.File.ReadAllText(input)
            let cleaned = RecostaProjectCleaner.cleanJson inputJson
            System.IO.File.WriteAllText(output, cleaned)
            printfn $"Cleaned project written to '%s{output}' (overwritten)"
            0
        with e ->
            printfn $"Error: %s{e.Message}"
            1
    | _ -> printUsage ()