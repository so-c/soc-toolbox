module RecostaProjectCleaner.Tests

open System
open Xunit
open System.Text.Json
open RecostaProjectCleaner.App

[<Fact>]
let ``My test`` () =
    Assert.True(true)

[<Fact>]
let ``file-items から未使用 ik を除去する`` () =
    let inputJson = """
    {
      "file-items": [
        { "ik": "b1d9296544a9f4a46245638a24fb3f6d47b4d27292ea6e61f8cc5ef4f8b73fcb" },
        { "ik": "7c31b655b76fda5d5f1270feb2d1eedd94ff89ab5b5f17ef9b5015111f972388" },
        { "ik": "f6e64de2ac18b9b01c49ca62cc21fe7cecb7ace7127e355d7624259af8754f55" },
        { "ik": "4fe5d1068dbdfe813ce4907dd9887d2cf753f330eafd6b2d4e467772ca81c05c" }
      ],
      "layers": [
        {
          "layer-objects": [
            {
              "properties": {
                "File": {
                  "p-value": "b1d9296544a9f4a46245638a24fb3f6d47b4d27292ea6e61f8cc5ef4f8b73fcb"
                }
              }
            },
            {
              "properties": {
                "File": {
                  "p-value": "7c31b655b76fda5d5f1270feb2d1eedd94ff89ab5b5f17ef9b5015111f972388"
                }
              }
            }
          ]
        },
        {
          "layer-objects": [
            {
              "properties": {
                "File": {
                  "p-value": "f6e64de2ac18b9b01c49ca62cc21fe7cecb7ace7127e355d7624259af8754f55"
                }
              }
            }
          ]
        }
      ]
    }
    """
    let expectedIk : Set<string> =
        Set.ofList [
            "b1d9296544a9f4a46245638a24fb3f6d47b4d27292ea6e61f8cc5ef4f8b73fcb"
            "7c31b655b76fda5d5f1270feb2d1eedd94ff89ab5b5f17ef9b5015111f972388"
            "f6e64de2ac18b9b01c49ca62cc21fe7cecb7ace7127e355d7624259af8754f55"
        ]
    let actualJson: string = cleanJson inputJson
    let doc = JsonDocument.Parse(actualJson)
    let fileItems = doc.RootElement.GetProperty("file-items")
    let actualIk : Set<string> =
        fileItems.EnumerateArray()
        |> Seq.map (fun item -> item.GetProperty("ik").GetString())
        |> Set.ofSeq
    Assert.Equal<string>(expectedIk, actualIk)
