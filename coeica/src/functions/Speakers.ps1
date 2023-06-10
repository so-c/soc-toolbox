$baseUrl = "http://127.0.0.1:50032"

function Get-NormalizedSpeakers() {
  $speakersRawResponse = Invoke-WebRequest -Method Get -Uri "$baseUrl/v1/speakers" -Headers @{"accept" = "application/json" }
  $decodedSpeakers = [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::GetEncoding("ISO-8859-1").GetBytes($speakersRawResponse.Content))
  $minifiedSpeakers = $decodedSpeakers -replace ',(\"base64Icon\":|\"base64Portrait\":)(\".+?\"|null)', ''
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
