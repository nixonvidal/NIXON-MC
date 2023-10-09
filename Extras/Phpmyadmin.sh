#!/bin/bash
# BY KEVIN CAT 
#clear
lor1='\033[1;31m';lor2='\033[1;32m';lor3='\033[1;33m';lor4='\033[1;34m';lor5='\033[1;35m';lor6='\033[1;36m';lor7='\033[1;37m'
banner1="      ___           _              _ _ _ 
     / _ \_ __ ___ | |_ ___   /\ /(_) | |
    / /_)/ '__/ _ \| __/ _ \ / //_/ | | |
   / ___/| | | (_) | || (_) / __ \| | | |
   \/    |_|  \___/ \__\___/\/  \/|_|_|_| "
   
#banner1="
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

########

barra="\e[1;30m===================================================== \e[0m"
install_apache2() {
clear
msg -bar
msg -verm " INSTALACION DE APACHE2 \e[37m10"
msg -bar
echo -e "	\e[1;37m [ 1 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
apt-get install apache2 -y &>/dev/null
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 2 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo ufw allow 'Apache' &>/dev/null
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 3 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
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
apt-get install mysql-server
clear
echo -e "\033[1;42mBIENVENIDO MySQL!\033[0m"
echo -e $barra
		echo -e "        \033[4;31mNOTA importante\033[0m"
		echo -e "      \033[0;31mRecomendado UBUNTU 20.04"
		echo -e "\033[0;31m-----Nombre de base de datos------"
		echo -e "\033[1;42m|  ALTER USER 'root'@'localhost' IDENTIFIED WITH\n mysql_native_password BY 'password';  |\033[0m"
		echo -e "\033[0;31m-----ACTULIZAR SQL------"
		echo -e "\033[1;42m|  FLUSH PRIVILEGES;  |\033[0m"
		echo -e "\033[0;31m-----SALIR DE MySQL------"
		echo -e "\033[1;42m|  EXIT;  |\033[0m"
		echo -e $barra
echo -e " ¡ADVERTENCIA! INGRESE SU CONTRASEÑA MySQL "
sudo mysql -u root -p
clear
echo -e "\e[1;37m COMPLETADO CON EXITO "
read -p "enter"
menu
}

install_php() {
msg -bar
msg -verm " INSTALACION DE PHP \e[37m10"
msg -bar
echo -e "	\e[1;37m [ 1 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
apt-get install sudo apt-get install php libapache2-mod-php php-mysql
clear
echo -e "\e[1;37m COMPLETADO CON EXITO "
read -p "enter"
menu
}

install_phpmyadmin() {
msg -bar
msg -verm " INSTALACION DE PHPMYADMIN \e[37m10"
msg -bar
apt-get install phpmyadmin
clear
echo -e "\e[1;37m COMPLETADO CON EXITO "
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
#
#
#
#
menu(){
[[ -e /etc/apache2/sites-available/000-default.conf ]] && apac="\033[1;32m[ON]" || apac="\033[1;31m[OFF]"
[[ -e /etc/mysql/mysql.cnf ]] && sql="\033[1;32m[ON]" || sql="\033[1;31m[OFF]"
php="\033[1;36m[CARPETAS]" || php="\033[1;32m[CARPETAS]"
[[ -e /etc/phpmyadmin/lighttpd.conf ]] && phpdm="\033[1;32m[ON]" || phpdm="\033[1;31m[OFF]"
clear
echo -e "$barra"
#echo -e "${lor4}$banner1 ${lor7}"
figlet " -XAMP- "| lolcat
echo -e "$barra"
    print_center -azu "=====>>>> PHPMYADMIN_NIXON-MC<<<<====="|lolcat
echo -e "$barra"
echo -e " [1] INSTALAR APACHE2    $apac\033[0m "
echo -e " [2] INSTALAR SQL        $sql \033[0m"
echo -e " [3] INSTALAR PHP        $php \033[0m"
echo -e " [4] INSTALAR PHPMYADMIN $phpdm \033[0m"
echo -e " [5] INF (http://) "
echo -e " [0] \e[1;31mSALIR\e[0m"
echo -e "$barra"
selection=$(selection_fun 6)
case $selection in
0)exit;;
1)install_apache2;;
2)install_sql;;
3)install_php;;
4)install_phpmyadmin;;
5)inf;;
esac
}
menu