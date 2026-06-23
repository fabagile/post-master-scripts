$volumeName = "INTENSO"

# 1. Trouver la lettre du lecteur associée à ce nom
$driveLetter = (Get-Volume -FileSystemLabel $volumeName).DriveLetter

# 2. Vérifier si le volume a bien été trouvé
if ($driveLetter) {
    $driveLetter = "$($driveLetter):"
    
    # 3. Procéder à l'éjection propre
    $shell = New-Object -ComObject Shell.Application
    $volume = $shell.Namespace(17).ParseName($driveLetter)
    $volume.InvokeVerb("Eject")
    
    Write-Host "Le volume '$volumeName' ($driveLetter) a été éjecté avec succès." -ForegroundColor Green
} else {
    Write-Warning "Le volume nommé '$volumeName' n'a pas été trouvé ou n'est pas connecté."
}