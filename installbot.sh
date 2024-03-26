#!/bin/bash

# Colores para resaltar los mensajes
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Función para limpiar la pantalla
limpiar_pantalla() {
    clear
}

# Función para instalar Python
instalar_python() {
    limpiar_pantalla
    echo -e "${GREEN}Iniciando la instalación de Python 3.12.2...${NC}"
    if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
        echo "Este script solo está diseñado para sistemas Unix-like. Por favor, instala Python manualmente en Windows."
        exit 1
    fi

    # Actualizar el sistema
    sudo apt update
    sudo apt upgrade -y

    # Instalar las dependencias necesarias
    sudo apt install -y build-essential libssl-dev wget

    # Descargar el código fuente de Python 3.12.2
    wget https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tgz

    # Descomprimir el archivo
    tar -xzvf Python-3.12.2.tgz

    # Navegar al directorio Python-3.12.2
    cd Python-3.12.2 || exit

    # Configurar y compilar Python
    ./configure --enable-optimizations
    make -j"$(nproc)"

    # Instalar Python
    sudo make altinstall

    # Agregar el nuevo PATH al archivo ~/.bashrc
    echo 'export PATH=/usr/local/bin:$PATH' >>~/.bashrc

    # Recargar el archivo ~/.bashrc
    source ~/.bashrc

    # Verificar la instalación
    limpiar_pantalla
    echo -e "${GREEN}Python 3.12.2 ha sido instalado correctamente.${NC}"
    python --version
}

# Función para instalar paquetes pip
instalar_pip() {
    limpiar_pantalla
    echo "INSTALANDO SQLITE3..."
    sudo apt install sqlite3 -y
    echo "INSTALANDO PIP..."
    # Nombre del entorno virtual
    VENV_NAME="envBOT"
    # Verificar si el entorno virtual ya está creado
    if [ ! -d "$VENV_NAME" ]; then
        # Crear el entorno virtual
        virtualenv "$VENV_NAME" >/dev/null 2>&1
    fi
    source /root/envBOT/bin/activate
    cd /root/BOT || exit
    pip install pyrogram python-dotenv virtualenv requests

    # Verificar si la instalación fue exitosa
    if [ $? -eq 0 ]; then
        echo "La instalación de los paquetes fue exitosa."
    else
        echo "Error: No se pudo instalar uno o más paquetes."
    fi
}

# Función para instalar y extraer archivos del BOT
instalar_extraer_BOT() {
    limpiar_pantalla
    echo "Instalando paquete B..."
    wget https://github.com/nixonvidal/NIXON-MC/raw/master/BOT_PYTHON.zip
    mkdir -p /root/BOT
    mv BOT_PYTHON.zip /root/BOT/
    cd /root/BOT || exit
    unzip BOT_PYTHON.zip
    chmod -R 777 /root/BOT
    rm BOT_PYTHON.zip
    echo "Descargando correctamente."
    read -p "Presiona Enter para continuar..."
}

# Función para iniciar el BOT
iniciar_BOT() {
    limpiar_pantalla
    echo "Iniciando BOT"

    # Nombre del entorno virtual
    VENV_NAME="envBOT"
    # Verificar si el entorno virtual ya está creado
    if [ ! -d "$VENV_NAME" ]; then
        # Crear el entorno virtual
        virtualenv "$VENV_NAME" >/dev/null 2>&1
    fi
    NOMBRE_SESION="sesion_bot"
    # Verificar si la sesión ya existe
    if ! screen -ls | grep -q "$NOMBRE_SESION"; then
        # Crear la sesión y ejecutar el comando
        source /root/envBOT/bin/activate && cd /root/BOT && screen -dmS sesion_bot python bot.py > /dev/null 2>&1
    fi
    echo "Iniciando correctamente."
    read -p "Presiona Enter para continuar..."
}

# Función para detener el BOT
detener_BOT() {
    limpiar_pantalla
    echo "DETENIENDO BOT...."
    screen -S sesion_bot -X quit
    echo "Bot detenido correctamente."
    read -p "Presiona Enter para continuar..."
}

# Función para mostrar el menú
mostrar_menu() {
    limpiar_pantalla
    echo "Menú de Instalación BOT PYTHON"
    echo "------------------------------"
    echo "1. Instalar python 3.12.2"
    echo "2. Extraer los archivos BOT"
    echo "3. Instalar paquetes pip"
    echo "4. INICIAR BOT PYTHON"
    echo "5. DETENER BOT PYTHON"
    echo "6. Salir"
    echo "------------------------------"
}

# Ciclo principal del script
while true; do
    mostrar_menu

    # Capturar la opción del usuario
    read -p "Ingresa el número de la opción deseada: " opcion

    # Evaluar la opción seleccionada
    case $opcion in
        1) instalar_python ;;
       
