#!/bin/bash

####################################
# BY: CAT                          #
# Modificado: 25/marzo 2023        #
# Creado para Nixon                #
# DISPONIBLE: UBUNTU/14/22         #
#                       LINUX..... #
####################################

msg() {
  BRAN='\033[1;37m' && VERMELHO='\e[31m' && VERDE='\e[32m' && AMARELO='\e[33m' && MORADO='\e[35m'
  AZUL='\e[34m' && MAGENTA='\e[35m' && MAG='\033[1;36m' && NEGRITO='\e[1m' && SEMCOR='\e[0m'
  case $1 in
  -ne) cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
  -ama) cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -verm) cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -azu) cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -verd) cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}" ;;
  -bra) cor="${VERMELHO}" && echo -ne "${cor}${2}${SEMCOR}" ;;
  "-bar2" | "-bar") cor="${MORADO}————————————————————————————————————————————————————" && echo -e "${SEMCOR}${cor}${SEMCOR}" ;;
  esac

}
install_nexcloud() {
  clear
  msg -bar
  echo -e "ACTULIZANDO PAQUETES DEL SISTEMA"
  msg -bar
  sudo apt update -y && sudo apt upgrade -y
  clear
  msg -bar
  echo -e "INSTALANDO APACHE2 PUERTO: 80"
  msg -bar
  sudo apt install apache2
  sudo systemctl enable apache2 && sudo systemctl start apache2
  clear
  msg -bar
  ECHO -e "INSTALANDO PHP v.8"
  msg -bar
  sudo apt-get install php8.1 php8.1-cli php8.1-common php8.1-imap php8.1-redis php8.1-snmp php8.1-xml php8.1-zip php8.1-mbstring php8.1-curl php8.1-gd php8.1-mysql
  clear
  msg -bar
  echo -e "INSTALANDO MARIA_DB"
  msg -bar
  sudo apt install mariadb-server
  sudo systemctl start mariadb && sudo systemctl enable mariadb
  clear
  msg -bar
  echo -e "CREADO BASE DE DATOS DE NEXTCLOUD"
  msg -bar
  mysql -u root <<MYSQL
  CREATE DATABASE nextcloud;
  GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost' IDENTIFIED BY 'nextcloud';
  FLUSH PRIVILEGES;
  exit;
MYSQL
  clear
  msg -bar
  echo -e "DESCARGANDO NEXCLOUD"
  msg -bar
  cd /var/www/html
  wget https://download.nextcloud.com/server/releases/nextcloud-24.0.1.zip
  clear
  msg -bar
  echo -e "EXTRAYENDO"
  msg -bar
  unzip nextcloud-24.0.1.zip
  chown -R www-data:www-data /var/www/html/nextcloud

  touch /etc/apache2/sites-available/nextcloud.conf
  https://www.dropbox.com/s/idiq4f0k9opjdq3/nextcloud.conf

  sudo a2ensite nextcloud.conf
  sudo a2enmod rewrite
  sudo ufw allow http
  apachectl -t
  msg -bar
  echo -e "\e[1;37m COMPLETADO CON EXITO "
  msg -bar
  read -p "enter"
  menu
}

uninstall_nextcloud() {
  echo ""
  rm -rf /var/www/html/nextcloud
  msg -bar
  echo -e "\e[1;37m DESINSTALANDO CON EXITO "
  msg -bar
  read -p "enter"
  menu
}

inf() {
  msg -bar
  echo -e "\e[1;32m http://$(wget -qO- ifconfig.me)/nextcloud"
  msg -bar
  echo -e "USUARIO BASE DE DATOS: nexcloud"
  echo -e "CONTRASEÑA DE BASE DE DATOS: nexcloud"
  echo -e "NOMBRE DE BASE DE DATOS: nexcloud"
  msg -bar
  menu
}

selection_fun () {
 local selection="null"
 local range
 for((i=0; i<=$1; i++)); do range[$i]="$i "; done
 while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
 echo -ne "\033[1;37m Selecione una Opcion: " >&2
 read selection
 tput cuu1 >&2 && tput dl1 >&2
 done
 echo $selection
 }

menu() {
  clear
  [[ -e /var/www/html/nextcloud/status.php ]] && cloud="\033[1;32m[ON]\e[0m" || cloud="\033[1;31m[OFF]\e[0m"
  echo "  _   _   _____  __  __  _____    ____   _        ___    _   _   ____  
 | \ | | | ____| \ \/ / |_   _|  / ___| | |      / _ \  | | | | |  _ \ 
 |  \| | |  _|    \  /    | |   | |     | |     | | | | | | | | | | | |
 | |\  | | |___   /  \    | |   | |___  | |___  | |_| | | |_| | | |_| |
 |_| \_| |_____| /_/\_\   |_|    \____| |_____|  \___/   \___/  |____/ "
  msg -bar
  echo -e " [1] INSTALAR NEXLOUD $cloud"
  echo -e " [2] DESISTALAR NEXLOUD"
  echo -e " [3] VER INFORMACION"
  msg -bar
  selection=$(selection_fun 4)
  case $selection in
  0) exit 0 ;;
  1) install_nexcloud ;;
  2) uninstall_nextcloud ;;
  3) inf ;;

  esac

}
menu
