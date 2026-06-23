$RegPath = "HKLM:\Software\Policies\Microsoft\HumanPresence"

# Créer le dossier de la stratégie s'il n'existe pas
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# 1. FORCER LA DÉSACTIVATION DU VERROUILLAGE EN CAS D'ABSENCE (Lock on Leave -> OFF)
New-ItemProperty -Path $RegPath -Name "ForceInstantLock" -Value 0 -PropertyType DWord -Force | Out-Null

# 2. FORCER LA DÉSACTIVATION DU RÉVEIL À L'APPROCHE (Wake on Approach -> OFF)
New-ItemProperty -Path $RegPath -Name "ForceInstantWake" -Value 0 -PropertyType DWord -Force | Out-Null

# 3. FORCER LA DÉSACTIVATION DE LA GRADATION ADAPTATIVE (Adaptive Dimming -> OFF)
New-ItemProperty -Path $RegPath -Name "ForceInstantDim" -Value 0 -PropertyType DWord -Force | Out-Null

Write-Host "Stratégie de groupe appliquée. Les 3 options de détection sont verrouillées sur 'Désactivé'." -ForegroundColor Yellow