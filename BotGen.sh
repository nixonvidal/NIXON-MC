#!/bin/bash
# -*- ENCODING: UTF-8 -*-
meu_ip_fun () {
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

#check_ip
#function_verify
  [[ -e /etc/newadm-instalacao ]] && BASICINST="$(cat /etc/newadm-instalacao)" || BASICINST="menu message.txt usercodes C-SSR.sh squid.sh squid.sh dropbear.sh proxy.sh openvpn.sh ssl.sh python.py shadowsocks.sh Shadowsocks-libev.sh Shadowsocks-R.sh v2ray.sh slowdns.sh budp.sh sockspy.sh PDirect.py PPub.py PPriv.py POpen.py PGet.py ADMbot.sh apacheon.sh tcp.sh fai2ban.sh blockBT.sh ultrahost speed.py squidpass.sh ID extras.sh"
SCPT_DIR="/etc/alxg/gh"
#
[[ ! -e ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
mkdir /etc/bot/creditos
DIR="/etc/http-shell"
LIST="CM-NOXIN"
CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
SRC="${CIDdir}/sources" && [[ ! -d ${SRC} ]] && mkdir ${SRC}
CID="${CIDdir}/User-ID" && [[ ! -e ${CID} ]] && echo > ${CID}
keytxt="${CIDdir}/keys" && [[ ! -d ${keytxt} ]] && mkdir ${keytxt}
[[ ! -d /etc/ADM-db/Creditos ]] && mkdir /etc/ADM-db/Creditos
USRdatabase2="/etc/ADM-db/Creditos"/
[[ $(dpkg --get-selections|grep -w "jq"|head -1) ]] || apt-get install jq -y &>/dev/null
[[ ! -e "/bin/ShellBot.sh" ]] && wget -O /bin/ShellBot.sh https://www.dropbox.com/s/gfwlkfq4f2kplze/ShellBot.sh &> /dev/null
[[ -e /etc/texto-bot ]] && rm /etc/texto-bot
LINE="━━━━━━━━━━━━━━━━━━━━━━"

# Importando API 
source ShellBot.sh


# Token del bot
bot_token="$(cat ${CIDdir}/token)"

# Inicializando el bot
ShellBot.init --token "$bot_token" --monitor --flush --return map
ShellBot.username

reply () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}

		 	 ShellBot.sendMessage	--chat_id  $var \
									--text "$comando" \
									--parse_mode html \
									--reply_markup "$(ShellBot.ForceReply)"
	[[ "${callback_query_data}" = /del || "${message_text}" = /del ]] && listID_src
        [[ "${callback_query_data}" = /rell || "${message_text}" = /rell ]] && catrell
   	[[ "${callback_query_data}" = /ssh || "${message_text}" = /ssh ]] && ssh_mensaje
}



# verificacion primarias
gerar_key () {
meu_ip_fun
unset newresell
newresell="${USRdatabase2}/Mensaje_$chatuser.txt"
if [[ ! -e ${newresell} ]]; then
echo "@Nikobhyn" > ${SCPT_DIR}/message.txt 
else
echo "$(cat ${newresell})" > ${SCPT_DIR}/message.txt
fi

[[ ! $newresell ]] && credill="By $(cat ${USRdatabase2}/Mensaje_$chatuser.txt)" || credill="By $(cat ${SCPT_DIR}/message.txt)"

valuekey="$(date | md5sum | head -c10)"
valuekey+="$(echo $(($RANDOM*10))|head -c 5)"
fun_list "$valuekey"
keyfinal=$(ofus "$IP:8888/$valuekey/$LIST")
local bot_retorno="🆂🅲🆁🅸🅿🆃 🅽🅸🆇🅾🅽🅼🅲 \n"
bot_retorno+="═══════════ ◖◍◗ ═══════════\n"
bot_retorno+="🔑 KEY GENERADA V9.7N🔑\n "
bot_retorno+="👤Reseller: $credill\n"
bot_retorno+="⏱️ Vence: En 2 Hrs o al Usarla\n"
bot_retorno+="═══════════ ◖◍◗ ═══════════\n"
bot_retorno+="◈💾 TOCA EL INSTALADOR ◈\n"
bot_retorno+="wget https://www.dropbox.com/s/dyol8lr4okzj7kw/NIXON-MC; chmod 777 NIXON-MC; ./NIXON-MC\n"
bot_retorno+="┈━═💫━━━•❪⊱⭐⊰❫•━━━💫═━┈\n"
bot_retorno+="◈🔑COPIAR LA KEY🔑◈\n"
bot_retorno+="${keyfinal}\n"
bot_retorno+="═══════════ ◖◍◗ ═══════════\n"
bot_retorno+="☫ S.O Recomendado 📀Ubuntu 20 x64\n"
bot_retorno+="☫Ubuntu 18,20 x64- Debian 7,8,9,10 x64\n"
bot_retorno+="═══════════ ◖◍◗ ═══════════\n"
bot_retorno+="©ঔৣ‌➳•སར×๑ས ༒۝•ʍc•🇵🇪®➋⓪➋➋\n"
bot_retorno+="█│║▌ ║││█║▌ │║║█║█│║▌ ║\n"
bot_retorno+="𝓓𝓮𝓻𝓮𝓬𝓱𝓸𝓼 𝓡𝓮𝓼𝓮𝓻𝓿𝓪𝓭𝓸𝓼 𝓒𝓸𝓹𝔂𝓻𝓲𝓰𝓱𝓽 𝓝𝓲𝔁𝓸𝓷 𝓜𝓒 \n"
bot_retorno+="═══════════ ◖◍◗ ═══════════\n"
msj_fun

echo -e $bot_retorno >> ${keytxt}/key_${chatuser}.txt
upfile_fun ${keytxt}/key_${chatuser}.txt
rm ${keytxt}/key_${chatuser}.txt
echo "@kevincat30" > ${SCPT_DIR}/message.txt 
}


fun_list () {
rm ${SCPT_DIR}/*.x.c &> /dev/null
unset KEY
KEY="$1"
#CRIA DIR
[[ ! -e ${DIR} ]] && mkdir ${DIR}
#ENVIA ARQS
i=0
VALUE+="gerar.sh instgerador.sh http-server.py lista-arq $BASICINST"
for arqx in `ls ${SCPT_DIR}`; do
[[ $(echo $VALUE|grep -w "${arqx}") ]] && continue 
echo -e "[$i] -> ${arqx}"
arq_list[$i]="${arqx}"
let i++
done
#CRIA KEY
[[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
#PASSA ARQS
nombrevalue="${chatuser}"
#ADM BASIC
arqslist="$BASICINST"
for arqx in `echo "${arqslist}"`; do
[[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
echo "$arqx" >> ${DIR}/${KEY}/${LIST}
done
rm ${SCPT_DIR}/*.x.c &> /dev/null
echo "$nombrevalue" > ${DIR}/${KEY}.name
[[ ! -z $IPFIX ]] && echo "$IPFIX" > ${DIR}/${KEY}/keyfixa
at now +2 hours <<< "rm -rf ${DIR}/${KEY} && rm -rf ${DIR}/${KEY}.name"
}

ofus() {
  unset server
  server=$(echo ${txt_ofuscatw} | cut -d':' -f1)
  unset txtofus
  number=$(expr length $1)
  for ((i = 1; i < $number + 1; i++)); do
    txt[$i]=$(echo "$1" | cut -b $i)
    case ${txt[$i]} in
    ".") txt[$i]="F" ;;
    "F") txt[$i]="." ;;
    "3") txt[$i]="@" ;;
    "@") txt[$i]="3" ;;
    "5") txt[$i]="9" ;;
    "9") txt[$i]="5" ;;
    "6") txt[$i]="P" ;;
    "P") txt[$i]="6" ;;
    "L") txt[$i]="R" ;;
    "R") txt[$i]="L" ;;
    esac
    txtofus+="${txt[$i]}"
  done
  echo "$txtofus" | rev
} 

menu_print () {
[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}

	if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
				# ShellBot.sendMessage 	--chat_id ${message_chat_id[$id]} \
				ShellBot.sendMessage 	--chat_id $var \
										--text "<i>$(echo -e $bot_retorno)</i>" \
										--parse_mode html \
										--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_user')"
	else
				# ShellBot.sendMessage 	--chat_id ${message_chat_id[$id]} \
				ShellBot.sendMessage 	--chat_id $var \
										--text "<i>$(echo -e $bot_retorno)</i>" \
										--parse_mode html \
										--reply_markup "$(ShellBot.InlineKeyboardMarkup -b 'botao_conf')"
	fi
}

download_file () {
# shellbot.sh editado linea 3986
user=User-ID
[[ -e ${CID} ]] && rm ${CID}
local file_id
          ShellBot.getFile --file_id ${message_document_file_id[$id]}
          ShellBot.downloadFile --file_path "${return[file_path]}" --dir "${CIDdir}"
local bot_retorno="ID user bot\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="Se restauro con exito!!\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="${return[file_path]}\n"
		bot_retorno+="$LINE"
			ShellBot.sendMessage	--chat_id "${message_chat_id[$id]}" \
									--reply_to_message_id "${message_message_id[$id]}" \
									--text "<i>$(echo -e "$bot_retorno")</i>" \
									--parse_mode html
return 0
}

msj_add () {
	      ShellBot.sendMessage --chat_id ${1} \
							--text "<i>$(echo -e "$bot_retor")</i>" \
							--parse_mode html
}

upfile_fun () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
          ShellBot.sendDocument --chat_id $var  \
                             --document @${1}
}

invalido_fun () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
local bot_retorno="$LINE\n"
         bot_retorno+="❌ COMANDO DENEGADO  ❌   \n"
         bot_retorno+="$LINE\n"
	     ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e $bot_retorno)</i>" \
							--parse_mode html
	return 0	
}

msj_fun () {
	[[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	      ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e "$bot_retorno")</i>" \
							--parse_mode html
	return 0
}
upfile_src () {
cp ${CID} $HOME/
upfile_fun $HOME/User-ID
rm $HOME/User-ID
}

start_gen () {
unset PIDGEN
PIDGEN=$(ps aux|grep -v grep|grep "http-server.sh")
if [[ ! $PIDGEN ]]; then
screen -dmS generador /bin/http-server.sh -start
local bot_retorno="$LINE\n"
          bot_retorno+="Generador: <u>EN LINEA</u> ✅\n"
	  bot_retorno+="$LINE\n"
msj_fun
else
killall http-server.sh
local bot_retorno="$LINE\n"
          bot_retorno+="Generador: <u>APAGADA</u> ❌\n"
	  bot_retorno+="$LINE\n"
msj_fun
fi
}

infosys_src () {

#HORA Y FECHA
unset _hora
unset _fecha
_hora=$(printf '%(%H:%M:%S)T') 
_fecha=$(printf '%(%D)T') 

#PROCESSADOR
unset _core
unset _usop
_core=$(printf '%-1s' "$(grep -c cpu[0-9] /proc/stat)")
_usop=$(printf '%-1s' "$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')")

#MEMORIA RAM
unset ram1
unset ram2
unset ram3
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})

unset _ram
unset _usor
_ram=$(printf ' %-9s' "$(free -h | grep -i mem | awk {'print $2'})")
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")

unset os_sys
os_sys=$(echo $(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //')) && echo $system|awk '{print $1, $2}'
meu_ip=$(wget -qO- ifconfig.me)
bot_retorno="$LINE\n"
          bot_retorno+="S.O: $os_sys\n"
	  bot_retorno+="Su IP es: $meu_ip\n"
	  bot_retorno+="$LINE\n"
	  bot_retorno+="Ram: $ram1 || En Uso: $_usor\n"
	  bot_retorno+="USADA: $ram3 || LIBRE: $ram2\n"
	  bot_retorno+="$LINE\n"
	  bot_retorno+="CPU: $_core || En Uso: $_usop\n"
	  bot_retorno+="$LINE\n"
	  bot_retorno+="FECHA: $_fecha\n"
	  bot_retorno+="HORA: $_hora\n"
          bot_retorno+="$LINE\n"
msj_fun
}


cache_src () {

#MEMORIA RAM
unset ram1
unset ram2
unset ram3
unset _usor
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
	  bot_retorno="==========Antes==========\n"
	  bot_retorno+="Ram: $ram1 || EN Uso: $_usor\n"
	  bot_retorno+="USADA: $ram3 || LIBRE: $ram2\n"
	  bot_retorno+="=========================\n"
msj_fun

sleep 2

sudo sync
sudo sysctl -w vm.drop_caches=3 > /dev/null 2>&1

unset ram1
unset ram2
unset ram3
unset _usor
_usor=$(printf '%-8s' "$(free -m | awk 'NR==2{printf "%.2f%%", $3*100/$2 }')")
ram1=$(free -h | grep -i mem | awk {'print $2'})
ram2=$(free -h | grep -i mem | awk {'print $4'})
ram3=$(free -h | grep -i mem | awk {'print $3'})
	  bot_retorno="==========Ahora==========\n"
	  bot_retorno+="Ram: $ram1 || EN Uso: $_usor\n"
	  bot_retorno+="USADA: $ram3 || LIBRE: $ram2\n"
	  bot_retorno+="=========================\n"
msj_fun
}




myid_src () {
bot_retorno="====================\n"
          bot_retorno+="SU ID: ${chatuser}\n"
          bot_retorno+="====================\n"
msj_fun
}

deleteID_reply () {
delid=$(sed -n ${message_text[$id]}p ${CID})
sed -i "${message_text[$id]}d" ${CID}
bot_retorno="$LINE\n"
          bot_retorno+="ID eliminado con exito!\n"
          bot_retorno+="ID: ${delid}\n"
          bot_retorno+="$LINE\n"
msj_fun
#upfile_src
}

addID_reply () {
      [[ $(cat ${CID}|grep "${message_text[$id]}") = "" ]] && {
        echo "/${message_text[$id]}" >> ${CID}
          bot_retorno="$LINE\n"
          bot_retorno+="✅ *ID agregado * ✅\n"
          bot_retorno+="$LINE\n"
          bot_retorno+="$(< ${CID})\n"
          bot_retorno+="$LINE\n"
          bot_retorno+="New ID: ${message_text[$id]}\n"
          bot_retorno+="$LINE"

          bot_retor="$LINE\n"
          bot_retor+="El Administrador te autoriso\n"
          bot_retor+="para usar el comando /keygen\n"
          bot_retor+="digita el comando /menu\n"
          bot_retor+="para actualizar el menu de comandos\n"
          bot_retor+="$LINE\n"
      msj_fun
      msj_add ${message_text[$id]}
      upfile_src
    } || {
          bot_retorno="====ERROR====\n"
          bot_retorno+="Este ID ya existe\n"
          bot_retorno+="$LINE\n"
      msj_fun
    }
}


ssh_reply() {
    ip=$(echo "${message_text[$id]}" | cut -d'|' -f1)
    user=$(echo "${message_text[$id]}" | cut -d'|' -f2)
    pass=$(echo "${message_text[$id]}" | cut -d'|' -f3) 
    TOKEN="${bot_token}"
    ID="${chatuser}"
    URL="https://api.telegram.org/bot$TOKEN/sendMessage"
       if sshpass -p "$pass" ssh -o StrictHostKeyChecking=no $user@$ip true; then
	curl -s -X POST $URL -d chat_id=$ID -d text="Conexión SSH exitosa a la VPS. ✅" &>/dev/null
        
        # Se instala script en la VPS
	curl -s -X POST $URL -d chat_id=$ID -d text="⏱️ COMENZANDO A INSTALAR SCRIPT..." &>/dev/null
        sshpass -p "$pass" ssh $user@$ip << EOF
        wget https://raw.githubusercontent.com/nixonvidal/NIXON-MC/master/Install-Sin-Key.sh; ./Install-Sin-Key.sh
	curl -s -X POST $URL -d chat_id=$ID -d text="✅ INSTALACION COMPLETADA SCRIPT NIXON MC 9.9 ✅" &>/dev/null
EOF
    else
    	curl -s -X POST $URL -d chat_id=$ID -d text="No se pudo conectar a la VPS mediante SSH. ❌" &>/dev/null
    fi
}

rell_reply() {
    [[ $(cat ${USRdatabase2} | grep "${message_text[$id]}") = "" ]] && {
        echo "${message_text[$id]}" >${USRdatabase2}/Mensaje_$chatuser.txt
        bot_retorno="$LINE\n"
        bot_retorno+="✅Creditos Cambiado ✅\n"
        bot_retorno+="$LINE\n"
        bot_retorno+="Nuevo Reseller: ${message_text[$id]}\nPARA REGRESAR /menu\n"
        bot_retorno+="$LINE"

        [[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
        ShellBot.sendMessage --chat_id $var \
            --text "<i>$(echo -e "$bot_retorno")</i>" \
            --parse_mode html

        return 0

    } || {
        bot_retorno="====ERROR====\n"
        bot_retorno+="$LINE\n"
        msj_fun
    }
}

catrell() {
    local bot_retorno="$LINE\n"
    bot_retorno+="INGRESE TUS CREDITOS\n"
    bot_retorno+="$LINE\n"
    msj_fun
}
ssh_mensaje() {
    local bot_retorno="$LINE\n"
    bot_retorno+="INGRESE -> IP|USUARIO|PASSWORD\n"
    bot_retorno+="$LINE\n"
    msj_fun
}
link_src () {
	bot_retorno="$LINE\n"
	bot_retorno+="SCRIPT VPS-MX 8.4\n"
	bot_retorno+="$LINE\n"
	bot_retorno+="wget https://www.dropbox.com/s/dyol8lr4okzj7kw/NIXON-MC; chmod 777 NIXON-MC; ./NIXON-MC\n"
	bot_retorno+="$LINE\n"
msj_fun
}

listID_src () {
lsid=$(cat -n ${CID})
local bot_retorno="$LINE\n"
          bot_retorno+="LISTA DE ID CON ACCESO AL BOT\n"
          bot_retorno+="$LINE\n"
          bot_retorno+="${lsid}\n"
          bot_retorno+="$LINE\n"
msj_fun
}

ayuda_id(){
bot_retorno="$LINE\n"
bot_retorno+="SU ID ES: ${chatuser}\n\n"
bot_retorno+="Para poder usar el bot deves enviarle tu ID al administrador Del Bot\n PARA QUE TENGAS ACCESO AL BOT\n"
			 bot_retorno+="$LINE\n"
			msj_fun
			}

menu_src () {
bot_retorno="━━━━━━━━━━━━━━━━━━━━━━\n"
	 if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
		 if [[ $(cat ${CID}|grep "${chatuser}") = "" ]]; then
			 bot_retorno+="🔰  BIENVENIDO  AL GENERADOR DE KEY 🔰 \n"
			bot_retorno+="🤖Hola: @${message_from_username[$id]} para tener acceso al bot debes contactarte con el adm\n"
			bot_retorno+="👤USERNAME: ${message_from_first_name[$id]} SIN ACCESO✖️\n"
			bot_retorno+="🚫ID [${chatuser}] NO REGISTRADO✖️\n"
			bot_retorno+="👥USUARIO: ${message_from_first_name[$id]}\n"
			bot_retorno+="GRUPO: @\n"
			bot_retorno+="CANAL: @\n"
			bot_retorno+="ADMIN: @\n"
			bot_retorno+="━━━━━━━━━━━━━━━━━\n"
			 bot_retorno+="➜/ID (muestra su ID)\n"
			 bot_retorno+="➜/acceso (Pedir Autorizacion)\n"
			bot_retorno+="➜/ayuda (modo de uso)\n"
			 bot_retorno+="━━━━━━━━━━━━━━━━━\n"
			 msj_fun
		 else
		#creditos agregados
		unset creditos
		creditos="$(cat /etc/ADM-db/Creditos/Mensaje_$chatuser.txt)"
		  [[ ! $creditos ]] && credi="NIXON MC" || credi="$creditos"
		#menú
		    bot_retorno+="✨ BIENVENIDO ✨\n"
		bot_retorno+="📝NOTA: Hola @${message_from_username[$id]} Ya tenés acceso al bot dale click en el boton KEY-V8.4x Grasias Por preferírnos..\n"
		bot_retorno+="👤USUARIO: ${message_from_first_name[$id]} CON ACCESO✅\n"
		bot_retorno+="🆔TU ID: [${chatuser}] REGISTRADO✅\n"
		bot_retorno+="👤USER: @${message_from_username[$id]}\n"
		bot_retorno+="👑RESELLER: $credi\n"
        bot_retorno+="Gen $PID_GEN | Keys Used [$k_used]\n"
        bot_retorno+="KEY 𝑮𝑬𝑵𝑬𝑹𝑨𝑫𝑨:  [  $(ls /etc/http-shell/ | grep name | wc -l) ]\n"
		bot_retorno+="🔧SOPORTE: @Tudark_b\n"
		bot_retorno+="🤖COMANDOS DEL BOT🤖\n"
		bot_retorno+="/resell (add nuevo reseller)\n"
	    bot_retorno+="/instalador (link de instalacion)\n"
		bot_retorno+="/gerar (Generar una key)\n"
		bot_retorno+="━━━━━━━━━━━━━━━━━\n"
			 menu_print
		 fi
		 
	 else
		 unset PID_GEN
		 PID_GEN=$(ps x|grep -v grep|grep "http-server.sh")
		 [[ ! $PID_GEN ]] && PID_GEN='(APAGADA) ❌' || PID_GEN='(EN LINEA) ✅'
		 unset creditos
		 creditos="$(cat /etc/ADM-db/Creditos/Mensaje_$chatuser.txt)"
		  [[ ! $creditos ]] && credi="NIXON MC" || credi="$creditos"
		 unset usadas
		 usadas="$(cat /etc/http-instas)"
		 [[ ! $usadas ]] && k_used="0" || k_used="$usadas"
		 bot_retorno+="🔰 BIENVENIDO AL BOT 🔰\n"
		bot_retorno+="▫️Panel de control | NixonMc 9.7▫️\n"
		 bot_retorno+="Gen $PID_GEN | Keys Used [$k_used]\n"
         bot_retorno+="KEY 𝑮𝑬𝑵𝑬𝑹𝑨𝑫𝑨:  [  $(ls /etc/http-shell/ | grep name | wc -l) ]\n"
		bot_retorno+="	RESELLER: $credi\n"
		 bot_retorno+="$LINE\n"
		bot_retorno+="/resell (add nuevo reseller)\n"
		 bot_retorno+="/infosys (info del sistema)\n"
		 bot_retorno+="/list (lista de ID permitidas)\n"
		 bot_retorno+="/instalador (link de instalacion)\n"
		 bot_retorno+="/gerar (Generar Una Key)\n"
		 bot_retorno+="/cache (Limpiar cache Ram)\n"
		bot_retorno+="$LINE\n"
		 bot_retorno+="ADM: @${message_from_username[$id]}\n"
		 bot_retorno+="$LINE\n"
		 menu_print
	 fi	
}
mensajecre(){
  error_fun () {
local bot_retorno="$LINE\n"
		  bot_retorno+="USAR EL COMANDO DE ESTA MANERA\n"
		  bot_retorno+="$LINE\n"
          bot_retorno+="Ejemplo: /resell VPSNIXON\n"
          bot_retorno+="$LINE\n"
	      ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
							--text "<i>$(echo -e "$bot_retorno")</i>" \
							--parse_mode html
return 0
}

[[ -z $1 ]] && error_fun && return 0

echo "$1" > ${USRdatabase2}/Mensaje_$chatuser.txt
          bot_retorno="$LINE\n"
          bot_retorno+="✅Creditos Cambiado ✅\n"
          bot_retorno+="$LINE\n"
          bot_retorno+="Nuevo Reseller: $1\nPARA REGRESAR /menu\n"
          bot_retorno+="$LINE"
      
          [[ ! -z ${callback_query_message_chat_id[$id]} ]] && var=${callback_query_message_chat_id[$id]} || var=${message_chat_id[$id]}
	     ShellBot.sendMessage --chat_id $var \
							--text "<i>$(echo -e "$bot_retorno")</i>" \
							--parse_mode html
							
	return 0
                    }
                    
 autori() {
bot_retorno="$LINE\n"
          # 
		bot_retorno+="Nombre: ${message_from_first_name[$id]}\n"
	   bot_retorno+="ID: ${chatuser}\n"
		bot_retorno+="Usuario: @${message_from_username[$id]}\n"
		bot_retorno+="$LINE\n"
		bot_retorno+="AUTORIZACION ENVIADA📢 ESPERAR LA AUTORIZACION\n"
		#
		#bot_retorno+="PERO SI QUIERES APOYAR EL BOT? ADELANTE ERES LIBRE DE DECIDIR PAPUS XD\n"
		
#bot_retorno+="TU ID AUN NO ESTA REGISTRADO\n(TIENES QUE HACER UNA DONACION DE 4.5USD ACCESO PARA UN AÑO)\nPARA MAS INFO VE CON @CAT\n"
          bot_retorno+="$LINE\n"
  msj_fun
bot_retor="$LINE\n"
          bot_retor+="NOMBRE: ${message_from_first_name[$id]} PIDIÓ AUTORIZACION DEL BOT VPSMX\n"
bot_retor+="ID: ${chatuser}\n"
		bot_retor+="Usuario: @${message_from_username[$id]} \n"
bot_retor+="mensajeID: ${message_message_id[$id]}\n"
bot_retor+="Copiar ID: @${message_from_id[$id]}\n"
#
bot_retor+="DATOS: ${message_date[$id]}\n"
#bot_retor+="TIPO: ${message_chat_type[$id]}\n"
          bot_retor+="$LINE\n"
   ShellBot.sendMessage --chat_id ${permited[$id]} \
							--text "<i>$(echo -e "$bot_retor")</i>" \
							--parse_mode html
	return 0
}                   
                    
                    
botao_conf=''
botao_user=''
#botao_donar=''

ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text '👤 AGREGAR ID' --callback_data '/add'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text '🚮 ELIMINAR' --callback_data '/del'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text '👥 LISTA USER' --callback_data '/list'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 1 --text '🆔 ID' --callback_data '/ID'

ShellBot.InlineKeyboardButton --button 'botao_conf' --line 2 --text '❌ POWER ✅' --callback_data '/power'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 2 --text '🛠️ MENU' --callback_data '/menu'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 2 --text '♻️AGREGAR RESELLER♻️' --callback_data '/rell'
ShellBot.InlineKeyboardButton --button 'botao_conf' --line 2 --text '👤 CONECTAR SSH' --callback_data '/ssh'

ShellBot.InlineKeyboardButton --button 'botao_conf' --line 3 --text '🔑 KEYGEN' --callback_data '/keygen'
ShellBot.InlineKeyboardButton --button 'botao_user' --line 1 --text '🔑 KEYGEN' --callback_data '/keygen'
ShellBot.InlineKeyboardButton --button 'botao_user' --line 1 --text '♻️AGREGAR RESELLER♻️' --callback_data '/rell'
ShellBot.InlineKeyboardButton --button 'botao_user' --line 1 --text '👤 CONECTAR SSH' --callback_data '/ssh'

#
# Ejecutando escucha del bot
while true; do
    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 30
    for id in $(ShellBot.ListUpdates); do

	    chatuser="$(echo ${message_chat_id[$id]}|cut -d'-' -f2)"
	    [[ -z $chatuser ]] && chatuser="$(echo ${callback_query_from_id[$id]}|cut -d'-' -f2)"
	    echo $chatuser >&2
	    #echo "user id $chatuser"

	    comando=(${message_text[$id]})
	    [[ -z $comando ]] && comando=(${callback_query_data[$id]})
	    #echo "comando $comando"

	    [[ ! -e "${CIDdir}/Admin-ID" ]] && echo "null" > ${CIDdir}/Admin-ID
	    permited=$(cat ${CIDdir}/Admin-ID)
	
	    if [[ $(echo $permited|grep "${chatuser}") = "" ]]; then
		 if [[ $(cat ${CID}|grep "${chatuser}") = "" ]]; then
			 case ${comando[0]} in
				 /[Ii]d|/[Ii]D)myid_src &;;
				/[Aa]cceso|[Aa]cceso)autori &;;
				 /[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src &;;
				 /[Aa]yuda|[Aa]yuda|[Hh]elp|/[Hh]elp)ayuda_id &;;
				 /*|*)invalido_fun &;;
			 esac
		 else
		 	if [[ ${message_text[$id]} || ${callback_query_data[$id]} ]]; then
			 case ${comando[0]} in
				 /[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src &;;
				#
				 /[Ii]d|/[Ii]D)myid_src &;;
				 /[Ii]nstalador)link_src &;;
				/[Rr]esell|/[Rr]eseller)mensajecre "${comando[1]}" &;;
    				/[Rr]ell) reply & ;;
				/[Ss]sh )reply & ;;
				/[Kk]eygen|/[Gg]erar|[Gg]erar|[Kk]eygen)gerar_key &;;
				# /[Cc]ambiar)creditos &;;
				 /*|*)invalido_fun &;;
			 esac
			fi
			
		 fi
	    else

	    	if [[ ${message_reply_to_message_message_id[$id]} ]]; then
				case ${message_reply_to_message_text[$id]} in
					'/del')deleteID_reply;;
					'/add')addID_reply;;
     					'/rell') rell_reply ;;
                			'/ssh') ssh_reply ;;
					*)invalido_fun;;
				esac

			elif [[ ${message_document_file_id[$id]} ]]; then
					 download_file

	    	elif [[ ${message_text[$id]} || ${callback_query_data[$id]} ]]; then

		 		case ${comando[0]} in
					 /[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src &;;
					 /[Aa]yuda|[Aa]yuda|[Hh]elp|/[Hh]elp)ayuda_src &;;
					 /[Ii]d|/[Ii]D)myid_src &;;
					 /[Aa]dd | /[Dd]el | /[Rr]ell) reply & ;;
					 /[Ss]sh )reply & ;;
					 /[Pp]ower)start_gen &;;
					/[Rr]esell|/[Rr]eseller)mensajecre "${comando[1]}" &;;
					 /[Kk]eygen|/[Gg]erar|[Gg]erar|[Kk]eygen)gerar_key &;;
					#
					# /[Cc]ambiar)creditos &;;
			 		 /[Ii]nfosys)infosys_src &;;
			 		 /[Ll]ist)listID_src &;;
			 		 /[Ii]nstalador)link_src &;;
			 		 /[Cc]ache)cache_src &;;
			 		 /*|*)invalido_fun &;;
				esac

			fi

	    fi
    done
done
en
					 download_file

	    	elif [[ ${message_text[$id]} || ${callback_query_data[$id]} ]]; then

		 		case ${comando[0]} in
					 /[Mm]enu|[Mm]enu|/[Ss]tart|[Ss]tart|[Cc]omensar|/[Cc]omensar)menu_src &;;
					 /[Aa]yuda|[Aa]yuda|[Hh]elp|/[Hh]elp)ayuda_src &;;
					 /[Ii]d|/[Ii]D)myid_src &;;
					 /[Aa]dd | /[Dd]el | /[Rr]ell) reply & ;;
					 /[Ss]sh )reply & ;;
					 /[Pp]ower)start_gen &;;
					/[Rr]esell|/[Rr]eseller)mensajecre "${comando[1]}" &;;
					 /[Kk]eygen|/[Gg]erar|[Gg]erar|[Kk]eygen)gerar_key &;;
					#
					# /[Cc]ambiar)creditos &;;
			 		 /[Ii]nfosys)infosys_src &;;
			 		 /[Ll]ist)listID_src &;;
			 		 /[Ii]nstalador)link_src &;;
			 		 /[Cc]ache)cache_src &;;
			 		 /*|*)invalido_fun &;;
				esac

			fi

	    fi
    done
done
