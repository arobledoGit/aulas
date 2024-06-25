# Configuración del servidor de tiempo
$ntpServer = "hora.roa.es"

# Verificar si el servicio está en ejecución
$estadoServicio = Get-Service -Name w32time | Select-Object -ExpandProperty Status

# Comprobar el estado del servicio
if ($estadoServicio -eq 'Stopped') {
    Write-Host "El servicio está parado, hay que iniciarlo "
	Start-Service w32time
} 
else {
    Write-Host "El servicio está en ejecución. Continuamos..."
}
# Sincroniza la hora con el servidor de tiempo
w32tm /config /syncfromflags:manual /manualpeerlist:$ntpServer /update

# Reinicia el servicio de hora de Windows
Restart-Service w32time

# Espera un tiempo hasta mostrar la hora ajustada
Sleep 20

# Muestra la hora ajustada
Get-Date


