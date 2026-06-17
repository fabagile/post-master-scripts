
$url = "https://ftp.ext.hp.com/pub/caps-softpaq/cmit/HPIA.html"
$html = Invoke-RestMethod -Uri $url

# 2. Isoler le contenu à l'intérieur du tbody
if ($html -match '(?s)<tbody>(.*?)<\/tbody>') {
    $tbodyContent = $Matches[1]
    
    # 3. Extraire le contenu de TOUTES les cellules (<td>...</td>) à l'intérieur de ce tbody
    # La regex capture tout ce qui se trouve entre <td> et </td>
    $tdPattern = '(?s)<td>(.*?)<\/td>'
    $cellules = [regex]::Matches($tbodyContent, $tdPattern) | ForEach-Object { $_.Groups[1].Value.Trim() }
    
    # 4. Récupérer la première et la dernière cellule
    if ($cellules.Count -ge 1) {
        $version = $cellules[0]
        $softPaq = $cellules[-1] # L'index -1 récupère automatiquement le dernier élément en PowerShell
        
        # Nettoyage rapide au cas où la dernière cellule contient une balise HTML (comme un lien <a>)
        if ($softPaq -match '>(.*?)<\/a>') {
            $softPaq = $Matches[1].Trim()
        }
        
        # 5. Affichage des résultats
        $versionUrl = "https://hpia.hpcloud.hp.com/downloads/hpia/hp-hpia-{0}.exe" -F $version
        "Telechargement: {0}" -F $versionUrl
        # $versionUrl
        $prog = "C:\temp\hpia-{0}.exe" -F $version
        Invoke-WebRequest -Uri $versionUrl -OutFile $prog 
        "Installation en cours..."
        Start-Process $prog -Wait
        "Installation terminee"
        Remove-Item -Path $prog -Force

        # 1. Récupérer le nom de l'utilisateur connecté à l'écran
$loggedUser = (Get-CimInstance Win32_ComputerSystem).UserName.Split('\')[1]

# 2. Récupérer le SID de cet utilisateur pour fouiller dans le Registre HKEY_USERS
$userSID = (New-Object System.Security.Principal.NTAccount($loggedUser)).Translate([System.Security.Principal.SecurityIdentifier]).Value

# 3. Lire le chemin réel du Bureau directement dans le Registre Windows
$registryPath = "Registry::HKEY_USERS\$userSID\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders"
$desktopPath = (Get-ItemProperty -Path $registryPath).Desktop

# 4. Construire le chemin complet du raccourci
$shortcutPath = Join-Path $desktopPath "HPImageAssistant.lnk"

        # 2. Vérifier si le raccourci existe dans la session actuelle
        if (Test-Path $shortcutPath) {
            $wshShell = New-Object -ComObject WScript.Shell
            $shortcut = $wshShell.CreateShortcut($shortcutPath)

            # 3. Mise à jour des champs avec le bon SoftPaq
            $shortcut.TargetPath = "C:\SWSetup\$softPaq\HPImageAssistant.exe"
            $shortcut.WorkingDirectory = "C:\SWSetup\$softPaq\"

            # 4. Validation
            $shortcut.Save()

            Write-Host "Le raccourci de l'utilisateur courant a été mis à jour ($softPaq)." -ForegroundColor Green
        }
        else {
            Write-Host "Raccourci introuvable sur le bureau de cet utilisateur." -ForegroundColor Yellow
        }
    }
}
else {
    Write-Host "Impossible de trouver la balise <tbody> dans la page." -ForegroundColor Red
}