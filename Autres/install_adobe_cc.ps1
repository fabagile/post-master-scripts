$file = "c:\temp\Creative_Cloud_Set-Up.exe"
Copy-Item -Path "\\files-srv07\logiciels$\Gestion de Parc\Logiciels - Drivers - Patchs\Logiciels\suite Adobe CC\Creative_Cloud_Set-Up.exe" -Destination $file
Start-Process $file