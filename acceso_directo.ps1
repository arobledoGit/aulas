# Ruta de destino para el acceso directo en el escritorio del usuario
$desktopPath = [Environment]::GetFolderPath("Desktop")

# URL del sitio web
$url = "https://apoyotic.us.es"

# Establecemos un nombre para el acceso directo
$name = "ApoyoTIC"

# Elegimos el nombre del icono
$icon = "fama.ico"

# Verificamos la existencia de la ruta donde se guardará el icono o la creamos
$Path = "c:\unitic\iconos"
if (-not (Test-Path -Path $Path)) {
    New-Item -Path $Path -ItemType Directory -Force
    Write-Host "La ruta '$Path' ha sido creada correctamente."
} else {
    Write-Host "La ruta '$Path' ya existe. No se ha creado ninguna carpeta nueva"
}

# Eliminamos el icono si existe en el directorio local.
$FilePath = "$Path\$icon"
if (Test-Path -Path $FilePath -PathType Leaf) {
    Remove-Item -Path $FilePath -Force
    Write-Host "El archivo '$icon' ha sido eliminado correctamente."
} else {
    Write-Host "El archivo '$icon' no existe. No se ha borrado nada"
}

# Ruta del icono alojado en GitHub
$iconUrl = "https://raw.githubusercontent.com/arobledoGit/aulas/main/iconos/$icon"

# Ruta local para guardar el icono descargado
$localIconPath = Join-Path -Path $Path -ChildPath "$icon"

# Descargar el icono desde GitHub
Invoke-WebRequest -Uri $iconUrl -OutFile $localIconPath

# Crear el acceso directo
$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut("$desktopPath\$name.lnk")
$shortcut.TargetPath = $url
$shortcut.IconLocation = $localIconPath
$shortcut.Save()

# Limpiar variables
Remove-Variable -Name shell, shortcut