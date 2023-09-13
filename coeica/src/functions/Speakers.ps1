# 話者（音源）を取得する静的メソッド

. $PSScriptRoot\CoeiroinkEngine.ps1

# "キャラクター（スタイル）" を持つキャラクターを探し
# UUIDとStyle IDを返す
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

# キャラクターの一覧を返す
function Get-NormalizedSpeakers() {
  $speakersRawResponse = Invoke-Speakers
  $minifiedSpeakers = $speakersRawResponse -replace ',(\"base64Icon\":|\"base64Portrait\":)(\".+?\"|null)', ''
  $speakers = ($minifiedSpeakers | ConvertFrom-Json)
  return $speakers
}

# "名前（スタイル）"で指定された名前を持つキャラクターを探す
# 複数該当する場合、最長一致するキャラクターを返す
# 例） MANAが指定されたとき、MANAとMANA+のうちMANA+を返す
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

# "名前（スタイル）"で指定されたスタイルを持つキャラクターを探す
# 複数該当する場合、最長一致するスタイルを返す
# 例）「きざささやき」には「きざ」も「ささやき」も「きざささやき」も
# 含まれるが「きざささやき」を返す
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
