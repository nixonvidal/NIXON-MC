#!/bin/bash
kevin="/etc/vpscat" && [[ ! -d ${kevin} ]] && exit
kevin >/dev/null 2>&1
clear
# INSTALACAO BASICA
#
#-------------BY KEVIN-----------

FECHA=$(date +"%d-%m-%y")
TIEMPO=$(date +"%T")
gt="/etc/kevn" && [[ ! -d ${gt} ]] && mkdir ${gt}
system=$(cat /etc/issue.net)
#BY VPSCAT
#
#
BASICINST="menu message.txt usercodes C-SSR.sh squid.sh squid.sh dropbear.sh proxy.sh openvpn.sh ssl.sh python.py shadowsocks.sh Shadowsocks-libev.sh Shadowsocks-R.sh v2ray.sh slowdns.sh budp.sh sockspy.sh PDirect.py PPub.py PPriv.py POpen.py PGet.py ADMbot.sh apacheon.sh tcp.sh fai2ban.sh blockBT.sh ultrahost speed.py squidpass.sh ID extras.sh"
IVAR="/etc/http-instas"
IVAR2="/etc/key-gerador"
log="/etc/gerar-sh-log"
insta="\E[1;31mINSTALACIONES :\033[0m"
#gen="\e[1;31m[ \E[1;33mGENERADOR DE KEYS \e[1;31m].\E[1;31m[ \E[1;33m❯❯VPS-MX-MOD❮❮\E[1;31m]  \033[0m"
BARRA="\e[1;35m-➖-➖-➖-➖-➖-➖-➖-➖-➖-➖-➖-➖-➖-➖-➖-➖ \e[0m"
#BARRA1=""
#PANEL GENERADOR MASTER
menu() {
  SCPT_DIR="${gt}/gh"
  [[ ! -e ${SCPT_DIR} ]] && mkdir ${SCPT_DIR}
  rm ${SCPT_DIR}/*.x.c &>/dev/null
  INSTA_ARQUIVOS="ADMVPS.zip"
  credi="$(less ${gt}/gh/message.txt)"
  cre="\E[1;31m[\E[1;32m $credi \E[1;31m]\033[0m"
  #credi1="$(less ${gt}/gh/numero.txt)"
  #numero="\E[1;31m[\E[1;32m $credi1 \E[1;31m]\033[0m"
  DIR="/etc/http-shell"
  LIST="CM-NOXIN"
  #figlet "  *NIXON MC*"|lolcat
  #echo -e "$BARRA1"
  KEYI=$(ps x | grep -v grep | grep "nc.traditional")
  [[ ! $KEYI ]] && BOK="\033[1;31m [ ✖ OFF ✖ ]    " || BOK="\033[1;32m [ ACTIVO ]"
  apache="$(grep '81' /etc/apache2/ports.conf | cut -d' ' -f2 | grep -v 'apache2' | xargs)" || apachep="$(grep '80' /etc/apache2/ports.conf | cut -d' ' -f2 | grep -v 'apache2' | xargs)"
  #

  [[ ! -e /etc/bot-alx/system ]] && systema="VPSCAT" || systema=$(cat /etc/bot-alx/system)
  unset ram1
  unset ram2
  unset ram3
  ram1=$(free -h | grep -i mem | awk {'print $2'})
  ram2=$(free -h | grep -i mem | awk {'print $4'})
  ram3=$(free -h | grep -i mem | awk {'print $3'})
  #procesador=cat /proc/cpuinfo | grep processor | wc -l
  echo -e "$BARRA"
  echo -e "	\e[1;36m\033[1;100m=====>>   VPS NIKOBHYN  <<=====\033[0m"
  echo -e "$BARRA"
  #echo -e "           $gen                   "
  echo -e "	\e[36mCREDITOS: $cre 974312499"
  #echo -e "	\e[36mNUMEROS: $numero"
  echo -e "$BARRA"
  echo -e "	\033[33m\033[107m  => @NIXON MC  => \e[0m   $insta\033[1;33m  $(cat $IVAR)\033[0m"
  echo -e "$BARRA"
  echo -e "\e[1;36m      APACHE: \e[1;32m $apache     \e[1;36mKEYGEN: \e[1;32m$BOK"
  echo -e "   \e[1;93m$systema \e[97mRam: \e[92m$ram1 \e[97mLibre: \e[92m$ram2 \e[97mUsado: \e[92m$ram3 "
  #echo -e "    \e[97mProcesador: \e[92m$procesador" 
  echo -e "$BARRA"
  echo -e "\e[1;34mSISTEMA: \e[1;32m$system"
  echo -e "\e[1;33m[\e[1;31m FECHA: \e[1;35m$FECHA 	 \e[1;31mHORA: \e[1;35m$TIEMPO \E[1;33m]\033[0m"
}
meu_ip() {
  MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
  MIP2=$(wget -qO- ipv4.icanhazip.com)
  [[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}

meu_ip
fun_list() {
  unset KEY
  KEY="$1"
  #CRIA DIR
  [[ ! -e ${DIR} ]] && mkdir ${DIR}
  [[ ! -e ${DIR}/${KEY} ]] && mkdir ${DIR}/${KEY}
  #ENVIA ARQS
  i=0
  for arqx in $(ls ${SCPT_DIR}); do
    [[ $(echo $BASICINST | grep -w "${arqx}") ]] && continue
    arq_list[$i]="${arqx}"
    let i++
  done
  echo -e "🛑KEYS ADMMOD-MX🛑  "

  echo -e "[b] -> \033[31mNSTALACION VPS-MX-MOD  \033[0m"
  read -p "ELEJIR LA OPCION ( b ): " -e -i b readvalue
  [[ -z $readvalue ]] && readvalue="b"
  read -p "NOMBRE DE USUARIO: " nombrevalue
  [[ -z $nombrevalue ]] && nombrevalue="unnamed"
  read -p "KEY FIJA? [S/N]: " -e -i n fixakey
  [[ $fixakey = @(s|S|y|Y) ]] && read -p "IP-FIJA: " IPFIX && nombrevalue+=[FIXA]
  if [[ $readvalue = @(b|B) ]]; then
    #ADM BASIC
    arqslist="$BASICINST"
    for arqx in $(echo "${arqslist}"); do
      [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
      cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
      echo "$arqx" >>${DIR}/${KEY}/${LIST}
    done
  elif [[ $readvalue = @(x|X) ]]; then
    #FULL ARQS
    for arqx in $(echo "${arq_list[@]}"); do
      [[ -e ${DIR}/${KEY}/$arqx ]] && continue #ANULA ARQUIVO CASO EXISTA
      cp ${SCPT_DIR}/$arqx ${DIR}/${KEY}/
      echo "$arqx" >>${DIR}/${KEY}/${LIST}
    done
    echo "TRUE" >>${DIR}/${KEY}/HERRAMIENTA
  else
    for arqx in $(echo "${readvalue}"); do
      #UNE ARQ
      [[ -e ${DIR}/${KEY}/${arq_list[$arqx]} ]] && continue #ANULA ARQUIVO CASO EXISTA
      cp ${SCPT_DIR}/${arq_list[$arqx]} ${DIR}/${KEY}/
      echo "${arq_list[$arqx]}" >>${DIR}/${KEY}/${LIST}
    done
    echo "TRUE" >>${DIR}/${KEY}/HERRAMIENTA
  fi
  echo "$nombrevalue" >${DIR}/${KEY}.name
  [[ ! -z $IPFIX ]] && echo "$IPFIX" >${DIR}/${KEY}/keyfixa
  echo -e "$BARRA"
  echo -e "KEY ACTIVA, Y ESPERANDO INSTALACION!"
  echo -e "$BARRA"
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

gerar_key() {
  valuekey="$(date | md5sum | head -c10)"
  valuekey+="$(echo $(($RANDOM * 10)) | head -c 5)"
  fun_list "$valuekey"
  keyfinal=$(ofus "$IP:8888/$valuekey/$LIST")
  echo -e "KEY: $keyfinal"
  echo -e "$BARRA"
  echo -e "SCRIPT NIXON-MC : wget https://www.dropbox.com/s/dyol8lr4okzj7kw/NIXON-MC; chmod 777 NIXON-MC; ./NIXON-MC"
  echo -e "$BARRA"
  read -p "Enter para Finalizar"
}
actualizagen_key() {
  i=0
  rm ${SCPT_DIR}/*.x.c &>/dev/null
  [[ -z $(ls $DIR | grep -v "ERROR-KEY") ]] && return
  echo "[$i] Retornar"
  keys="$keys retorno"
  let i++
  for arqs in $(ls $DIR | grep -v "ERROR-KEY" | grep -v ".name"); do
    arqsx=$(ofus "$IP:8888/$arqs/$LIST")
    if [[ $(cat ${DIR}/${arqs}.name | grep GERADOR) ]]; then
      echo -e "\033[1;31m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;32m ($(cat ${DIR}/${arqs}/keyfixa))\033[0m"
      keys="$keys $arqs"
      let i++
    fi
  done
  keys=($keys)
  echo -e "$BARRA"
  while [[ -z ${keys[$value]} || -z $value ]]; do
    read -p "Escoja cual Actualizar[t=todos]: " -e -i 0 value
  done
  [[ $value = 0 ]] && return
  if [[ $value = @(t|T) ]]; then
    i=0
    [[ -z $(ls $DIR | grep -v "ERROR-KEY") ]] && return
    for arqs in $(ls $DIR | grep -v "ERROR-KEY" | grep -v ".name"); do
      KEYDIR="$DIR/$arqs"
      rm $KEYDIR/*.x.c &>/dev/null
      if [[ $(cat ${DIR}/${arqs}.name | grep GERADOR) ]]; then #Keyen Atualiza
        rm ${KEYDIR}/${LIST}
        for arqx in $(ls $SCPT_DIR); do
          cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx
          echo "${arqx}" >>${KEYDIR}/${LIST}
          rm ${SCPT_DIR}/*.x.c &>/dev/null
          rm $KEYDIR/*.x.c &>/dev/null
        done
        arqsx=$(ofus "$IP:8888/$arqs/$LIST")
        echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
      fi
      let i++
    done
    rm ${SCPT_DIR}/*.x.c &>/dev/null
    echo -e "$BARRA"
    echo -ne "\033[0m" && read -p "Enter"
    return 0
  fi
  KEYDIR="$DIR/${keys[$value]}"
  [[ -d "$KEYDIR" ]] && {
    rm $KEYDIR/*.x.c &>/dev/null
    rm ${KEYDIR}/${LIST}
    for arqx in $(ls $SCPT_DIR); do
      cp ${SCPT_DIR}/$arqx ${KEYDIR}/$arqx
      echo "${arqx}" >>${KEYDIR}/${LIST}
      rm ${SCPT_DIR}/*.x.c &>/dev/null
      rm $KEYDIR/*.x.c &>/dev/null
    done
    arqsx=$(ofus "$IP:8888/${keys[$value]}/$LIST")
    echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
    read -p "Enter"
    rm ${SCPT_DIR}/*.x.c &>/dev/null
  }
}
remover_key() {
  i=0
  [[ -z $(ls $DIR | grep -v "ERROR-KEY") ]] && return
  echo "[$i] VOLVER"
  keys="$keys retorno"
  let i++
  for arqs in $(ls $DIR | grep -v "ERROR-KEY" | grep -v ".name"); do
    arqsx=$(ofus "$IP:8888/$arqs/$LIST")
    if [[ ! -e ${DIR}/${arqs}/used.date ]]; then
      echo -e "\033[1;32m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;33m (VÁLIDA)\033[0m"
    else
      echo -e "\033[1;31m[$i] $arqsx ($(cat ${DIR}/${arqs}.name))\033[1;33m ($(cat ${DIR}/${arqs}/used.date) IP: $(cat ${DIR}/${arqs}/used))\033[0m"
    fi
    keys="$keys $arqs"
    let i++
  done
  keys=($keys)
  echo -e "$BARRA"
  while [[ -z ${keys[$value]} || -z $value ]]; do
    read -p "Elija cual eliminar: " -e -i 0 value
  done
  [[ -d "$DIR/${keys[$value]}" ]] && rm -rf $DIR/${keys[$value]}* || return
}
remover_key_usada() {
  i=0
  [[ -z $(ls $DIR | grep -v "ERROR-KEY") ]] && return
  for arqs in $(ls $DIR | grep -v "ERROR-KEY" | grep -v ".name"); do
    arqsx=$(ofus "$IP:8888/$arqs/$LIST")
    if [[ -e ${DIR}/${arqs}/used.date ]]; then #KEY USADA
      if [[ $(ls -l -c ${DIR}/${arqs}/used.date | cut -d' ' -f7) != $(date | cut -d' ' -f3) ]]; then
        rm -rf ${DIR}/${arqs}* && rm -rf ${DIR}/${arqs}
        echo -e "\033[1;31m[KEY]: $arqsx \033[1;32m(ELIMINADO!)\033[0m"
      else
        echo -e "\033[1;32m[KEY]: $arqsx \033[1;32m(AUN ES VALIDA!)\033[0m"
      fi
    else
      echo -e "\033[1;32m[KEY]: $arqsx \033[1;32m(AUN ES VALIDA!)\033[0m"
    fi
    let i++
  done
  echo -e "$BARRA"
  echo -ne "\033[0m" && read -p "Enter"
}
actualizar_keyfixa() {
  i=0
  [[ -z $(ls $DIR | grep -v "ERROR-KEY") ]] && return
  for arqs in $(ls $DIR | grep -v "ERROR-KEY" | grep -v ".name"); do
    if [[ $(cat ${DIR}/${arqs}.name | grep FIXA) ]]; then #Keyfixa Atualiza
      for arqx in $(echo "${BASICINST}"); do
        cp ${SCPT_DIR}/$arqx ${DIR}/${arqs}/$arqx
      done
      arqsx=$(ofus "$IP:8888/$arqs/$LIST")
      echo -e "\033[1;33m[KEY]: $arqsx \033[1;32m(ACTUALIZADA!)\033[0m"
    fi
    let i++
  done
  echo -e "$BARRA"
  echo -ne "\033[0m" && read -p "Enter"
}
start_gen() {
  unset PIDGEN
  PIDGEN=$(ps aux | grep -v grep | grep "http-server.sh")
  if [[ ! $PIDGEN ]]; then
    screen -dmS generador /bin/http-server.sh -start
  else
    killall http-server.sh
  fi

}
message_gen() {
  read -p "NUEVO MENSAJE: " MSGNEW
  echo "$MSGNEW" >${SCPT_DIR}/message.txt
  echo -e "$BARRA"
}
cambionumero() {
  read -p "NUEVO MENSAJE: " MSGNE
  echo "$MSGNE" >${SCPT_DIR}/numero.txt
  echo -e "$BARRA"
}

#-------------------BOTGEN--------------------#
#bot_menu () {
#CIDdir=/etc/ADM-db && [[ ! -d ${CIDdir} ]] && mkdir ${CIDdir}
#[[ ! -e "${CIDdir}/BOT.sh" ]] && wget -O ${CIDdir}/BOT.sh https://raw.githubusercontent.com/nixonvidal/NIXON-MC/master/BotGen.sh &> /dev/null && chmod +x ${CIDdir}/BOT.sh
#sed -i -e 's/\r$//' ${CIDdir}/BOT.sh
#source ${CIDdir}/BOT.sh
#bot_gen
#}

loge() {
  [[ -e $log ]] && echo -e "\e[33m$(cat $log)"
}
atualizar_geb() {

  #cd $HOME
  #tput cuu1 && tput dl1
  echo -e "\e[1;31m   ───── \e[1;34m❖\e[1;31m ── ✦ ── \e[1;34m❖\e[1;31m ─────        \e[0m"
  echo -e "ACTUALIZADOR   \033[1;32m[ GENERADOR ] VPSCAT"
  echo -e "Al proseguir los datos como el tiempo de uso seran perdidos"
  echo -e "\e[1;31m   ───── \e[1;34m❖\e[1;31m ── ✦ ── \e[1;34m❖\e[1;31m ─────        \e[0m"
  while [[ $Key != @(s|S|y|Y|n|N) ]]; do
    read -p " esta de acuerdo [S/N]:" -e -i s Key
    tput cuu1 && tput dl1
  done
  if [[ $Key = @(s|S|y|Y) ]]; then
    wget -O $HOME/gen-master.sh https://www.dropbox.com/s/ni4aru9dt5ug7zh/gen-master.sh &>/dev/null
    chmod +x $HOME/gen-master.sh*
    cd $HOME
    ./gen-master.sh
    rm $HOME/gen-master &>/dev/null
    #$HOME/gen-master.sh
    sleep 2
    echo -e " \e[1;32m\033[1;100m--ACTULIZACION COMPLETA--\033[0m"
    sleep 1
    rm -rf .bash_history

  #rm -rf gen-master.sh &>/dev/null
  else
    echo -e "$BARRA"
    echo -e "Procedimento Cancelado "
    echo -e "$BARRA"
  fi
}

desinstalador() {
  killall http-server.sh
  rm -rf /bin/http-server.sh
  rm -rf /etc/kevn/gh
  rm -rf /etc/kevn
  rm -rf /bin/keygen
  rm -rf /bin/gerar
  rm -rf /usr/bin/gerar.sh
  rm -rf /etc/http-instas
  rm -rf ${DIR}
  rm -rf ${IVAR2}
  rm /etc/paq
}
clear
menu
meu_ip
unset PID_GEN
PID_GEN=$(ps x | grep -v grep | grep "http-server.sh")
[[ ! $PID_GEN ]] && PID_GEN="\033[1;31m[ ✖ OFF ✖] 🔴" || PID_GEN="\033[1;32m[ EN LINEA ] 🟢"
echo -e "\e[31m____________[ \e[97mSELECT AN OPTION \e[31m]____________\033[0m"
echo -e "$BARRA"
echo -e "\033[1;31m[1] \e[1;37m=>  \e[1;32m 🔑 GENERAR 1 KEY ALEATORIA 🔑   \033[0m"
echo -e "\033[1;31m[2] \e[1;37m=>  \e[1;31mAPAGAR < O > VER KEYS  \033[0m"
echo -e "\033[1;31m[3] \e[1;37m=>  \e[1;31mELIMINAR KEYS USADAS  \033[0m"
echo -e "\033[1;31m[4] \e[1;37m=>  \e[1;37mINICIAR/PARAR KEYGEN $PID_GEN  \033[0m"
echo -e "\033[1;31m[5] \e[1;37m=>  \e[1;36mVER REGISTRO  \033[0m"
echo -e "\033[1;31m[6] \e[1;37m=>  \e[1;37m❗CAMBIAR CRÉDITOS❗  \033[0m"
echo -e "\033[1;31m[7] \e[1;37m=>  \e[1;37m❗CAMBIAR NUMERO ❗ \033[0m"
echo -e "\033[1;31m[8] \e[1;37m=>  \e[0m\033[30;42m BOT \033[37;41m TELEGRAM \e[0m"
echo -e "\033[1;31m[9] \e[1;37m=>  \e[1;37mVERIFICAR PUERTO  \033[0m"
echo -e "\033[1;31m[10] \e[1;37m=>  \e[1;32mACTUALIZAR KEYS FIJA  \033[0m"
echo -e "\033[1;31m[11] \e[1;37m=>  \033[1;31mDESINSTALAR GENERADOR\e[0m"
echo -e "\033[1;31m[12] \e[1;37m=>  \e[1;32m📥ACTUALIZAR GENERADOR📥  \033[0m"
echo -e "\033[1;31m[0] \e[1;37m=>  SALIR "
echo -e "$BARRA"
echo -ne "\e[1;31m❭❭❭\e[1;35mSELECIONE UNA OPCIÓN\e[1;31m ❬❬❬\e[1;37m:\e[1;33m "
read selection
case $selection in
1) gerar_key ;;
2) remover_key ;;
3) remover_key_usada ;;
4) start_gen ;;
5) remov_gen ;;
6) message_gen ;;
7) cambionumero ;;
8)
  [[ ! -e /bin/BOT.sh ]] && wget -O /bin/BOT.sh https://raw.githubusercontent.com/nixonvidal/NIXON-MC/master/BOT.sh &>/dev/null && chmod +x /bin/BOT.sh
  BOT.sh
  ;;
9) /etc/kevn/gh/ports.sh ;;
10) actualizar_keyfixa ;;
11)
  read -p "desea desinstalar el generador [ s | n ]: " desinstalador
  [[ "$desinstalador" = "s" || "$desinstalador" = "S" ]] && desinstalador
  ;;
12) atualizar_geb ;;
0) exit 0 ;;
esac
/bin/keygen
