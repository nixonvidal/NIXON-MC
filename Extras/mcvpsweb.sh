#!/bin/bash
# BY KEVIN CAT 
#clear
banner1="      ___           _              _ _ _ 
     / _ \_ __ ___ | |_ ___   /\ /(_) | |
    / /_)/ '__/ _ \| __/ _ \ / //_/ | | |
   / ___/| | | (_) | || (_) / __ \| | | |
   \/    |_|  \___/ \__\___/\/  \/|_|_|_| "
   
baner="                                                       
   _|_|_|    _|_|    _|_|_|_|_|  _|      _|  _|_|_|    
 _|        _|    _|      _|      _|_|  _|_|  _|    _|  
 _|        _|_|_|_|      _|      _|  _|  _|  _|_|_|    
 _|        _|    _|      _|      _|      _|  _|        
   _|_|_|  _|    _|      _|      _|      _|  _|        
                                                       "
   
#banner1="
rojo='\033[1;31m';verde='\033[1;32m';color0='\033[0m';lor4='\033[1;34m';lor5='\033[1;35m';lor6='\033[1;36m';lor7='\033[1;37m'
msg(){
  COLOR[0]='\033[1;37m' #BRAN='\033[1;37m'
  COLOR[1]='\e[31m' #VERMELHO='\e[31m'
  COLOR[2]='\e[32m' #VERDE='\e[32m'
  COLOR[3]='\e[33m' #AMARELO='\e[33m'
  COLOR[4]='\e[34m' #AZUL='\e[34m'
  COLOR[5]='\e[91m' #MAGENTA='\e[35m'
  COLOR[6]='\033[1;97m' #MAG='\033[1;36m'
  COLOR[7]='\e[36m' #teal='\e[36m'
  COLOR[8]='\e[30m' #negro='\e[30m'
  COLOR[9]='\033[34m' #blue='\033[1;34m'

  NEGRITO='\e[1m'
  SEMCOR='\e[0m'

  case $1 in
    -ne)   cor="${COLOR[1]}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
    -nazu) cor="${COLOR[6]}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
    -nverd)cor="${COLOR[2]}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
    -nama) cor="${COLOR[3]}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
    -ama)  cor="${COLOR[3]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -verm) cor="${COLOR[3]}${NEGRITO}[!] ${COLOR[1]}" && echo -e "${cor}${2}${SEMCOR}";;
    -verm2)cor="${COLOR[1]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -verm3)cor="${COLOR[1]}" && echo -e "${cor}${2}${SEMCOR}";;
    -teal) cor="${COLOR[7]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -teal2)cor="${COLOR[7]}" && echo -e "${cor}${2}${SEMCOR}";;
    -blak) cor="${COLOR[8]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -blak2)cor="${COLOR[8]}" && echo -e "${cor}${2}${SEMCOR}";;
    -azu)  cor="${COLOR[6]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -blu)  cor="${COLOR[9]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -blu1) cor="${COLOR[9]}" && echo -e "${cor}${2}${SEMCOR}";;
    -verd) cor="${COLOR[2]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -bra)  cor="${COLOR[0]}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
    -bar)  cor="${COLOR[1]}=====================================================" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
    -bar2) cor="${COLOR[7]}=====================================================" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
    -bar3) cor="${COLOR[1]}-----------------------------------------------------" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
    -bar4) cor="${COLOR[7]}-----------------------------------------------------" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
  esac
}

