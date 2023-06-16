# 話者（音源）を取得する静的メソッド

. $PSScriptRoot\CoeiroinkEngine.ps1

function Get-NormalizedSpeakers() {
  $speakersRawResponse = Invoke-Speakers
  $minifiedSpeakers = $speakersRawResponse -replace ',(\"base64Icon\":|\"base64Portrait\":)(\".+?\"|null)', ''
  $speakers = ($minifiedSpeakers | ConvertFrom-Json)
  return $speakers
}

function Find-Speaker($speakerName) {
  $speakers = Get-NormalizedSpeakers

  $uuid = ($speakers | Where-Object { $speakerName.StartsWith($_.speakerName) }).speakerUuid
  $styles = ($speakers | Where-Object speakerUuid -eq $uuid).styles

  $styleId = $styles[0].styleId
  $styles | ForEach-Object {
    if ($speakerName -contains $_.styleName ) {
      $styleId = $_.styleId
    }
  }

  return @{
    uuid    = $uuid
    styleId = $styleId
  }
  
}
