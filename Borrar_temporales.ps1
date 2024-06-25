# Obtiene la lista de perfiles de usuario en el sistema
$perfiles = Get-ChildItem -Path "C:\Users" -Directory

# Recorre cada perfil de usuario
foreach ($perfil in $perfiles) {
    $usuario = $perfil.Name
    $rutaTemporal = "C:\Users\$usuario\AppData\Local\Temp"

    # Verifica si la ruta temporal existe para el usuario actual
    if (Test-Path $rutaTemporal) {
        # Obtiene el tamaño de la carpeta temporal antes de eliminar los archivos
        $tamanoAntes = Get-ChildItem -Path $rutaTemporal -Recurse | Measure-Object -Property Length -Sum

        # Borra los archivos temporales
        Remove-Item -Path $rutaTemporal\* -Force -Recurse 2> $null

        # Obtiene el tamaño de la carpeta temporal después de eliminar los archivos
        $tamanoDespues = Get-ChildItem -Path $rutaTemporal -Recurse | Measure-Object -Property Length -Sum

        # Calcula el tamaño eliminado
        $tamanoEliminado = $tamanoAntes.Sum - $tamanoDespues.Sum

        # Imprime el resumen del volumen de datos eliminados por el usuario actual
        Write-Host "Usuario: $usuario"
        Write-Host "Tamaño antes de eliminar: $($tamanoAntes.Sum / 1MB) MB"
        Write-Host "Tamaño después de eliminar: $($tamanoDespues.Sum / 1MB) MB"
        Write-Host "Tamaño eliminado: $($tamanoEliminado / 1MB) MB"
        Write-Host "---------------------------------------------"
    }
    # else {
    #    Write-Host "No se encontró la ruta temporal para el usuario: $usuario"
    #}
}