$version = "Aladin 7.1.6"
$file = "\\files-srv07\logiciels$\Gestion de Parc\Logiciels - Drivers - Patchs\Logiciels\Logiciels BUS\Aladin Voith\{0}\setup.exe" -F $version 
# Copy-Item -Path "\\files-srv07\logiciels$\Gestion de Parc\Logiciels - Drivers - Patchs\Logiciels\suite Adobe CC\Creative_Cloud_Set-Up.exe" -Destination $file
# write-host $file
Start-Process $file