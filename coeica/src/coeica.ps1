Param(
  [Parameter(Mandatory)]
  [string]$speakerName,
  [Parameter(Mandatory)]
  $text,
  [Parameter(Mandatory)]
  $output,
  # パラメータのリファレンス：
  # COEIROINK(v2) http://127.0.0.1:50032/docs
  $params = @{
    speedScale         = 1.0;
    pitchScale         = 0.0;
    intonationScale    = 1.0;
    volumeScale        = 1.0;
    prePhonemeLength   = 0.1;
    postPhonemeLength  = 0.1;
    outputSamplingRate = 44100
  }
)

. $PSScriptRoot\functions\Speakers.ps1
. $PSScriptRoot\functions\SynthesisQuery.ps1

# ロガー定義
$logFile = "$PSScriptRoot\last_error.txt"
function Write-Log($msg) {
  $date = Get-Date -Format "yyyy/MM/dd HH:mm:ss"
  Write-Error "$date`t$msg" 2>&1 > $logFile
}

try {
  $speaker = Find-Speaker($speakerName)
  $synthesisQuery = [SynthesisQuery]::new($speaker, $text, $params)
  $synthesisQuery.Execute($output)
}
catch {
  Write-Log($PSItem)
  return
}
