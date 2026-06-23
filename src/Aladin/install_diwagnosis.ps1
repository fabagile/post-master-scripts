$version = "Diwagnosis 3.53"
$file = "\\files-srv07.semitan.lan\logiciels$\Gestion de Parc\Logiciels - Drivers - Patchs\Logiciels\Logiciels BUS\Aladin Voith\Version 6-4\Diwagnosis 3.53\DIWAgnosis353Setup.exe" -F $version 
# Copy-Item -Path "\\files-srv07\logiciels$\Gestion de Parc\Logiciels - Drivers - Patchs\Logiciels\suite Adobe CC\Creative_Cloud_Set-Up.exe" -Destination $file
write-host $file
# Start-Process $file