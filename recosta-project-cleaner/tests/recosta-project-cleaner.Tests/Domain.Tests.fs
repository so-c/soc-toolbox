module RecostaProjectCleaner.DomainTests

open Xunit
open RecostaProjectCleaner.Domain
open System.Text.Json.Nodes

// Helper to create a dummy JsonNode
let private createDummyJsonNode () = JsonNode.Parse("{}")

let private createProject () =
    let ik1 = Ik "ik1"
    let ik2 = Ik "ik2"
    let ik3 = Ik "ik3"
    let fileItem1 = { Ik = ik1; OriginalNode = createDummyJsonNode () }
    let fileItem2 = { Ik = ik2; OriginalNode = createDummyJsonNode () }
    let fileItem3 = { Ik = ik3; OriginalNode = createDummyJsonNode () }

    let layerObject1 = { UsedFileIk = Some ik1 }
    let layerObject2 = { UsedFileIk = Some ik2 }
    let layerObject3 = { UsedFileIk = None } // No file

    let layer1 = { Objects = [ layerObject1 ] }
    let layer2 = { Objects = [ layerObject2; layerObject3 ] }

    {
        FileItems = [ fileItem1; fileItem2; fileItem3 ]
        Layers = [ layer1; layer2 ]
    }

[<Fact>]
let ``getUsedIks extracts all Iks from layers`` () =
    let project = createProject ()
    let expected = Set.ofList [ Ik "ik1"; Ik "ik2" ]
    let actual = Project.getUsedIks project
    Assert.Equal<Ik>(expected, actual)

[<Fact>]
let ``clean removes unused FileItems from Project`` () =
    let project = createProject ()
    let cleanedProject = Project.clean project
    let expectedIks = Set.ofList [ Ik "ik1"; Ik "ik2" ]
    let actualIks =
        cleanedProject.FileItems
        |> List.map (fun item -> item.Ik)
        |> Set.ofList
    Assert.Equal<Ik>(expectedIks, actualIks)
