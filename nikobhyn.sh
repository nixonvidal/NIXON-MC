#!/bin/bash
rm $(pwd)/$0
####################################
# BY: CAT                          #
# Modificado: 21/marzo 2023        #
# Creado para Nixon                #
# DISPONIBLE: UBUNTU/14/22         #
#                       LINUX..... #
####################################

#-------COLORES--------#
verder='\e[1;32m'
morado='\e[35m'
azul='\e[0;34m'
amarillo='\e[1;33m'
rojo='\e[0;31m'
blanco='\033[1;37m'
########################
moradoe=$(echo -e '\e[35m')
azule=$(echo -e '\e[0;34m')
########################

msg() {
    BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m'
    AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' && NEGRITO='\e[1m' && SEMCOR='\e[0m'
    case $1 in
    -ne) cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
    -ama) cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
    -verm) cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}" ;;
    -azu) cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
    -verd) cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
    -bra) cor="${BRAN}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
    -bar2) cor="\e[0;31m========================================\e[0m" && echo -e "${cor}${SEMCOR}" ;;
    -bar) cor="\e[1;31m——————————————————————————————————————————————————————" && echo -e "${cor}${SEMCOR}" ;;
    esac
}

function_verify() {
    permited=$(curl -sSL "https://www.dropbox.com/s/ya21bxgmioh6jcd/control-bot")
    [[ $(echo $permited | grep "${IP}") = "" ]] && {
        echo -e "\n\n\n\033[1;31m====================================================="
        echo -e "\033[1;31m       ¡LA IP $(wget -qO- ipv4.icanhazip.com) NO ESTA AUTORIZADA!"
        echo -e "\033[1;31m                CONTACTE A @NixonMC "
        echo -e "\033[1;31m                NUMERO: +51974312499 "
        echo -e "\033[1;31m=====================================================\n\n\n"
        [[ -d /etc/SCRIPT ]] && rm -rf /etc/SCRIPT
        exit 1
    } || {
        ### INTALAR VERCION DE SCRIPT
        v1=$(curl -sSL "")
        echo "$v1" >/etc/versin_script
    }
}

meu_ip() {
    MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
    MIP2=$(wget -qO- ipv4.icanhazip.com)
    [[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
    echo "$IP" >/usr/bin/vendor_code
}

os_system() {
    system=$(cat -n /etc/issue | grep 1 | cut -d ' ' -f6,7,8 | sed 's/1//' | sed 's/      //')
    distro=$(echo "$system" | awk '{print $1}')
    case $distro in
    Debian) vercion=$(echo $system | awk '{print $3}' | cut -d '.' -f1) ;;
    Ubuntu) vercion=$(echo $system | awk '{print $2}' | cut -d '.' -f1,2) ;;
    esac
    link="https://raw.githubusercontent.com/rudi9999/ADMRufu/main/Repositorios/${vercion}.list"
    case $vercion in
    8 | 9 | 10 | 11 | 16.04 | 18.04 | 20.04 | 20.10 | 21.04 | 21.10 | 22.04) wget -O /etc/apt/sources.list ${link} &>/dev/null ;;
    esac
}

