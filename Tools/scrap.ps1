# 1. Récupérer le HTML de la page HP
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
        Write-Host "--- Résultats ---" -ForegroundColor Cyan
        Write-Host "Version : $version" -ForegroundColor Green
        Write-Host "SoftPaq : $softPaq" -ForegroundColor Green
        $versionUrl = "https://hpia.hpcloud.hp.com/downloads/hpia/hp-hpia-{0}.exe" -F $version
        $versionUrl
    }
} else {
    Write-Host "Impossible de trouver la balise <tbody> dans la page." -ForegroundColor Red
}