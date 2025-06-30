module RecostaProjectCleaner.App

open System
open RecostaProjectCleaner.Domain


    open System.Text.Json
open System.Text.Json.Nodes

let cleanJson (input: string) : string =
    let project = JsonParser.fromString input
    let cleanedProject = Project.clean project
    let newFileItems =
        cleanedProject.FileItems
        |> List.map (fun item -> JsonNode.Parse(item.OriginalNode.ToJsonString()))
        |> List.toArray
    let doc = JsonNode.Parse(input)
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
            let cleaned = cleanJson inputJson
            if System.IO.File.Exists(output) && not force then
                printfn $"Error: Output file 
%s{output}
 already exists. Use --force to overwrite."
                1
            else
                System.IO.File.WriteAllText(output, cleaned)
                printfn $"Cleaned project written to 
%s{output}
"
                0
        with e ->
            printfn $"Error: %s{e.Message}"
            1
    | [input; output] when input.EndsWith(".ccproj") && output.EndsWith(".ccproj") ->
        let force = false
        // ...処理本体へ...
        try
            let inputJson = System.IO.File.ReadAllText(input)
            let cleaned = cleanJson inputJson
            if System.IO.File.Exists(output) && not force && input = output then
                printfn $"Error: Output file 
%s{output}
 already exists. Use --force to overwrite."
                1
            else
                System.IO.File.WriteAllText(output, cleaned)
                printfn $"Cleaned project written to 
%s{output}
"
                0
        with e ->
            printfn $"Error: %s{e.Message}"
            1
    | [input; output; flag] when input.EndsWith(".ccproj") && output.EndsWith(".ccproj") && flag = "--force" ->
        // 上書き許可
        try
            let inputJson = System.IO.File.ReadAllText(input)
            let cleaned = cleanJson inputJson
            System.IO.File.WriteAllText(output, cleaned)
            printfn $"Cleaned project written to 
%s{output}
 (overwritten)"
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
            let cleaned = cleanJson inputJson
            System.IO.File.WriteAllText(output, cleaned)
            printfn $"Cleaned project written to 
%s{output}
 (overwritten)"
            0
        with e ->
            printfn $"Error: %s{e.Message}"
            1
    | _ -> printUsage ()