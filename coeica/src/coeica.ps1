Param(
  [Parameter(Mandatory)]
  [string]$speakerName,
  [Parameter(Mandatory)]
  $text,
  [Parameter(Mandatory)]
  $output,
  # パラメータのリファレンス：
  # COEIROINK(v2) http://127.0.0.1:50032/docs
  $speedScale = 1.0,
  $pitchScale = 0.0,
  $intonationScale = 1.0,
  $volumeScale = 1.0,
  $prePhonemeLength = 0.1,
  $postPhonemeLength = 0.1,
  $outputSamplingRate = 44100,
  $outputStereo = $false
)

$speaker = Find-Speaker($speakerName)

Synthesis-Talk($speaker, $text, $output)
