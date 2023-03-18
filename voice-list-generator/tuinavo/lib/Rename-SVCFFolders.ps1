function Move-ChildFolders($zipNumber, $planName, $destDir) {
    foreach ($zn in $zipNumber) {
        foreach ($pn in $planName.Keys ) {
            if (Test-Path ("$destDir\Sample_voice_${zn}_wav\Sample_voice_${zn}_${pn}")) {
                Move-Item -Pass "$destDir\Sample_voice_${zn}_wav\Sample_voice_${zn}_${pn}" `
                    -Destination "$destDir\Sample_voice_${zn}_$($planName[$pn])" >$null
                Remove-Item -Path "$destDir\Sample_voice_${zn}_wav"
            } 
        }
    }
}

function Rename-SVCFFolders($destDir) {
    $zipNumber1 = @('043', '044', '045', '046', '048')
    $planName1 = @{
        'for500円プラン'  = 'for500';
        'for1000円プラン' = 'for1000';
        'free'        = 'free'
    }
    Move-ChildFolders $zipNumber1 $planName1 $destDir

    $zipNumber2 = @('047', '049', '050', '051', '052')
    $planName2 = @{
        'for500'  = 'for500';
        'for1000' = 'for1000';
        'free'    = 'free'
    }
    Move-ChildFolders $zipNumber2 $planName2 $destDir

    # XXX: 空フォルダ"wav_SynthesizerV CF向け限定ボイス（5000円プラン以上向け）"が作成されるので削除する
    $svcf5000Folder = "$destDir\wav_SynthesizerV CF向け限定ボイス（5000円プラン以上向け）"
    if (Test-Path ($svcf5000Folder)) {
        if ((Get-ChildItem $svcf5000Folder | Measure-Object ).count -eq 0) {
            Remove-Item -Path "$destDir\wav_SynthesizerV CF向け限定ボイス（5000円プラン以上向け）"
        }
    }
}
