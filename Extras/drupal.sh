#!/bin/bash
#
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

fun_bar () {
#==comando a ejecutar==
comando="$1"
#==interfas==
in=' ['
en=' ] '
full_in="➛"
full_en='100%'
bar=(────────────────────
═───────────────────
▇═──────────────────
▇▇═─────────────────
═▇▇═────────────────
─═▇▇═───────────────
──═▇▇═──────────────
───═▇▇═─────────────
────═▇▇═────────────
─────═▇▇═───────────
──────═▇▇═──────────
───────═▇▇═─────────
────────═▇▇═────────
─────────═▇▇═───────
──────────═▇▇═──────
───────────═▇▇═─────
────────────═▇▇═────
─────────────═▇▇═───
──────────────═▇▇═──
───────────────═▇▇═─
────────────────═▇▇═
─────────────────═▇▇
──────────────────═▇
───────────────────═
──────────────────═▇
─────────────────═▇▇
────────────────═▇▇═
───────────────═▇▇═─
──────────────═▇▇═──
─────────────═▇▇═───
────────────═▇▇═────
───────────═▇▇═─────
──────────═▇▇═──────
─────────═▇▇═───────
────────═▇▇═────────
───────═▇▇═─────────
──────═▇▇═──────────
─────═▇▇═───────────
────═▇▇═────────────
───═▇▇═─────────────
──═▇▇═──────────────
─═▇▇═───────────────
═▇▇═────────────────
▇▇═─────────────────
▇═──────────────────
═───────────────────
────────────────────);
#==color==
in="\033[1;33m$in\033[0m"
en="\033[1;33m$en\033[0m"
full_in="\033[1;31m$full_in"
full_en="\033[1;32m$full_en\033[0m"

 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
	for i in "${bar[@]}"; do
		echo -ne "\r $in"
		echo -ne "ESPERE $en $in \033[1;31m$i"
		echo -ne " $en"
		sleep 0.1
	done
done
echo -e " $full_in $full_en"
sleep 0.1s
}

fun_kevn ()
{
	comando[0]="$1" 
    ${comando[0]}  > /dev/null 2>&1 & 
	tput civis
	echo -ne "\033[1;43m\e[1;31m>>>>\e[0m\033[1;32m "
    while [ -d /proc/$! ]
	do
		for i in / - \\ \|
		do
			sleep .1
			echo -ne "\e[1D$i"
		done
	done
	#⇗-⇖⇖⇖ ⇑
	tput cnorm
	echo -e "\e[1D ✔"
}

apache2(){
wget -O /etc/apache2/ports.conf https://www.dropbox.com/s/4xr8sbdlwin7w5d/ports &>/dev/null 
chmod 777 /etc/apache2/ports.conf
wget -O /etc/apache2/sites-available/drupal.conf https://www.dropbox.com/s/g1itwhuy3acm7dl/drupal &>/dev/null 
 chmod 777 /etc/apache2/sites-available/drupal.conf
#wget -O /etc/ssh/sshd_config https://raw.githubusercontent.com/lacasitamx/ZETA/master/sshd &>/dev/null 
# chmod 777 /etc/ssh/sshd_config 
}

extraer () {
INSTALL_DIR_PARENT="/var/www/html/" 

 cd "$INSTALL_DIR_PARENT" 
# wget https://raw.githubusercontent.com/lacasitamx/VPSMX/master/zzupdate/zzupdate.default.conf -O /usr/local/vpsmxup/vpsmxup.default.conf  &> /dev/null 
wget https://ftp.drupal.org/files/projects/drupal-9.3.3.tar.gz -O /var/www/html/drupal-9.3.3.tar.gz  &> /dev/null 
sudo tar xzvf drupal-9.3.3.tar.gz -C /var/www/html/drupal --strip-components=1
sudo chown -R www-data. /var/www/html/drupal
read -p "enter"
menu
}

basedatos () {
clear
echo -e "\033[1;42mBIENVENIDO MySQL!\033[0m"
echo -e $barra
		echo -e "        \033[4;31mNOTA importante\033[0m"
		echo -e "      \033[0;31mRecomendado UBUNTU 20.04"
		echo -e "\033[0;31m-----Nombre de base de datos------"
		echo -e "\033[1;42m|  CREATE DATABASE drupal9;  |\033[0m"
		echo -e "\033[0;31m-----USUARIO Y CONTRASEÑA de base de datos------"
		echo -e "\033[1;42m|  GRANT ALL PRIVILEGES ON drupal9.* TO 'drupal9_usuario'@localhost IDENTIFIED BY 'contraseña';  |\033[0m"
		echo -e "\033[0;31m-----Nombre de base de datos------"
		echo -e "\033[1;42m|  FLUSH PRIVILEGES;  |\033[0m"
		echo -e "\033[0;31m-----SALIR DE MySQL------"
		echo -e "\033[1;42m|  EXIT;  |\033[0m"
		echo -e $barra
echo -e " ¡ADVERTENCIA! INGRESE SU CONTRASEÑA MySQL "
sudo mysql -u root -p
echo -ne "	\033[1;37mACTULIZAR    --\e[0m";
sudo systemctl restart apache2
}


