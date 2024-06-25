# Nombre del servicio que deseas verificar
$nombreServicio = "VeyonService"

# Verificar si el servicio está en ejecución
$estadoServicio = Get-Service -Name $nombreServicio | Select-Object -ExpandProperty Status

# Comprobar el estado del servicio
if ($estadoServicio -eq 'Running') {
    Write-Host "El servicio ya está en ejecución. No es necesario hacer nada."
} else {
    Write-Host "El servicio no está en ejecución. Iniciando el servicio..."
    
    # Iniciar el servicio
    Start-Service -Name $nombreServicio
}
