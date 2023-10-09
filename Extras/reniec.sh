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

api () {
mkdir reniec 
wget -O /root/reniec/api.py https://www.dropbox.com/s/yb7j7wfsmjniunv/api.py &>/dev/null 
chmod 777 /root/reniec/api.py
}
barra="\e[1;30m===================================================== \e[0m"
inst() {
echo -ne "	\033[1;37mINSTALL PYTHON    --\e[0m";
fun_kevn 'apt update '
echo -ne "	\033[1;37mINSTALL PYTHON    --\e[0m";
fun_kevn 'sudo apt upgrade'
clear
echo -e "$barra"
apt install python
clear
echo -e "$barra"
apt-get install lolcat -y &>/dev/null
apt-get install figlet -y &>/dev/null
echo -e "$barra"
echo -ne "	\033[1;37mPYTHON    --\e[0m";
fun_kevn 'apt install python2'
echo -ne "	\033[1;37mPYTHON    --\e[0m";
fun_kevn 'apt install python3'
echo -ne "	\033[1;37mPYTHON   --\e[0m";
fun_kevn 'pip install requests'
echo -ne "	\033[1;37mINSTALL API    --\e[0m";
api 
read -p "enter"
menu
}



#Desinstalar NEXTCLOUD
desinst() {
rm -rf reniec
rm -rf /bin/reniec
rm -rf .bash_history
echo -e "\e[1;37m DESINSTALADO CON ÉXITO "
read -p "enter"
}
#VER INFORMACIÓN

consulta(){
CAPERTA_RENIEC="/root/reniec/" 
 cd "$CAPERTA_RENIEC" 
 python3 api.py
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
menu(){
[[ -e /root/reniec/api.py ]] && active="\033[1;32m[ON]" || active="\033[1;31m[OFF]"
clear
echo -e "$barra"
#echo -e "${lor4}$banner1 ${lor7}"
figlet " -RENIEC- "| lolcat
echo -e "$barra"
    print_center -azu "=====>>>> NIXON MC <<<<====="|lolcat
echo -e "$barra"
echo -e "       \033[1;31mINSTALADO: $active "
echo -e "$barra"
echo -e " [1] CONSULTAR DNI"
echo -e " [2] INSTALAR RENIEC"
echo -e " [3] DESINSTALAR"
echo -e " [0] \e[1;31mSALIR\e[0m"
echo -e "$barra"
selection=$(selection_fun 4)
case $selection in
#
0)exit;;
1)consulta;;
2)inst;;
3)desinst;;
esac
}
menu