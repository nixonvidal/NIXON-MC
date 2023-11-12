#!/bin/bash
instalar_psiphond() {
    echo "Instalando PsiphonD..."
    wget -q https://github.com/Psiphon-Labs/psiphon-tunnel-core-binaries/raw/master/psiphond/psiphond > /dev/null 2>&1 &
    chmod 777 psiphond
    ip=$(wget -qO- ifconfig.me)
    echo "————————————————————————————————————————————————————"
    read -p "Ingrese puerto SSH: " puerto_ssh
    read -p "Ingrese puerto OSSH: " puerto_ossh
    read -p "Ingrese puerto FRONTED-MEEK-OSSH: " puerto_fronted
    ./psiphond --ipaddress $ip --web 3000 --protocol SSH:$puerto_ssh --protocol OSSH:$puerto_ossh --protocol FRONTED-MEEK-OSSH:$puerto_fronted generate
    screen -dmS psiphon ./psiphond run
    echo "————————————————————————————————————————————————————"
    cat server-entry.dat
    echo "\n————————————————————————————————————————————————————"
    echo "Puerto SSH: $puerto_ssh"
    echo "Puerto OSSH: $puerto_ossh"
    echo "Puerto FRONTED-MEEK-OSSH: $puerto_fronted"

}

desinstalar_psiphond() {
    echo "Desinstalando PsiphonD..."
    sudo apt-get remove psiphond

}

ver_configuracion() {
    echo "Mostrando configuración:"
    echo "————————————————————————————————————————————————————"
    cat server-entry.dat
    echo "\n————————————————————————————————————————————————————"
}

mostrar_menu() {
    clear
    red='\033[0;31m'
    nc='\033[0m'
    echo -e "${red}"
    echo -e "${red}"
    echo "██████╗ ███████╗██╗██████╗ ██╗  ██╗ ██████╗ ███╗   ██╗███╗   ███╗ ██████╗"
    echo "██╔══██╗██╔════╝██║██╔══██╗██║  ██║██╔═══██╗████╗  ██║████╗ ████║██╔════╝"
    echo "██████╔╝███████╗██║██████╔╝███████║██║   ██║██╔██╗ ██║██╔████╔██║██║     "
    echo "██╔═══╝ ╚════██║██║██╔═══╝ ██╔══██║██║   ██║██║╚██╗██║██║╚██╔╝██║██║     "
    echo "██║     ███████║██║██║     ██║  ██║╚██████╔╝██║ ╚████║██║ ╚═╝ ██║╚██████╗"
    echo "╚═╝     ╚══════╝╚═╝╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝"
    echo -e "${nc}"

    echo "1. Instalar Psiphon"
    echo "2. Desinstalar Psiphon"
    echo "3. Ver configuración"
    echo "4. Salir"
}

while true; do
    mostrar_menu
    read -p "Selecciona una opción (1-4): " opcion

    case $opcion in
    1) instalar_psiphond ;;
    2) desinstalar_psiphond ;;
    3) ver_configuracion ;;
    4)
        echo "Saliendo del script."
        exit 0
        ;;
    *)
        echo "Opción inválida. Intenta de nuevo."
        ;;
    esac
done
