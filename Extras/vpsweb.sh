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

########
rojo=$(echo -e '\e[0;31m')
purpura=$(echo -e '\e[0;35m')
#########
clear
echo "${rojo}                   __    ________  ________   _____ ";
echo "   ____  _____   _/  |_ /   __   \/   __   \_/ ____\ ";
echo " _/ ___\ \__  \  \   __\\____    /\____    /\   __\ ";
echo " \  \___  / __ \_ |  |     /    /    /    /  |  | ";
echo "  \___  >(____  / |__|    /____/    /____/   |__| ";
echo "      \/      \/ ";
echo ""
permited=$(curl -sSL "https://www.dropbox.com/s/6izalbltprxidbt/passwpanelweb")
read -p "${purpura}ESCRIBA SU CONTRASEÑA:${rojo} " passw
if [[ $permited = $passw ]]; then
#   clear
   msg -bar
   echo -e "\033[1;32m CONTRASEÑA CORRECTA......"
   msg -bar
   sleep 2


###########
wget -O /bin/nixon https://www.dropbox.com/s/eq8afhp4wltavgu/mcvpsweb.sh &>/dev/null && chmod +x /bin/nixon && nixon
###########


else
#   clear
   msg -bar
   echo -e "\033[1;37m LA CONTRASEÑA NO COINCIDE"
   echo -e "\033[1;37m INSTALACION CANSELADA!"
   msg -bar
   sleep 3
fi