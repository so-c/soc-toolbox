function Rename-SVCFFolders {
    Write-Host 'SynthV CFリターンとして配信されたzipファイルのうち、第43～52回がFantiaでの配布とフォルダ構成が異なります。このスクリプトはFantiaの構成に合わせます'
    @('043', '044', '045', '046', '048') | ForEach-Object {
        Move-Item -Pass "$destDir\Sample_voice_${_}_wav\Sample_voice_${_}_for500円プラン" `
            -Destination "$destDir\Sample_voice_${_}_for500"
        Move-Item -Pass "$destDir\Sample_voice_${_}_wav\Sample_voice_${_}_for1000円プラン" `
            -Destination "$destDir\Sample_voice_${_}_for1000"
        Move-Item -Pass "$destDir\Sample_voice_${_}_wav\Sample_voice_${_}_free" `
            -Destination "$destDir\Sample_voice_${_}_free"
        Remove-Item -Path "$destDir\Sample_voice_${_}_wav"
    }

    @('047', '049', '050', '051', '052') | ForEach-Object {
        Move-Item -Pass "$destDir\Sample_voice_${_}_wav\Sample_voice_${_}_for500" `
            -Destination "$destDir\Sample_voice_${_}_for500"
        Move-Item -Pass "$destDir\Sample_voice_${_}_wav\Sample_voice_${_}_for1000" `
            -Destination "$destDir\Sample_voice_${_}_for1000"
        Move-Item -Pass "$destDir\Sample_voice_${_}_wav\Sample_voice_${_}_free" `
            -Destination "$destDir\Sample_voice_${_}_free"
        Remove-Item -Path "$destDir\Sample_voice_${_}_wav"
    }

    # XXX: 空フォルダ"wav_SynthesizerV CF向け限定ボイス（5000円プラン以上向け）"が作成されるので削除する
    Remove-Item -Path "$destDir\wav_SynthesizerV CF向け限定ボイス（5000円プラン以上向け）"

    Write-Host '上記のフォルダにリネームしました'
}
