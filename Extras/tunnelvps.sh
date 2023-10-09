#!/bin/bash

#---------------BY NIXON MC--------------#
# WEB SSH + SSL + V2RAY -- BETA 0.1
# INSTRUCCIONES DE INSTALACION PHP SSH2

banner1="      ___           _              _ _ _ 
     / _ \_ __ ___ | |_ ___   /\ /(_) | |
    / /_)/ '__/ _ \| __/ _ \ / //_/ | | |
   / ___/| | | (_) | || (_) / __ \| | | |
   \/    |_|  \___/ \__\___/\/  \/|_|_|_| "
   
baner="                                                       
  _____                             _ 
 /__   \ _   _  _ __   _ __    ___ | |
   / /\/| | | || '_ \ | '_ \  / _ \| |
  / /   | |_| || | | || | | ||  __/| |
  \/     \__,_||_| |_||_| |_| \___||_|
                                      
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

##instalacion de scrip tunnelvps 2023##

barra="\e[1;30m===================================================== \e[0m"

install_tunnelvps() {
clear
msg -bar
msg -verm " INSTALACION DE TUNNELVPS \e[37m10"
msg -bar
echo -e "	\e[1;37m [ 1 ] \e[1;31mINSTALANDO APACHE..\e[0m"
msg -bar
apt install apache2
clear

msg -bar
echo -e "	\e[1;37m [ 1 ] \e[1;31mACTIVANDO APACHE..\e[0m"
sudo ufw allow 'Apache'
clear

msg -bar
echo -e "	\e[1;37m [ 1 ] \e[1;31mINSTALANDO CONEXION TUNNELVPS..\e[0m"
apt install php8.1-ssh2
clear

msg -bar
echo -e "	\e[1;37m [ 1 ] \e[1;31mACTIVANDO REPOSITORIOS..\e[0m"
sudo apt update
clear

msg -bar
echo -e "	\e[1;37m [ 1 ] \e[1;31mACTUALIZANDO RECURSOS DE CONEXION..\e[0m"
sudo apt install apt-transport-https lsb-release software-properties-common ca-certificates -y
clear

msg -bar
echo -e "	\e[1;37m [ 1 ] \e[1;31mINSTALANDO CONTROLADOR DE PHP..\e[0m"
sudo apt install php8.1
clear

echo -e "\e[1;37m COMPLETADO CON EXITO "
read -p "enter"
menu
}


desinstall_tunnelvps() {
clear
menu
}
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
menu(){

clear
echo -e "$barra"
echo "$baner"
echo -e "$barra"


         print_center -azu "=====>>>> INSTALADOR OFICIAL DE SNELL <<<<====="|lolcat
echo -e "$barra"
        echo -e "${cor[3]}         ⋙⋙⋙ CREADO POR NIXON-MC ⋘⋘⋘  "
echo -e "$barra"


echo -e "\033[1;31m [1] =  \033[1;31mINSTALAR TUNNELVPS\e[0m"
echo -e "\033[1;31m [2] =  \033[1;31mDESINSTALAR TUNNELVPS  \e[0m"
echo -e " [0] \e[1;31mSALIR\e[0m"
echo -e "$barra"

selection=$(selection_fun 3)
case $selection in
0)exit;;
1)install_tunnelvps;;
2)desinstall_tunnelvps;;

esac
}
menu





on_fun 3)
case $selection in
0)exit;;
1)install_tunnelvps;;
2)desinstall_tunnelvps;;

esac
}
menu





