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

fun_alex (){
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
echo -ne "\033[1;33m ["
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "\033[1;33m]"
   sleep 1s
   tput cuu1
   tput dl1
   echo -ne "\033[1;33m ["
done
echo -e "\033[1;33m]\033[1;31m -\033[1;32m 100%\033[1;37m"
}


barra="\e[1;30m===================================================== \e[0m"
#mkdir /etc/herramientas >/dev/null 2>&1
#Instalar NEXTCLOUD
install_bot() {
clear
msg -bar
msg -verm " INSTALACION DE PAQUETES DE \e[37m10"
msg -bar
echo -e "	\e[1;37m [ 1 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
apt-get update &>/dev/null
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 2 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
apt-get upgrade -y &>/dev/null
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 3 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo apt install curl wget git -y >/dev/null 2>&1
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 4 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
apt-get install screen -y >/dev/null 2>&1
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 5 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo apt install ffmpeg webp -y >/dev/null 2>&1
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 6 ] \e[1;31mINSTALANDO..\e[0m"
sudo curl https://deb.nodesource.com/setup_16.x | bash >/dev/null 2>&1
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 7 ] \e[1;31mINSTALANDO..\e[0m"
sudo apt install nodejs -y >/dev/null 2>&1
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 8 ] \e[1;31mINSTALANDO..\e[0m"
msg -bar
sudo apt install npm >/dev/null 2>&1
echo -e "	\e[1;32m INSTALADO\e[0m"
msg -bar
echo -e "	\e[1;37m [ 9 ] \e[1;31mINSTALANDO..\e[0m"
git clone https://github.com/FantoX001/Miku-MD >/dev/null 2>&1
echo -e "\e[1;37m COMPLETADO CON EXITO "
read -p "enter"
menu
# Scan QR
}
#Desinstalar NEXTCLOUD
desinst_bot() {
rm -r Miku-MD &>/dev/null
echo -e "\e[1;37m DESINSTALADO CON ÉXITO "
read -p "enter"
menu
}
#Agregar DOMINIO 
activa() {
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "Miku-MD")
if [[ ! $PIDGEN ]]; then
cd Miku-MD
npm install --arch=x64 --platform=linux sharp
screen -S Miku-MD npm start
else
screen -S Miku-MD -p 0 -X quit
fi
}
#screen -S naze-md &>/dev/null
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
#[[ -e /snap/nextcloud/current/meta/snap.yaml ]] && webminn="\033[1;32m[ON]" || webminn="\033[1;31m[OFF]"
menu(){
unset PID_GEN
PID_GEN=$(ps x|grep -v grep|grep "Miku-MD")
[[ ! $PID_GEN ]] && PID_GEN="\033[1;31m[ ✖ OFF ✖] 🔴" || PID_GEN="\033[1;32m[ LINEA ] 🟢"
[[ -e Miku-MD/config.json ]] && php="\033[1;32m[ON]" || php="\033[1;31m[OFF]"
[[ -e /etc/apache2/sites-available/drupal.conf ]] && apac="\033[1;32m[ON]" || apac="\033[1;31m[OFF]"
clear
echo -e "$barra"
#echo -e "${lor4}$banner1 ${lor7}"
figlet " -WHATSAPP- "| lolcat
echo -e "$barra"
    print_center -azu "=====>>>> BOT-WHATSAPP <<<<====="|lolcat
echo -e "$barra"
echo -e "       \033[1;31mINSTALADO: $php"
#echo -e "\033[1;31m=  \e[1;37mBOT-WHATSAPP EN $PID_GEN  \033[0m"
echo -e "$barra"
echo -e " [1] INSTALAR BOT WHATSAPP"
echo -e " [2] DESINSTALAR BOT"
echo -e " [3] ACTIVAR BOT"
#echo -e " [3] EXTRAER ZIP (drupal)"
echo -e " [0] \e[1;31mSALIR\e[0m"
echo -e "$barra"
selection=$(selection_fun 6)
case $selection in
0)exit;;
1)install_bot;;
2)desinst_bot;;
3)activa;;
esac
}
menu