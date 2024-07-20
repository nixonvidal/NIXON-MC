#!/bin/bash

# Salir inmediatamente si un comando falla
set -e

# Función para mostrar mensajes de error
function error {
    echo "Error en la línea $1"
    exit 1
}

# Capturar errores
trap 'error $LINENO' ERR

# URL del archivo zip a descargar (reemplaza con tu URL)
ZIP_URL="https://github.com/nixonvidal/NIXON-MC/blob/master/bot_w.zip"

# Nombre del archivo zip descargado
ZIP_FILE="bot_w.zip"

# Instalar fnm (Fast Node Manager)
echo "Instalando fnm (Fast Node Manager)..."
curl -fsSL https://fnm.vercel.app/install | bash

# Agregar fnm al PATH en la sesión actual
export PATH=$HOME/.fnm/bin:$PATH
eval "$(fnm env)"

# Instalar y usar la versión 22 de Node.js si no está ya instalada
echo "Instalando y usando la versión 22 de Node.js..."
fnm use --install-if-missing 22

# Verificar la instalación de Node.js y npm
echo "Verificando la instalación..."
node -v
npm -v

echo "Instalación completa."

# Descargar el archivo zip
echo "Descargando el archivo zip..."
curl -o $ZIP_FILE $ZIP_URL

# Crear la carpeta bot_w y extraer el contenido del archivo zip en ella
echo "Creando la carpeta bot_w y extrayendo el contenido del archivo zip..."
mkdir -p bot_w
unzip -o $ZIP_FILE -d bot_w

# Eliminar el archivo zip descargado
rm $ZIP_FILE

echo "Archivo zip descargado y extraído en la carpeta bot_w."

# Ejecutar npm install en la carpeta bot_w
echo "Ejecutando npm install en la carpeta bot_w..."
cd bot_w
npm install

echo "npm install completado en la carpeta bot_w."
