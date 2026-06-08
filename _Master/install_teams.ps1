$file = "C:\Temp\teams.exe"
Invoke-WebRequest -Uri "https://statics.teams.cdn.office.net/production-windows-x86/lkg/MSTeamsSetup.exe" -OutFile $file
Start-Process $file