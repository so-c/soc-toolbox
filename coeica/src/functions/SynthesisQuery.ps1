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
    Remove-TypeData -TypeName System.Array
    $jsonQuery = (ConvertTo-Json $this.Build() -Depth 16 -Compress)
    Invoke-Synthesis　$jsonQuery $output;
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

  [PSCustomObject]GetProsody() {
    $prosodyResponse = Invoke-EsimateProsody($this.text)
    return (ConvertFrom-Json $prosodyResponse).detail
  }

}