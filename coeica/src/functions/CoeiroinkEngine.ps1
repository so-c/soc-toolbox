$baseUrl = "http://127.0.0.1:50032"

function Decode-String($rawResponse) {
  return [System.Text.Encoding]::UTF8.GetString([System.Text.Encoding]::GetEncoding("ISO-8859-1").GetBytes($rawResponse.Content))
}

function Invoke-Speakers() {
  $speakersRawResponse = Invoke-WebRequest -Method Get `
    -Uri "$baseUrl/v1/speakers" `
    -Headers @{ "accept" = "application/json" }
  $decodedSpeakers = Decode-String($speakersRawResponse)
  return $decodedSpeakers
}

function Invoke-EsimateProsody($text) {
  $estimateProsodyRawResponse = Invoke-WebRequest -Method Post `
    -Uri "$baseUrl/v1/estimate_prosody" `
    -Headers @{ "accept" = "application/json" } `
    -ContentType "application/json; charset=UTF-8" `
    -Body ('{"text":"'+$text+'"}')
  $decodedEstimateProsody = Decode-String($estimateProsodyRawResponse)
  return $decodedEstimateProsody
}

function Invoke-Synthesis($jsonQuery, $output) {
  Invoke-RestMethod -Method Post `
    -Uri "$baseUrl/v1/synthesis" `
    -Headers @{ "accept" = "audio/wav" } `
    -ContentType "application/json; charset=UTF-8" `
    -OutFile $output `
    -Body $jsonQuery
  return 
}
