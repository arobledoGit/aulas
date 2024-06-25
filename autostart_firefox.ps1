$browserPath = "C:\Program Files\Mozilla Firefox\firefox.exe"  # Ruta del navegador, actualízala si es necesario

while ($true) {
    $process = Get-Process -Name firefox -ErrorAction SilentlyContinue
    if (-not $process) {
        Start-Process $browserPath
    }
    Start-Sleep -Seconds 2
}
