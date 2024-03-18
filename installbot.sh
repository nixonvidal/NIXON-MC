#!/bin/bash

# Función para mostrar el menú
mostrar_menu() {
    clear
    echo "Menú de Instalación BOT PYTHON"
    echo "------------------------------"
    echo "1. Instalar python 3.12.2"
    echo "2. Instalar paquetes pip"
    echo "3. Extraer los archivos BOT"
    echo "4. INICIAR BOT PYTHON"
    echo "5. DETENER BOT PYTHON"
    echo "6. Salir"
    echo "------------------------------"
}

# Función para instalar paquete A
instalar_python() {
    # Colores para resaltar los mensajes
    GREEN='\033[0;32m'
    NC='\033[0m' # No Color

    # Función para limpiar la pantalla
    clear_screen() {
        if [ "$OSTYPE" == "linux-gnu" ]; then
            clear
        elif [ "$OSTYPE" == "darwin"* ]; then
            clear
        elif [ "$OSTYPE" == "cygwin" ]; then
            clear
        elif [ "$OSTYPE" == "msys" ]; then
            clear
        elif [ "$OSTYPE" == "win32" ]; then
            cls
        fi
    }

    # Función para instalar Python 3.12.2
    install_python() {
        clear_screen
        echo -e "${GREEN}Iniciando la instalación de Python 3.12.2...${NC}"
        if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
            echo "Este script solo está diseñado para sistemas Unix-like. Por favor, instala Python manualmente en Windows."
            exit 1
        fi

        # Actualiza el sistema
        sudo apt update
        sudo apt upgrade -y

        # Instala las dependencias necesarias
        sudo apt install -y build-essential libssl-dev wget

        # Descarga el código fuente de Python 3.12.2
        wget https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tgz

        # Descomprime el archivo
        tar -xzvf Python-3.12.2.tgz

        # Navega al directorio Python-3.12.2
        cd Python-3.12.2 || exit

        # Configura y compila Python
        ./configure --enable-optimizations
        make -j"$(nproc)"

        # Instala Python
        sudo make altinstall

        # Agrega el nuevo PATH al archivo ~/.bashrc
        echo 'export PATH=/usr/local/bin:$PATH' >>~/.bashrc

        # Recarga el archivo ~/.bashrc
        source ~/.bashrc

        sudo ln -s /usr/local/bin/python3.12 /usr/local/bin/python
        sudo ln -sf $(which python3.12) $(which python)
        # Verifica la instalación
        clear_screen
        echo -e "${GREEN}Python 3.12.2 ha sido instalado correctamente.${NC}"
        python --version
    }

    # Llama a la función para instalar Python
    install_python

    sleep 2
    echo "Paquete A instalado correctamente."
    read -p "Presiona Enter para continuar..."
}
instalar_pip() {
    clear
    echo "INSTALANDO SQLITE3..."
    sudo apt install sqlite3 -y
    echo "INSTALANDO PIP..."
    pip install pyrogram python-dotenv virtualenv

    # Verificar si la instalación fue exitosa
    if [ $? -eq 0 ]; then
        echo "La instalación de los paquetes fue exitosa."
    else
        echo "Error: No se pudo instalar uno o más paquetes."
    fi
}

# Función para instalar paquete B
instalar_extraer_BOT() {
    echo "Instalando paquete B..."
    wget https://github.com/nixonvidal/NIXON-MC/raw/master/BOT_PYTHON.zip
    mkdir -p /root/BOT
    mv BOT_PYTHON.zip /root/BOT/
    cd /root/BOT
    unzip BOT_PYTHON.zip
    chmod -R 777 /root/BOT
    rm BOT_PYTHON.zip
    sleep 2
    echo "Descargando correctamente."
    read -p "Presiona Enter para continuar..."
}

# Función para instalar paquete C
iniciar_BOT() {
    clear
    echo "Iniciando BOT"

    # Nombre del entorno virtual
    VENV_NAME="envBOT"
    # Verificar si el entorno virtual ya está creado
    if [ ! -d "$VENV_NAME" ]; then
        # Crear el entorno virtual
        virtualenv $VENV_NAME >/dev/null 2>&1
    fi
    NOMBRE_SESION="sesion_bot"
    # Verificar si la sesión ya existe
    if ! screen -ls | grep -q "$NOMBRE_SESION"; then
        # Crear la sesión y ejecutar el comando
        screen -dmS "$NOMBRE_SESION" bash -c "source /root/envBOT/bin/activate && python /root/BOT/bot.py"
    fi
    sleep 6
    echo "Iniciando correctamente."
    read -p "Presiona Enter para continuar..."
}
detener_BOT(){
    echo "DETENIENDO BOT...."
    screen -S sesion_bot -X quit
    read -p "Presiona Enter para continuar..."
}

# Ciclo principal del script
while true; do
    mostrar_menu

    # Captura la opción del usuario
    read -p "Ingresa el número de la opción deseada: " opcion

    # Evalúa la opción seleccionada
    case $opcion in
    1)
        instalar_python
        ;;
    2)
        instalar_pip
        ;;
    3)
        instalar_extraer_BOT
        ;;
    4)
        iniciar_BOT
        ;;
    5)
        detener_BOT
        ;;
    6)
        echo "Saliendo..."
        exit 0
        ;;
    *)
        echo "Opción inválida. Por favor, ingresa un número válido."
        read -p "Presiona Enter para continuar..."
        ;;
    esac
done