# centrado de texto
print_center(){
  if [[ -z $2 ]]; then
    text="$1"
  else
    col="$1"
    text="$2"
  fi

  while read line; do
    unset space
    x=$(( ( 54 - ${#line}) / 2))
    for (( i = 0; i < $x; i++ )); do
      space+=' '
    done
    space+="$line"
    if [[ -z $2 ]]; then
      msg -azu "$space"
    else
      msg "$col" "$space"
    fi
  done <<< $(echo -e "$text")
}




###########

barra="\e[1;30m===================================================== \e[0m"
install_apache2() {
clear
msg -bar
msg -verm " INSTALACION DE APACHE2 \e[37m10"
msg -bar
echo -e "	\e[1;37m [ 1 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
#apt-get install apache2 -y &>/dev/null
sudo ufw app list
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 2 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo ufw allow OpenSSH
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 3 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo ufw enable
echo -e "	\e[1;32m INSTALADO\e[0m"
echo -e "	\e[1;37m [ 4 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo ufw status
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
clear
msg -bar
echo -e "	\e[1;37m [ 5 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo apt install apache2
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 6 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo ufw app list
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 7 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo ufw allow in "Apache Full"
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 8 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo ufw status
wget -O /etc/apache2/ports.conf https://www.dropbox.com/s/4xr8sbdlwin7w5d/ports &>/dev/null 
chmod 777 /etc/apache2/ports.conf
sudo systemctl restart apache2
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
clear
echo -e "\e[1;37m COMPLETADO CON EXITO "
read -p "enter"
menu
# Scan QR
}

install_sql() {
msg -bar
msg -verm " INSTALACION DE SQL \e[37m10"
msg -bar
echo -e "	\e[1;37m [ 1 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo apt install mysql-server
clear
echo -e "\033[1;42mBIENVENIDO MySQL!\033[0m"
echo -e $barra
		echo -e "        \033[4;31mNOTA importante\033[0m"
		echo -e "      \033[0;31mRecomendado UBUNTU 22.04"
		echo -e "\033[0;31m-----Validar password------"
		echo -e "\033[1;42m|  SHOW VARIABLES LIKE 'validate_password'; |\033[0m"
		echo -e "\033[0;31m-----Nombre de base de datos------"
		echo -e "\033[1;42m|  use mysql; |\033[0m"
		echo -e "\033[0;31m-----Validar user------"
		echo -e "\033[1;42m|  select user, plugin, host FROM mysql.user; |\033[0m"
		echo -e "\033[0;31m-----Crear password de phpmyadmin------"
		echo -e "\033[1;42m|  ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'mipassword'; |\033[0m"
		echo -e "\033[0;31m-----ACTULIZAR SQL------"
		echo -e "\033[1;42m|  FLUSH PRIVILEGES;  |\033[0m"
		echo -e "\033[0;31m-----SALIR DE MySQL------"
		echo -e "\033[1;42m|  EXIT;  |\033[0m"
		echo -e $barra
echo -e " ¡ADVERTENCIA! INGRESE SU CONTRASEÑA MySQL "
#sudo mysql -u root -p
sudo mysql
clear
echo -e "\e[1;37m COMPLETADO CON EXITO "
read -p "enter"
menu
}

install_php() {
clear
msg -bar
msg -verm " INSTALACION DE PHP \e[37m10"
msg -bar
echo -e "	\e[1;37m [ 1 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo apt install php libapache2-mod-php
clear
echo -e "\e[1;37m COMPLETADO CON EXITO "
read -p "enter"
menu
}

install_phpmyadmin() {
clear
msg -bar
msg -verm " INSTALACION DE PHPMYADMIN \e[37m10"
msg -bar
sudo apt info phpmyadmin
clear
msg -bar
sudo apt install phpmyadmin
clear
echo -e "\e[1;37m COMPLETADO CON EXITO "
read -p "enter"
menu
}
htacc() {
clear
msg -bar
msg -verm " INSTALACION DE HTACCESS \e[37m10"
msg -bar
sudo a2enmod rewrite
#sudo nano /etc/apache2/apache2.conf
wget -O /etc/apache2/apache2.conf https://www.dropbox.com/s/eroy3s3lawjllw6/apache2.conf &>/dev/null 
chmod 777 /etc/apache2/apache2.conf
sudo service apache2 restart
read -p "enter"
menu
}

web() {
clear
msg -bar
msg -verm " INSTALACION DE PANEL WEB \e[37m10"
msg -bar
curl -O https://raw.githubusercontent.com/ajenti/ajenti/master/scripts/install.sh
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
ls -l
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
sudo bash ./install.sh
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
sudo systemctl ajenti
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
ss -pnltue | grep 8000
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
sudo ufw allow 8000/tcp
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
sudo ufw reload
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
sudo ufw enable
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
read -p "enter"
menu
}

#Agregar DOMINIO 
#VER INFORMACIÓN
inf(){
echo -e "$barra"
echo -e "\e[1;32m http://$(wget -qO- ifconfig.me)/phpmyadmin"
echo -e "$barra"
#echo -e "\e[1;37m NEXTCLOUD "
read -p "enter"
menu
}
infweb() {
echo -e "$barra"
echo -e "\e[1;32m https://$(wget -qO- ifconfig.me):8000"
echo -e "$barra"
#echo -e "\e[1;37m NEXTCLOUD "
read -p "enter"
menu

}

desinstalador () {
rm -rf /bin/gato
rm -rf .bash_history
sudo apt-get remove mssql-sever
sudo rm -rf /var/opt/mssql
sudo dpkg -P phpmyadmin
sudo rm -f /etc/apache2/conf-available/phpmyadmin.conf
sudo apt-get purge php8.*
clear
exit
}
#
#
selection_fun () {
 local selection="null"
 local range
 for((i=0; i<=$1; i++)); do range[$i]="$i "; done
 while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
 echo -ne "\033[1;37m► Selecione una Opcion: " >&2
 read selection
 tput cuu1 >&2 && tput dl1 >&2
 done
 echo $selection
 }
#
#
zip (){
  clear
  msg -bar
  echo -e "	\e[1;32m INSTALADO ZIP\e[0m"
  msg -bar
  sudo apt-get install rar unrar unace zip unzip p7zip-full p7zip-rar sharutils mpack arj cabextract file-roller uudeview
  clear
  msg -bar
  echo -e "\e[1;37m COMPLETADO CON EXITO "
  read -p "enter"
  menu
}

mariadb (){
  clear
    msg -bar
  echo -e "	\e[1;32m INSTALADO Maria DB\e[0m"
  msg -bar
  sudo apt install mariadb-server
  sudo mysql_secure_installation 
    clear
echo -e "\033[1;42mBIENVENIDO Maria DB!\033[0m"
echo -e $barra
		echo -e "        \033[4;31mNOTA importante\033[0m"
		echo -e "      \033[0;31mRecomendado UBUNTU 22.04"
		echo -e "\033[0;31m-----Validar password------"
		echo -e "\033[1;42m|  SHOW VARIABLES LIKE 'validate_password'; |\033[0m"
		echo -e "\033[0;31m-----Nombre de base de datos------"
		echo -e "\033[1;42m|  use mysql; |\033[0m"
		echo -e "\033[0;31m-----Validar user------"
		echo -e "\033[1;42m|  select user, plugin, host FROM mysql.user; |\033[0m"
		echo -e "\033[0;31m-----Crear password de phpmyadmin------"
		echo -e "\033[1;42m|  ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'mipassword'; |\033[0m"
		echo -e "\033[0;31m-----ACTULIZAR SQL------"
		echo -e "\033[1;42m|  FLUSH PRIVILEGES;  |\033[0m"
		echo -e "\033[0;31m-----SALIR DE MySQL------"
		echo -e "\033[1;42m|  EXIT;  |\033[0m"
		echo -e $barra
echo -e " ¡ADVERTENCIA! INGRESE SU CONTRASEÑA MySQL "
#sudo mysql -u root -p
sudo mysql
clear
echo -e "\e[1;37m COMPLETADO CON EXITO "
read -p "enter"
menu
}
#
#
#
#
menu(){
cor=( [0]="\033[0m" [1]="\033[1;34m" [2]="\033[1;35m" [3]="\033[1;32m" [4]="\033[1;31m" [5]="\033[1;33m" [6]="\E[44;1;37m" [7]="\E[41;1;37m" )
[[ -e /etc/apache2/sites-available/000-default.conf ]] && apac="\033[1;32m[ON]" || apac="\033[1;31m[OFF]"
[[ -e /etc/mysql/mysql.cnf ]] && sql="\033[1;32m[ON]" || sql="\033[1;31m[OFF]"
php="\033[1;36m[CARPETAS]" || php="\033[1;32m[CARPETAS]"
[[ -e /etc/phpmyadmin/lighttpd.conf ]] && phpdm="\033[1;32m[ON]" || phpdm="\033[1;31m[OFF]"

clear
echo -e "$barra"
#echo -e "${lor4}$banner1 ${lor7}"
#figlet "PHPMYADMIN"| lolcat
echo -e "$baner"
echo -e "$barra"
echo -e "  +---------------------------+
 ${cor[0]} | ${cor[5]}[1] ${cor[1]}|P|A|C|H|E|2|${cor[0]}         | ${cor[7]}=> $apac ${cor[0]}
  +---------------------------+"
echo -e "  ${cor[0]}| ${cor[5]}[2] ${cor[1]}|S|Q|L|${cor[0]}               | ${cor[7]}=> $sql ${cor[0]}
  +---------------------------+"
echo -e "  ${cor[0]}| ${cor[5]}[3] ${cor[1]}|MA|RI|A|-|DB|${cor[0]}        | ${cor[7]}=> $sql ${cor[0]}
  +---------------------------+"
echo -e "  ${cor[0]}| ${cor[5]}[4] ${cor[1]}|P|H|P|${cor[0]}               | ${cor[7]}=> $php ${cor[0]}
  +---------------------------+"
echo -e " ${cor[0]} | ${cor[5]}[5] ${cor[1]}|P|H|P|M|Y|A|D|M|I|N|${cor[0]} | ${cor[7]}=> $phpdm ${cor[0]}
  +---------------------------+"
echo -e " ${cor[0]} | ${cor[5]}[6] ${cor[1]}|.|H|T|A|C|C|E|S|S|${cor[0]}   | ${cor[7]}=> $php ${cor[0]}
  +---------------------------+"
echo -e " ${cor[0]} | ${cor[5]}[7] ${cor[1]}|P|A|N|E|L|-|W|E|P|${cor[0]}   | ${cor[7]}=> $php ${cor[0]}
  +---------------------------+"
echo -e " ${cor[0]} | ${cor[5]}[8] ${cor[1]}|I|N|S|T|A|-|Z|I|P|${cor[0]}   | ${cor[7]}=> $php ${cor[0]}
  +---------------------------+"
    #print_center -azu "=====>>>> PHPMYADMIN-CAT <<<<====="|lolcat INSTALL
#echo -e "$barra"
#echo -e " [1] INSTALAR APACHE2    $apac\033[0m "
#echo -e " [2] INSTALAR SQL        $sql \033[0m"
#echo -e " [3] INSTALAR PHP        $php \033[0m"
#echo -e " [4] INSTALAR PHPMYADMIN $phpdm \033[0m"
echo -e " [9] INF (http://phpmyadmin) "
echo -e " [10] INF (https://web-panel) "
echo -e "\033[1;31m [11] =  \033[1;31mDESINSTALAR CATMP\e[0m"
echo -e " [0] \e[1;31mSALIR\e[0m"
echo -e "$barra"
selection=$(selection_fun 10)
case $selection in
0)exit;;
1)install_apache2;;
2)install_sql;;
3)mariadb;;
4)install_php;;
5)install_phpmyadmin;;
6)htacc;;
7)web;;
8)zip;;
9)inf;;
10)infweb;;
11)
read -p "desea desinstalar el generador [ s | n ]: " -e -i s desinstalador   
[[ "$desinstalador" = "s" || "$desinstalador" = "S" ]] && desinstalador
;;
esac
}
menu