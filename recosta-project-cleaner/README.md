# recosta-project-cleaner

F# CLI tool for cleaning up Recotte Studio (レコスタ) project JSON files by removing unused file references.

## Usage

1. Build the project:

   ```sh
   dotnet build
   ```

2. Run the tool:

   ```sh
   dotnet run -- <options>
   ```

## Features

- Removes unused file references from Recotte Studio project JSON files
- Designed for Windows CLI

## Requirements

- .NET 5.0 SDK or later

## Build Release Binary

To build a self-contained release binary (Windows x64):

```sh
# From the project root
 dotnet publish src/recosta-project-cleaner/recosta-project-cleaner.fsproj -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true -o ./publish/win-x64
```

The output binary will be in the `publish/win-x64` directory.

## License
MIT License
