function Invoke-List {
    [cmdletbinding()]
    param(
        [parameter(Mandatory = $true)]
        [string]$Name
        # [Alias("Fileformat")]
        # [string]$Extension
    )
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $listfile = ".\lists\{0}.txt" -F $Name
    $funcs = Get-Content -Path $listfile | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '\S' }
    
    
    $funcs | ForEach-Object {
        $dir = ".\src\{0}" -F $Name
        $scriptPath = Join-Path -Path $dir -ChildPath "$_.ps1"
        
        "Lancement de {0}" -F $scriptPath
        
                
        $button = Read-Host "- V pour continuer (validate)`n- X pour passer`n- C pour annuler (cancel)"

        $continue = ($button.ToUpper()) -eq "V"
        $skip = ($button.ToUpper()) -eq "X"
        $cancel = ($button.ToUpper()) -eq "C"
        $button

        if ($cancel) {
            continue
        }
        if ($continue) {
            & $scriptPath
            # $scriptPath
        } 
        if ($skip) {
            "Passage au processus suivant`n"
        }

    }
}
