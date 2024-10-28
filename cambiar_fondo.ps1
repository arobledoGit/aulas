# Limpiar la pantalla
Clear-Host

# Lista de imágenes disponibles
$opciones = @(
    "fondo-remotePC.jpg",
    "fondo-docencia.jpg",
    "fondo-tic.jpg",
    "fondo-provisional.jpg"
)

# Mostrar las opciones al usuario
Write-Host "Selecciona la imagen que deseas usar como fondo de escritorio:
"
for ($i = 0; $i -lt $opciones.Length; $i++) {
    Write-Host "$($i + 1). $($opciones[$i])"
}

# Solicitar la opción del usuario
$seleccion = Read-Host "
Ingresa el número de la opción deseada"

# Verificar si la entrada es válida
if ($seleccion -match '^\d+$' -and $seleccion -gt 0 -and $seleccion -le $opciones.Length) {
    $desk_image = $opciones[$seleccion - 1]
    Write-Host "La imagen seleccionada es: $desk_image"
} else {
    Write-Host "Selección inválida. Saliendo del script."
    exit
}

# Verificamos la existencia de la ruta donde se guardará el icono o la creamos
$Path = "c:\unitic\images"
if (-not (Test-Path -Path $Path)) {
    New-Item -Path $Path -ItemType Directory -Force
    Write-Host "La ruta '$Path' ha sido creada correctamente."
} else {
    Write-Host "La ruta '$Path' ya existe. No se ha creado ninguna carpeta nueva"
}

# Eliminamos la imagen de fondo, si existe, en el directorio local.
$FilePath = "$Path\$desk_image"
if (Test-Path -Path $FilePath -PathType Leaf) {
    Remove-Item -Path $FilePath -Force
    Remove-Item -Path "$Path\fondo.jpg" -Force
    Write-Host "El archivo '$desk_image' ha sido eliminado correctamente."
} else {
    Write-Host "El archivo '$desk_image' no existe. Copiamos el fichero en el directorio '$Path'"
}

# Ruta del icono alojado en GitHub
$imageUrl = "https://raw.githubusercontent.com/arobledoGit/aulas/main/images/$desk_image"

# Descargar el icono desde GitHub
Invoke-WebRequest -Uri $imageUrl -OutFile "$Path\fondo.jpg"

# Establecemos la variable de la ruta de imagen
$imagenFondoEscritorio = "$Path\fondo.jpg"

# Verificar si la operación fue exitosa
if (Test-Path $imagenFondoEscritorio) {
    # Cambiar el fondo de escritorio
    $SPI_SETDESKWALLPAPER = 0x0014
    $SystemParametersInfo = Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@
    [Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $imagenFondoEscritorio, 3)
    Write-Host "La operación se ha realizado con éxito. El fondo de escritorio se ha actualizado."
}
else {
    Write-Host "Ha ocurrido un error. No se encontró la imagen del fondo de escritorio."
}
