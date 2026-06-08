# ==============================================================================
# CONFIGURATION GOOGLE CHROME (MOTEUR DE RECHERCHE, BOUTON ACCUEIL & TOUT PAR DÉFAUT)
# ==============================================================================

# Chemin de la clé de registre pour les politiques de Chrome
$ChromeRegPath = "HKLM:\SOFTWARE\Policies\Google\Chrome"

# Créer la clé de registre si elle n'existe pas
if (-not (Test-Path $ChromeRegPath)) {
    New-Item -Path $ChromeRegPath -Force | Out-Null
}

# ------------------------------------------------------------------------------
# 1. BOUTON ACCUEIL (Affiché + URL par défaut)
# ------------------------------------------------------------------------------
Write-Host "Configuration du bouton Accueil..." -ForegroundColor Cyan
New-ItemProperty -Path $ChromeRegPath -Name "ShowHomeButton" -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path $ChromeRegPath -Name "HomepageLocation" -Value "https://www.google.com" -PropertyType String -Force | Out-Null


# ------------------------------------------------------------------------------
# 2. MOTEUR DE RECHERCHE PAR DÉFAUT : GOOGLE
# ------------------------------------------------------------------------------
Write-Host "Configuration de Google comme moteur de recherche par défaut..." -ForegroundColor Cyan
New-ItemProperty -Path $ChromeRegPath -Name "DefaultSearchProviderEnabled" -Value 1 -PropertyType DWord -Force | Out-Null
New-ItemProperty -Path $ChromeRegPath -Name "DefaultSearchProviderName" -Value "Google" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $ChromeRegPath -Name "DefaultSearchProviderKeyword" -Value "google.com" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $ChromeRegPath -Name "DefaultSearchProviderSearchURL" -Value "https://www.google.com/search?q={searchTerms}" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $ChromeRegPath -Name "DefaultSearchProviderSuggestURL" -Value "https://www.google.com/complete/search?output=chrome&q={searchTerms}" -PropertyType String -Force | Out-Null


# ------------------------------------------------------------------------------
# 3. TOUT OUVRIR AVEC CHROME À LA PLACE D'EDGE (WEB, PDF, ETC.)
# ------------------------------------------------------------------------------
Write-Host "Remplacement d'Edge par Chrome pour les extensions par défaut (incluant PDF)..." -ForegroundColor Cyan

# Génération du fichier XML d'association incluant les protocoles web et les fichiers PDF/SVG
$xmlContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<DefaultAssociations>
  <Association Identifier=".html" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier=".htm" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier=".pdf" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier=".svg" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier="http" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
  <Association Identifier="https" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
</DefaultAssociations>
"@

$XmlPath = "$env:TEMP\AppAssociations.xml"
$xmlContent | Out-File -FilePath $XmlPath -Encoding utf8

# Application forcée des associations via l'outil système DISM
dism /online /Import-DefaultAppAssociations:$XmlPath

Write-Host "`n[SUCCÈS] Toutes les configurations ont été appliquées avec succès !" -ForegroundColor Green