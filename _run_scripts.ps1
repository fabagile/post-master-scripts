function Invoke-List {
    param(
        [parameter(Mandatory = $true)]
        [string]$Name
        # [Alias("Fileformat")]
        # [string]$Extension
    )
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $listfile = ".\liste_{0}.txt" -F $Name
    $funcs = Get-Content -Path $listfile | ForEach-Object { $_.Trim() } | Where-Object { $_ -match '\S' }
    $funcs | ForEach-Object {
        $dir = ".\{0}" -F $Name
        $_
        $scriptPath = if ($_.Contains(".bat") ) {
            $dir
            
        }
        else {
            Join-Path -Path $dir -ChildPath "$_.ps1"

        }
        "Lancement de {0}" -F $scriptPath
        
        $button = Read-Host "- V pour continuer (validate)`n- X pour passer`n- C pour annuler (cancel)"

        $continue = ($button.ToUpper()) -eq "V"
        $skip = ($button.ToUpper()) -eq "X"
        # $cancel = ($button.ToUpper()) -eq "C"

        # if ($cancel) {
        #     "Processus annulés"
        #     # Stop-Process Invoke-List
        # }
        if ($continue) {
            # "Lancement"
            & $scriptPath
        } 
        if ($skip) {
            # "OK, je zappe"
            continue
        }

        # else {Stop-Process}
    }
}