barra="\e[1;30m===================================================== \e[0m"
#mkdir /etc/herramientas >/dev/null 2>&1
#Instalar NEXTCLOUD
insta_dru() {
echo -ne "	\033[1;37mINSTALL HTTPS    --\e[0m";
fun_kevn 'sudo apt update '
echo -ne "	\033[1;37mINSTALL HTTPS    --\e[0m";
fun_kevn 'sudo apt upgrade'
echo -ne "	\033[1;37mINSTALL APACHE2    --\e[0m";
fun_kevn 'sudo apt install -y apache2 apache2-utils'
apache2
echo -ne "	\033[1;37mdrupal    --\e[0m";
fun_kevn 'sudo a2ensite drupal'
echo -ne "	\033[1;37mrewrite    --\e[0m";
fun_kevn 'sudo a2enmod rewrite'
echo -ne "	\033[1;37mrestart apache2    --\e[0m";
fun_kevn 'sudo systemctl restart apache2'
echo -ne "	\033[1;37mUPDATE    --\e[0m";
fun_kevn 'sudo systemctl restart apache2'
sudo mkdir /var/www/html/drupal
echo -ne "	\033[1;37mMariaDB    --\e[0m";
sudo apt install mariadb-server mariadb-client
echo -ne "	\033[1;37mMYSQL    --\e[0m";
sudo mysql_secure_installation
echo -ne "	\033[1;37mInstalar PHP   --\e[0m";
sudo apt install php7.4 libapache2-mod-php7.4 php7.4-{common,mbstring,xmlrpc,soap,gd,xml,intl,mysql,cli,zip,curl,fpm} -y
echo -ne "	\033[1;37mINSTALL HTTPS    --\e[0m";
fun_kevn 'sudo a2enmod php7.4'
sudo a2enmod php7.4
echo -ne "	\033[1;37mINSTALL HTTPS    --\e[0m";
fun_kevn 'sudo systemctl restart apache2'
sudo systemctl restart apache2
#extraer
read -p "enter"
menu
}

install() {
echo -ne "	\033[1;37mPLEX-KEYS    --\e[0m";
fun_kevn 'sudo apt install -y apache2 apache2-utils'
read -p "enter"
menu
}

#Desinstalar NEXTCLOUD
desinst_drupal() {
fun_bar "sudo rm -f /etc/init.d/plexmediaserver"
fun_bar "sudo dpkg --purge --force-all plexmediaserver"
fun_bar "sudo apt remove plexmediaserver"
echo -e "\e[1;37m NEXTCLOUD "
read -p "enter"
menu
}
#Agregar DOMINIO 
agregar_plex() {
sudo nano /etc/apache2/sites-available/drupal.conf
sudo systemctl restart apache2
read -p "enter"
menu
}
#VER INFORMACIÓN

inf(){
echo -e "$barra"
echo -e "\e[1;32m http://$(wget -qO- ifconfig.me)"
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
 echo -ne "\033[1;37m$(fun_trans " ► Selecione una Opcion"): " >&2
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
#[[ -e /snap/nextcloud/current/meta/snap.yaml ]] && webminn="\033[1;32m[ON]" || webminn="\033[1;31m[OFF]"
menu(){
[[ -e /etc/php/7.4/mods-available/xmlrpc.ini ]] && php="\033[1;32m[ON]" || php="\033[1;31m[OFF]"
[[ -e /etc/apache2/sites-available/drupal.conf ]] && apac="\033[1;32m[ON]" || apac="\033[1;31m[OFF]"
clear
echo -e "$barra"
#echo -e "${lor4}$banner1 ${lor7}"
figlet " -DRUPAL- "| lolcat
echo -e "$barra"
    print_center -azu "=====>>>> NIXON-MC <<<<====="|lolcat
#echo -e "\e[1;37m ------------NEXTCLOUD------------ "
echo -e "$barra"
echo -e "       \033[1;31mPHP: $php \033[1;31mAPACHE2: $apac"
echo -e "$barra"
echo -e " [1] INSTALAR DRUPAL"
#echo -e " [2] DESINSTALAR DRUPAL"
echo -e " [2] CREAR BASE DE DATOS"
echo -e " [3] EXTRAER ZIP (drupal)"
#echo -e " [3] AGREGAR DOMINIO"
echo -e " [4] AGREGAR DOMINIO"
echo -e " [5] INF (http://) "
echo -e " [6] Certificado SSL"
echo -e " [0] \e[1;31mSALIR\e[0m"
echo -e "$barra"
selection=$(selection_fun 6)
case $selection in
#echo -ne "\e[1;33m SELECIONE UNA OPCION: "; read selector
#case $selector in
#
0)exit;;
1)insta_dru;;
#2)desinst_drupal;;
2)basedatos;;
3)extraer;;
4)agregar_plex;;
5)inf;;
esac
}
menu