updatex() {
    clear
    msg -bar
    os_system
    msg -ama "$distro $vercion"
    msg -verm " INSTALACION DE PAQUETES "
    msg -bar
    msg -verd "	INSTALL UPDATE"
    apt update -y
    apt list --upgradable -y
    msg -verd "	INSTALL UPGRADE"
    apt upgrade -y
    #clear
    msg -bar
    paq="jq bc curl netcat netcat-traditional net-tools apache2 zip unzip screen"

    for i in $paq; do
        leng="${#i}"
        puntos=$((21 - $leng))
        pts="."
        for ((a = 0; a < $puntos; a++)); do
            pts+="."
        done
        msg -azu "       instalando $i$(msg -ama "$pts")"
        if apt install $i -y &>/dev/null; then
            msg -verd "	INSTALADO"
        else
            msg -verm2 "	FAIL"
            sleep 0.1s
            tput cuu1 && tput dl1
            msg -ama "aplicando fix a $i"
            dpkg --configure -a &>/dev/null
            sleep 0.2s
            tput cuu1 && tput dl1

            msg -azu "       instalando $i$(msg -ama "$pts")"
            if apt install $i -y &>/dev/null; then
                msg -verd "	INSTALANDO"
            else
                msg -verm2 "	FAIL"
            fi
        fi
    done
    sed -i "s;Listen 80;Listen 81;g" /etc/apache2/ports.conf
    service apache2 restart >/dev/null 2>&1 &
    msg -bar
    msg -azu "Removiendo paquetes obsoletos"
    msg -bar
    apt autoremove -y &>/dev/null
    echo "00" >/root/.bash_history
    ufw allow 80/tcp &>/dev/null
    ufw allow 81/tcp &>/dev/null
    ufw allow 8888/tcp &>/dev/null

    #meu_ip
    #function_verify
    export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games/
    #clear

    mkdir /etc/nanobc >/dev/null 2>&1
    mkdir /etc/vpscat >/dev/null 2>&1
    mkdir /etc/bin >/dev/null 2>&1

    gt="/etc/kevn" && [[ ! -d ${gt} ]] && mkdir ${gt}
    mkdir /etc/ggh >/dev/null 2>&1
    SCPT_DIR="${gt}/gh"
    [[ ! -d ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
    IVAR="/etc/http-instas"
    [[ ! -d ${IVAR} ]] && touch ${IVAR}
    ###################################
    # LINK DE ARCHIVOS|SERVER|ZIP|GERADOR
    ###################################
    server=https://www.dropbox.com/s/vl16gaz45986gn3/httpserver.sh
    link=https://www.dropbox.com/s/27wzmlnjy0bna9g/repomx.zip
    gerador=https://www.dropbox.com/s/4q7qretlup2mjdl/gerar.sh
    ###################################
    clear
    echo "  ___   _   _   ____    _____      _      _       _     
 |_ _| | \ | | / ___|  |_   _|    / \    | |     | |    
  | |  |  \| | \___ \    | |     / _ \   | |     | |    
  | |  | |\  |  ___) |   | |    / ___ \  | |___  | |___ 
 |___| |_| \_| |____/    |_|   /_/   \_\ |_____| |_____|"
    msg -bar
    read -p "${moradoe}Dime tu nombre: ${azule}" nombre
    if [ "$nombre" != "" ]; then
    clear
    msg -bar
        echo -e "${blanco}Bienvenido ${rojo}$nombre ${blanco}empezaremos instalar \n los paquetes del generador"
    else
        echo -e "${blanco}Pues si no me quires decir tu nombre te doxeo :)"
    fi
    wget $server &>/dev/null
    msg -bar
    echo -e "\e[1;33m DESCARGANDO ARCHIVOS DEL SCRIPT "
    msg -bar
    apt-get install zip unzip curl -y >/dev/null 2>&1
    wget $link &>/dev/null
    unzip repomx.zip &>/dev/null
    mv -f VPS-MX/* ${SCPT_DIR}/
    chmod +x ${SCPT_DIR}/*
    rm -rf VPS-MX
    rm -rf repomx.zip
    mv -f httpserver.sh /bin/http-server.sh && chmod +x /bin/http-server.sh
    msg -bar
    echo -e "\e[33mESPERE UN MOMENTO POR FAVOR\nYA ESTAMOS FINALIZANDO LA INSTALACION"
    msg -bar
    IVAR2="/etc/key-gerador"
    echo "$Key" >$IVAR2
    wget $gerador &>/dev/null
    cp gerar.sh /bin/keygen && chmod +x /bin/keygen
    cp gerar.sh /bin/gerar && chmod +x /bin/gerar
    rm -rf gerar.sh
    msg -bar
    echo -e "\033[1;33m Utiliza el comando \033[31m\033[47mkeygen | gerar \e[0m"
    msg -bar
    echo -ne "\033[0m"
}

meu_ip
#function_verify
if [[ ! -e /etc/paq ]]; then
    updatex
    touch /etc/paq
else
    echo -e "${rojo}YA INSTALASTE GENERADOR :)"
fi
