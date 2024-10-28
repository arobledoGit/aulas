# Elegimos la imagen que queremos que aparezca como fondo de escritorio
    ### fondo-remotePC.jpg ###
    ### fondo-docencia.jpg ###
    ### fondo-tic.jpg      ###
    ### fondo-unitic.jpg   ###
	### fondo-temporal.jpg ###
	
$desk_image = "fondo-temporal.jpg"

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

# Ruta local para guardar el icono descargado
# $localIconPath = Join-Path -Path $Path -ChildPath "$desk_image"

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