# Verificar si existe una unidad con la letra E:
$driveE = Get-WmiObject -Query "SELECT * FROM Win32_Volume WHERE DriveLetter = 'E:'"

if ($driveE) {
    # Verificar si la letra de unidad X: está en uso
    $driveX = Get-WmiObject -Query "SELECT * FROM Win32_Volume WHERE DriveLetter = 'X:'"
    
    if ($driveX) {
        # Si la letra de unidad X: está en uso, cambiar la letra de unidad E: a Z:
        try {
            $driveE.DriveLetter = 'Z:'
            $driveE.Put()
            Write-Output "La unidad E: ha sido cambiada a Z:."
        } catch {
            Write-Output "Ocurrió un error al cambiar la letra de la unidad E: a Z:: $_"
        }
    } else {
        # Si la letra de unidad X: no está en uso, cambiar la letra de unidad E: a X:
        try {
            $driveE.DriveLetter = 'X:'
            $driveE.Put()
            Write-Output "La unidad E: ha sido cambiada a X:."
        } catch {
            Write-Output "Ocurrió un error al cambiar la letra de la unidad E: a X:: $_"
        }
    }
} else {
    Write-Output "No se encontró ninguna unidad con la letra E:."
}

# Buscar el volumen con el nombre 'Vbox_img'
$volume = Get-WmiObject -Query "SELECT * FROM Win32_Volume WHERE Label = 'Vbox_img'"

if ($volume) {
    try {
        # Asignar la letra de unidad E: al volumen encontrado
        $volume.DriveLetter = 'E:'
        $volume.Put()
        Write-Output "La letra de unidad E: ha sido asignada al volumen con el nombre 'Vbox_img'."
    } catch {
        Write-Output "Ocurrió un error al asignar la letra de unidad: $_"
    }
} else {
    Write-Output "No se encontró ningún volumen con el nombre 'Vbox_img'."
}
