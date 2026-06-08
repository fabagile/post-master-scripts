$prog = "C:\temp\hpia.exe"
Invoke-WebRequest -Uri "https://hpia.hpcloud.hp.com/downloads/hpia/hp-hpia-5.3.4.exe" -OutFile $prog
Start-Process $prog