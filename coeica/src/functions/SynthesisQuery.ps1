# 音声合成クエリを表すクラス

. $PSScriptRoot\CoeiroinkEngine.ps1

class SynthesisQuery {
  $speaker
  $text
  $params
  $queryBody

  SynthesisQuery(
    $speaker,
    $text,
    $params
  ) {
    $this.speaker = $speaker
    $this.text = $text
    $this.params = $params
  }

  [Void]Execute($output) {
    $jsonQuery = ToJsonString
    Invoke-Synthesis　$jsonQuery $output;
  }

  [string]ToJsonString() {
    return (ConvertTo-Json $this.Build() -Depth 16 -Compress)
  }

  [PSCustomObject]Build() {
    $queryPrameters = @{
      speakerUuid   = $this.speaker.uuid
      styleId       = $this.speaker.styleId
      text          = $this.text
      prosodyDetail = $this.GetProsody()
    }
    
    return $queryPrameters + $this.params
  }

  [System.Collections.ArrayList]GetProsody() {
    $prosodyResponse = Invoke-EsimateProsody($this.text)
    $prosodyJson = (ConvertFrom-Json $prosodyResponse)
    $detailArrayList = [System.Collections.ArrayList]::new()
    foreach ($d in $prosodyJson.detail) {
      $detailArrayList.add($d)
    }
    return $detailArrayList
  }

}