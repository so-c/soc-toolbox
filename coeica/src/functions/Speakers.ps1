# 話者（音源）を取得する静的メソッド

. $PSScriptRoot\CoeiroinkEngine.ps1

function Find-Speaker($speakerName) {
  $speakers = Get-NormalizedSpeakers

  $speaker = Find-SpeakerByName $speakerName $speakers
  $uuid = $speaker.speakerUuid
  $styleId = Find-StyleByName $speakerName $speaker.styles

  return @{
    uuid    = $uuid
    styleId = $styleId
  }
}

function Get-NormalizedSpeakers() {
  $speakersRawResponse = Invoke-Speakers
  $minifiedSpeakers = $speakersRawResponse -replace ',(\"base64Icon\":|\"base64Portrait\":)(\".+?\"|null)', ''
  $speakers = ($minifiedSpeakers | ConvertFrom-Json)
  return $speakers
}


function Find-SpeakerByName($name, $speakers) {
  $longestMatch = $null
  $maxLength = 0

  $speakers | ForEach-Object {
    $speakerName = $($_.speakerName)
    if ($name.StartsWith($speakerName)) {
      $l = $speakerName.length
      if ($l -gt $maxLength) {
        $longestMatch = $_
        $maxLength = $l
      }
    }
  }

  return $longestMatch
}

function Find-StyleByName($name, $styles) {
  $longestMatch = $styles[0].styleId
  $maxLength = 0

  $styles | ForEach-Object {
    $styleName = $($_.styleName)
    if ($name.Contains($styleName)) {
      $l = $styleName.length
      if ($l -gt $maxLength) {
        $longestMatch = $($_.styleId)
        $maxLength = $l
      }
    }
  }

  return $longestMatch
}
