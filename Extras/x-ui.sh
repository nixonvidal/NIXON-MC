#!/bin/bash
os_version=$(lsb_release -sr);
distribution=$(lsb_release -si);
sslkk (){
sslports=`netstat -tunlp | grep stunnel4 | grep 0.0.0.0: | awk '{print substr($4,9); }' > /tmp/ssl.txt && echo | cat /tmp/ssl.txt | tr '\n' ' ' > /etc/adm-lite/sslports.txt && cat /etc/adm-lite/sslports.txt`;
}
#par=$(v2ray info | grep path |awk -F : '{print $4}')
fun_log () {
[[ -e /bin/ejecutar/sshd_config ]] && { 
####
sysvar=$(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //' | grep -o Ubuntu)
[[ ! $(cat /etc/shells|grep "/bin/false") ]] && echo -e "/bin/false" >> /etc/shells
[[ "$sysvar" != "" ]] && {
echo -e "Port 22
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
Banner /etc/bannerssh" > /etc/ssh/sshd_config
} || {
echo -e "Port 22
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
Banner /etc/bannerssh" > /etc/ssh/sshd_config
}
} || {
cp /etc/ssh/sshd_config /bin/ejecutar/sshd_config
sysvar=$(cat -n /etc/issue |grep 1 |cut -d' ' -f6,7,8 |sed 's/1//' |sed 's/      //' | grep -o Ubuntu)
[[ ! $(cat /etc/shells|grep "/bin/false") ]] && echo -e "/bin/false" >> /etc/shells
[[ "$sysvar" != "" ]] && {
echo -e "Port 22
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
Banner /etc/bannerssh" > /etc/ssh/sshd_config
} || {
echo -e "Port 22
Protocol 2
KeyRegenerationInterval 3600
ServerKeyBits 1024
SyslogFacility AUTH
LogLevel INFO
LoginGraceTime 120
PermitRootLogin yes
StrictModes yes
RSAAuthentication yes
PubkeyAuthentication yes
IgnoreRhosts yes
RhostsRSAAuthentication no
HostbasedAuthentication no
PermitEmptyPasswords no
ChallengeResponseAuthentication no
PasswordAuthentication yes
X11Forwarding yes
X11DisplayOffset 10
PrintMotd no
PrintLastLog yes
TCPKeepAlive yes
#UseLogin no
AcceptEnv LANG LC_*
Subsystem sftp /usr/lib/openssh/sftp-server
UsePAM yes
Banner /etc/bannerssh" > /etc/ssh/sshd_config
}
}
######################

}

selection_fun () {
local selection="null"
local range
for((i=0; i<=$1; i++)); do range[$i]="$i "; done
while [[ ! $(echo ${range[*]}|grep -w "$selection") ]]; do
echo -ne "\033[1;37m Opcion: " >&2
read selection
tput cuu1 >&2 && tput dl1 >&2
done
echo $selection
}


ban_inex () {
ban=$(cat < /etc/adm-lite/menu_credito)
echo -e " "
echo -e "BANNER INEXISTENTE - RECOMENDADO MODIFICAR TU BANNER"
fun_bar 
credi=$(cat < /root/name)
credit=$(cat </etc/adm-lite/menu_credito)
echo -e '<p style="text-align: center;"><strong><span style="color: #FF00FF;">'" $credit "'&reg;</span> |&nbsp;</strong><span style="color: #483D8B;"><strong>'"$credi"'</strong></span></p>' >> /etc/bannerssh
#echo '<p style="text-align: center;"><font color="purple">Verified   reselller   </font></center>' > /etc/bannerssh
#sed -i "s;reselller;$ban;g" /etc/bannerssh
[[ -d /etc/dropbear ]] && {
[[ -e /etc/bannerssh ]] && cat /etc/bannerssh > /etc/dropbear/banner
} || mkdir /etc/dropbear
#[[ ! -e /etc/dropbear/banner ]] && mkdir /etc/dropbear || cat /etc/bannerssh > /etc/dropbear/banner
echo -e "\033[1;32mCambia Banner en ( * \033[1;33m Menu 1\033[1;32m *\033[1;33m opcion 8 \033[1;32m*\033[1;32m)"
read -p "Presiona Enter para Continuar"
dropbearuniversal
}

function dropbearuniversal(){
echo "� Preparando Instalacion, Espere un Momento"
echo -ne "\033[1;31m[ ! ] RESOLVIENDO SSH -> DROPBEAR  "
(
service dropbear stop 1> /dev/null 2> /dev/null
service ssh restart 1> /dev/null 2> /dev/null
) && echo -e "\033[1;32m [OK]" || echo -e "\033[1;31m [FAIL]"
echo -ne "\033[1;31m[ ! ] VERIFICANDO COMPATIBILIDAD DEL BANNER " && sleep 0.5s && echo -e "\033[1;32m [OK]"
[[ -e /etc/bannerssh ]] && {
####
fun_log
####
echo "� Instalando Dropbear"
fun_bar 'apt install dropbear -y'
service dropbear stop 1> /dev/null 2> /dev/null
msg -bar
    while true; do
    echo -ne "\033[1;37m"
    echo -e " INGRESA EL PUERTO DROPBEAR A USAR ( Recomendado 80 o 443 )"
	echo -e " "
    read -p " PUERTO : " puertodropbear
	tput cuu1 && tput dl1
	PortDROP=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $puertodropbear`
	[[ -n "$PortDROP" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$puertodropbear"{print $9}'`
    echo -e "\033[1;33m  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
    unset puertodropbear
	echo -e "$barra"
    done
echo -e "$barra"
echo $puertodropbear > /etc/default/dadd
echo -e "NO_START=0" > /etc/default/dropbear
echo -e 'DROPBEAR_EXTRA_ARGS="-p '$puertodropbear'"' >> /etc/default/dropbear
echo -e 'DROPBEAR_BANNER="/etc/dropbear/banner"' >> /etc/default/dropbear
echo -e "DROPBEAR_RECEIVE_WINDOW=65536" >> /etc/default/dropbear
#sed -i '2i DROPBEAR_PORT="'"$puertodropbear"'"' /etc/default/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
[[ ! -e /etc/dropbear/banner ]] && touch /etc/dropbear/banner || cat /etc/bannerssh > /etc/dropbear/banner 
service dropbear restart 1> /dev/null 2> /dev/null
service ssh restart 1> /dev/null 2> /dev/null
dropbearports=`netstat -tunlp | grep dropbear | grep 0.0.0.0: | awk '{print substr($4,9); }' > /tmp/dropbear.txt && echo | cat /tmp/dropbear.txt | tr '\n' ' ' > /etc/adm-lite/dropbearports.txt && cat /etc/adm-lite/dropbearports.txt`;
service sshd restart 1> /dev/null 2> /dev/null
echo -e "\033[1;31m � DROPBEAR SE EJECUTA EN PUERTO\033[0m" $dropbearports " ESCOJIDO " $puertodropbear
service dropbear start 1> /dev/null 2> /dev/null
fun_eth
echo -e "\033[1;33m � INSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
return 0
 } || {
ban_inex
return 1
}
}


function installdropbear(){
clear
dropbearuniversal
return 0
}

[[ $1 != "" ]] && id="$1" || id="es"
barra="\033[1;34m =================================== \033[1;37m"
_cores="./cores"
_dr="./idioma"
#[[ "$(echo ${txt[0]})" = "" ]] && source <(curl -sSL https://www.dropbox.com/s/qolmro09l5v27ix/idioma_geral)

#LISTA PORTAS
mportas () {
unset portas
portas_var=$(lsof -V -i tcp -P -n | grep -v "ESTABLISHED" |grep -v "COMMAND" | grep "LISTEN")
while read port; do
var1=$(echo $port | awk '{print $1}') && var2=$(echo $port | awk '{print $9}' | awk -F ":" '{print $2}')
[[ "$(echo -e $portas|grep "$var1 $var2")" ]] || portas+="$var1 $var2\n"
done <<< "$portas_var"
i=1
echo -e "$portas"
}

#MEU IP
fun_ip () {
[[ -e /etc/catIPlocal && -e /etc/catIP ]] && {
MEU_IP=$(cat < /etc/catIPlocal)
MEU_IP2=$(cat < /etc/catIP)
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP"
} || {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1) && echo $MEU_IP > /etc/catIPlocal
MEU_IP2=$(wget -qO- ipv4.icanhazip.com) && echo $MEU_IP2 > /etc/catIP
[[ "$MEU_IP" != "$MEU_IP2" ]] && IP="$MEU_IP2" || IP="$MEU_IP" 
}
}
meu_ip () {
fun_ip
}


#ETHOOL SSH
fun_eth () {
eth=$(ifconfig | grep -v inet6 | grep -v lo | grep -v 127.0.0.1 | grep "encap:Ethernet" | awk '{print $1}')
    [[ $eth != "" ]] && {
    echo -e "$barra"
    echo -e "${cor[3]}  Aplicar Sistema Para Mejorar Sistema SSH?"
    echo -e "${cor[3]}  Opcion Para Usuarios Avanzados"
    echo -e "$barra"
    read -p " [S/N]: " -e -i n sshsn
           [[ "$sshsn" = @(s|S|y|Y) ]] && {
           echo -e "${cor[1]}  Correcion de problemas de paquetes en SSH..."
           echo -e "  Quota en Entrada"
           echo -ne "[ 1 - 999999999 ]: "; read rx
           [[ "$rx" = "" ]] && rx="999999999"
           echo -e "  Quota en Salida"
           echo -ne "[ 1 - 999999999 ]: "; read tx
           [[ "$tx" = "" ]] && tx="999999999"
           apt-get install ethtool -y > /dev/null 2>&1
           ethtool -G $eth rx $rx tx $tx > /dev/null 2>&1
           }
     echo -e "$barra"
     }
}

#FUN_BAR
fun_bar () {
#==comando a ejecutar==
comando="$1"
#==interfas==
in=' ['
en=' ] '
full_in=""
full_en='100%'
bar=(













































);
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


squid_cache () {
msg -bar
echo -e "${cor[5]} ${txt[157]}\n ${txt[158]}\n ${txt[159]}\n ${txt[160]}\n ${txt[161]}"
msg -bar
sleep 0.5s
if [ -e /etc/squid/squid.conf ]; then
squid_var="/etc/squid/squid.conf"
elif [ -e /etc/squid3/squid.conf ]; then
squid_var="/etc/squid3/squid.conf"
else
echo -e "${cor[5]} ${txt[162]}"
return 1
fi
teste_cache="#CACHE DO SQUID"
if [[ `grep -c "^$teste_cache" $squid_var` -gt 0 ]]; then
  [[ -e ${squid_var}.bakk ]] && {
  echo -e "${cor[5]} ${txt[167]}\n ${txt[168]}"
  mv -f ${squid_var}.bakk $squid_var
  echo -e "${cor[5]} ${txt[165]}"
  msg -bar
  service squid restart > /dev/null 2>&1
  service squid3 restart > /dev/null 2>&1
  return 0
  }
fi
echo -e "${cor[5]} ${txt[163]}\n ${cor[5]} ${txt[164]}\n ${txt[166]}"
msg -bar
_tmp="#CACHE DO SQUID\ncache_mem 200 MB\nmaximum_object_size_in_memory 32 KB\nmaximum_object_size 1024 MB\nminimum_object_size 0 KB\ncache_swap_low 90\ncache_swap_high 95"
[[ "$squid_var" = "/etc/squid/squid.conf" ]] && _tmp+="\ncache_dir ufs /var/spool/squid 100 16 256\naccess_log /var/log/squid/access.log squid" || _tmp+="\ncache_dir ufs /var/spool/squid3 100 16 256\naccess_log /var/log/squid3/access.log squid"
while read s_squid; do
[[ "$s_squid" != "cache deny all" ]] && _tmp+="\n${s_squid}"
done < $squid_var
cp ${squid_var} ${squid_var}.bakk
echo -e "${_tmp}" > $squid_var
echo -e "${cor[5]} ${txt[165]}\n ${txt[168]}"
msg -bar
service squid restart > /dev/null 2>&1
service squid3 restart > /dev/null 2>&1
}

add_host_squid () {
payload="/etc/payloads"
if [ ! -f "$payload" ]; then
echo -e "${cor[5]} $payload ${txt[213]}"
echo -e "${cor[5]} ${txt[214]}"
return
fi
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
echo -e "${cor[2]} |1| >${cor[3]} ${txt[215]}"
echo -e "${cor[2]} |2| >${cor[3]} ${txt[216]}"
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
read -p " | 1 - 2 |: " var_pay
number_var $var_pay
if [ "$var_number" = "" ]; then
echo -e "\033[1;31m ${txt[217]}"
return
 else
var_payload="$var_number"
fi
if [ "$var_payload" -gt "2" ]; then
echo -e "\033[1;31m ${txt[217]}"
return
fi
if [ "$var_payload" = "1" ]; then
echo -e "${cor[4]} A�adir Host a Squid"
echo -e "${cor[5]} Dominios actuales en el archivo $payload:"
msg -bar 
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
msg -bar 
echo "Escriba el Host-Squid que desea agregar "
read -p "Iniciando con un ., ejemplo: .whatsapp.net: " hos
if [[ $hos != \.* ]]; then
echo -e "${cor[5]} Iniciando con un ., ejemplo: .whatsapp.net: "
return
fi
host="$hos/"
if [[ -z $host ]]; then
echo -e "${cor[5]} �Esta vac�o, no ha escrito nada!"
return
fi
if [[ `grep -c "^$host" $payload` -eq 1 ]]; then
echo -e "${cor[5]} El dominio ya existe en el archivo"
return
fi
echo "$host" >> $payload && grep -v "^$" $payload > /tmp/a && mv /tmp/a $payload
echo -e "${cor[5]} ${txt[223]}"
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
 if [ ! -f "/etc/init.d/squid" ]; then
service squid3 reload
service squid3 restart
 else
/etc/init.d/squid reload
service squid restart
 fi	
return
fi

if [ "$var_payload" = "2" ]; then
echo -e "${cor[4]} ${txt[216]}"
echo -e "${cor[5]} ${txt[218]} $payload:"
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
read -p " ${txt[224]} ${txt[220]}: " hos
if [[ $hos != \.* ]]; then
echo -e "${cor[5]} ${txt[220]}"
return
fi
host="$hos/"
if [[ -z $host ]]; then
echo -e "${cor[5]} ${txt[221]}"
return
fi
if [[ `grep -c "^$host" $payload` -ne 1 ]]; then
echo -e "${cor[5]} ${txt[225]}"
return
fi
grep -v "^$host" $payload > /tmp/a && mv /tmp/a $payload
echo -e "${cor[5]} ${txt[223]}"
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
cat $payload | awk -F "/" '{print $1,$2,$3,$4}'
msg -bar #echo -e "${cor[1]} ====================================================== ${cor[0]}"
 if [ ! -f "/etc/init.d/squid" ]; then
service squid3 reload
service squid3 restart
 else
/etc/init.d/squid reload
service squid restart
 fi	
return
fi
}



#INSTALADOR SQUID
fun_squid  () {
  if [[ -e /etc/squid/squid.conf ]]; then
  var_squid="/etc/squid/squid.conf"
  elif [[ -e /etc/squid3/squid.conf ]]; then
  var_squid="/etc/squid3/squid.conf"
  fi
  [[ -e $var_squid ]] && {
echo -e " MENU DE FUNCION SQUID "
msg -bar
echo -e " \033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m  ${cor[3]} SQUID CACHE $_cachesquid"
echo -e " \033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m  ${cor[3]} AGREGAR / REMOVER HOST-SQUID"
echo -e " \033[0;35m [\033[0;36m3\033[0;35m]\033[0;31m  ${cor[3]} DESINSTALAR SQUID"
msg -bar
echo -e " \033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m  $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
msg -bar
  selection=$(selection_fun 3)
case ${selection} in
0)
return 0
;;
1)
squid_cache
return 0
;;
2)
add_host_squid
return 0
;;
3)
msg -bar
  echo -e "\033[1;32m  REMOVIENDO SQUID\n$barra"
  fun_bar "apt-get purge squid -y"
  fun_bar "apt-get purge squid3 -y"
  service squid stop > /dev/null 2>&1
  service squid3 stop > /dev/null 2>&1
  echo -e "$barra\n\033[1;32m  Procedimento Concluido\n$barra"
  [[ -e $var_squid ]] && rm $var_squid
  return 0
;;
esac
  }
  #Reiniciando
  service squid3 restart > /dev/null 2>&1
  service squid restart > /dev/null 2>&1
#Instalar
echo -e "$barra\n\033[1;32m  INSTALADOR SQUID ChumoGH-Script\n$barra"
fun_ip
echo -ne "  Confirme seu ip"; read -p ": " -e -i $IP ip
echo -e "$barra\n  Ahora Escoja su Puerto que Desea en Squid"
echo -e "  Escoja su Puerto, Ejemplo: 80 8080 3128"
echo -ne "  Digite sus Puertas: "; read portasx
echo -e "$barra"
totalporta=($portasx)
unset PORT
   for((i=0; i<${#totalporta[@]}; i++)); do
        [[ $(mportas|grep "${totalporta[$i]}") = "" ]] && {
        echo -e "\033[1;33m  Puertos Escojidos :\033[1;32m ${totalporta[$i]} OK"
        PORT+="${totalporta[$i]}\n"
        } || {
        echo -e "\033[1;33m  Puertos Escojidos :\033[1;31m ${totalporta[$i]} FAIL"
        }
   done
  [[ "$(echo -e $PORT)" = "" ]] && {
  echo -e "\033[1;31m  No se ha elegido ning�n puerto v�lido\033[0m"
  return 1
  }
echo -e "$barra"
echo -e " INSTALANDO SQUID"
echo -e "$barra" 
fun_bar "apt-get install squid3 -y"
echo -e "$barra"
echo -e " INICIANDO CONFIGURACAO"
echo -e "$barra"
echo -e "" > /etc/payloads
#Aadir Host Squid
payload="/etc/payloads"
echo -e "" > /etc/payloads
echo -e " ${txt[219]}"
echo -e " ${txt[220]}" 
read -p " Agregar Host " hos
if [[ $hos != \.* ]]; then
echo -e "$barra"
echo -e "\033[1;31m [!] Host-Squid debe iniciar con un "."\033[0m"
echo -e "\033[1;31m  Asegurese de agregarlo despues corretamente!\033[0m"
fi
host="$hos/"
if [[ -z $host ]]; then
echo -e "$barra"
echo -e "\033[1;31m [!] Host-Squid no agregado"
echo -e "\033[1;31m  Asegurese de agregarlo despues!\033[0m"
fi
echo "$host" >> $payload && grep -v "^$" $payload > /tmp/a && mv /tmp/a $payload
echo -e "$barra\n\033[1;32m Agora Escolha Uma Conf Para Seu Proxy\n$barra"
echo -e " |1| Comum"
echo -e " |2| Customizado -\033[1;31m Usuario Deve Ajustar\033[1;37m\n$barra"
read -p " [1/2]: " -e -i 1 proxy_opt
unset var_squid
if [[ -d /etc/squid ]]; then
var_squid="/etc/squid/squid.conf"
elif [[ -d /etc/squid3 ]]; then
var_squid="/etc/squid3/squid.conf"
fi
if [[ "$proxy_opt" = @(02|2) ]]; then
echo -e "#ConfiguracaoSquiD
acl url1 dstdomain -i $ip
acl url2 dstdomain -i 127.0.0.1
acl url3 url_regex -i '/etc/payloads'
acl url4 dstdomain -i localhost
acl accept dstdomain -i GET
acl accept dstdomain -i POST
acl accept dstdomain -i OPTIONS
acl accept dstdomain -i CONNECT
acl accept dstdomain -i PUT
acl HEAD dstdomain -i HEAD
acl accept dstdomain -i TRACE
acl accept dstdomain -i OPTIONS
acl accept dstdomain -i PATCH
acl accept dstdomain -i PROPATCH
acl accept dstdomain -i DELETE
acl accept dstdomain -i REQUEST
acl accept dstdomain -i METHOD
acl accept dstdomain -i NETDATA
acl accept dstdomain -i MOVE
acl all src 0.0.0.0/0
http_access allow url1
http_access allow url2
http_access allow url3
http_access allow url4
http_access allow accept
http_access allow HEAD
http_access deny all

# Request Headers Forcing

request_header_access Allow allow all
request_header_access Authorization allow all
request_header_access WWW-Authenticate allow all
request_header_access Proxy-Authorization allow all
request_header_access Proxy-Authenticate allow all
request_header_access Cache-Control allow all
request_header_access Content-Encoding allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Expires allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Last-Modified allow all
request_header_access Location allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Content-Language allow all
request_header_access Mime-Version allow all
request_header_access Retry-After allow all
request_header_access Title allow all
request_header_access Connection allow all
request_header_access Proxy-Connection allow all
request_header_access User-Agent allow all
request_header_access Cookie allow all
request_header_access All deny all

# Response Headers Spoofing

reply_header_access Via deny all
reply_header_access X-Cache deny all
reply_header_access X-Cache-Lookup deny all


#portas" > $var_squid
for pts in $(echo -e $PORT); do
echo -e "http_port $pts" >> $var_squid
done
echo -e "
#nome
visible_hostname ChumoGH-ADM

via off
forwarded_for off
pipeline_prefetch off" >> $var_squid
 else
echo -e "#ConfiguracaoSquiD
acl url1 dstdomain -i $ip
acl url2 dstdomain -i 127.0.0.1
acl url3 url_regex -i '/etc/payloads'
acl url4 dstdomain -i localhost
acl all src 0.0.0.0/0
http_access allow url1
http_access allow url2
http_access allow url3
http_access allow url4
http_access deny all

#portas" > $var_squid
for pts in $(echo -e $PORT); do
echo -e "http_port $pts" >> $var_squid
done
echo -e "
#nome
visible_hostname ChumoGH-ADM

via off
forwarded_for off
pipeline_prefetch off" >> $var_squid
fi
fun_eth
echo -e "$barra\n \033[1;31m [ ! ] \033[1;33m REINICIANDO SERVICIOS"
squid3 -k reconfigure > /dev/null 2>&1
squid -k reconfigure > /dev/null 2>&1
service ssh restart > /dev/null 2>&1
service squid3 restart > /dev/null 2>&1
service squid restart > /dev/null 2>&1
echo -e " \033[1;32m[OK]"
echo -e "$barra\n ${cor[3]}$(source trans -b pt:${id} "SQUID CONFIGURADO EXITOSAMENTE")\n$barra"
mportas > /tmp/portz
while read portas; do
[[ $portas = "" ]] && break
done < /tmp/portz
#UFW
for ufww in $(mportas|awk '{print $2}'); do
ufw allow $ufww > /dev/null 2>&1
done
}
#INSTALAR DROPBEAR

addnewd (){
unset yesno
unset dnew
echo -e "\033[1;32mDeseas Adicionar alguno mas?? " 
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
foc=$(($foc + 1))
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
echo -e "\033[1;34mIngresa Nuevo Puerto a Escuchar:"
read -p ": " dnew
	if lsof -Pi :$dnew -sTCP:LISTEN -t >/dev/null ; then
	echo -e "\033[1;37mPuerto Seleccionado Ocupado | Reintenta"
	else
	dvj=$(cat < /etc/default/dadd)
	sed -i "s/$dvj/$dnew -p $dvj/g" /etc/default/dropbear
	echo "Reiniciando Dropbear para ejecutar cambios"
	echo "Numero de Intento : $foc"
	service dropbear restart
	dropbearports=`netstat -tunlp | grep dropbear | grep 0.0.0.0: | awk '{print substr($4,9); }' > /tmp/dropbear.txt && echo | cat /tmp/dropbear.txt | tr '\n' ' ' > /etc/adm-lite/dropbearports.txt && cat /etc/adm-lite/dropbearports.txt`;
	echo "Puertos que Corren en DROPBEAR " $dropbearports 
	fi
#echo -e "\033[1;32mDeseas Adicionar alguno mas?? " 
echo "EXITO AL A�ADIR PUERTO"
sleep 0.5s
addnewd
else
unset foc
cd /etc/adm-lite && ./menu_inst
fi
}
fun_dropbear () {
dropbearports=`netstat -tunlp | grep dropbear | grep 0.0.0.0: | awk '{print substr($4,9); }' > /tmp/dropbear.txt && echo | cat /tmp/dropbear.txt | tr '\n' ' ' > /etc/adm-lite/dropbearports.txt && cat /etc/adm-lite/dropbearports.txt`;
# INICIO STUNNEL ACTIVO
cowsay -f stegosaurus "BIENVENIDO Y GRACIAS POR UTILIZAR    CHUMOGH  ADM SCRIPT "
echo -e "${cor[1]}=========================="  
echo -e "${cor[2]}DROPBEAR ACTIVO en Puertos: $dropbearports \n${cor[1]}==========================\n${cor[2]}[1]- Instalar DROPBEAR \n[2]- Cerrar Puerto (s)\n[3]- Adicionar Port DROPBEAR "  
echo -e "${cor[1]}=========================="  
echo -ne " ESCOJE: "; read lang
case $lang in
1)
clear
########LLAMAMOS FUNCION DROPBEAR#######
service dropbear stop 1> /dev/null 2> /dev/null
service sshd restart > /dev/null 2>&1
service ssh restart > /dev/null 2>&1
installdropbear
echo -e "$barra\n${cor[3]}  Dropbear Configurado Exitosamente\n$barra"
;;
2)
 [[ -e /etc/default/dropbear ]] && {
 echo -e "$barra\n\033[1;32m  REMOVIENDO DROPBEAR\n$barra"
service dropbear stop 1> /dev/null 2> /dev/null
service sshd restart > /dev/null 2>&1
service ssh restart > /dev/null 2>&1 
 fun_bar "apt-get remove dropbear -y"
killall dropbear 1> /dev/null 2> /dev/null
apt-get -y purge dropbear 1> /dev/null 2> /dev/null
apt-get -y remove dropbear 1> /dev/null 2> /dev/null
#|[[ -e /bin/ejecutar/sshd_config ]] && mv /bin/ejecutar/sshd_config /etc/ssh/sshd_config 
 echo -e "$barra\n\033[1;32m  Dropbear Removido\n$barra"
 [[ -e /etc/default/dropbear ]] && rm /etc/default/dropbear
 user -k $dpa/tcp > /dev/null 2>&1
 return
 }
;;
3)
[[ -e /etc/default/dropbear ]] && {
dropbearports=`netstat -tunlp | grep dropbear | grep 0.0.0.0: | awk '{print substr($4,9); }' > /tmp/dropbear.txt && echo | cat /tmp/dropbear.txt | tr '\n' ' ' > /etc/adm-lite/dropbearports.txt && cat /etc/adm-lite/dropbearports.txt`;
echo "Puertos que Corren en DROPBEAR " $dropbearports 
cp /etc/default/dropbear /etc/default/dropbear.or
echo "Ingresa Nuevo Puerto Escuchar:"
read -p ": " portdrop
dnew="$portdrop"
fun_bar
if lsof -Pi :$portdrop -sTCP:LISTEN -t >/dev/null ; then
echo "Puerto Seleccionado Ocupado | Reintenta"
else
 #sed -i "2d" /etc/default/dropbear
dvj=$(cat < /etc/default/dadd)
sed -i "s/$dvj/$dnew -p $dvj/g" /etc/default/dropbear
#sed -i '2i DROPBEAR_EXTRA_ARGS="-p '"$portdrop"'"' /etc/default/dropbear
echo $portdrop > /etc/default/dadd
echo "Reiniciando Dropbear para ejecutar cambios"
fun_bar
service dropbear restart
dropbearports=`netstat -tunlp | grep dropbear | grep 0.0.0.0: | awk '{print substr($4,9); }' > /tmp/dropbear.txt && echo | cat /tmp/dropbear.txt | tr '\n' ' ' > /etc/adm-lite/dropbearports.txt && cat /etc/adm-lite/dropbearports.txt`;
echo "Puertos que Corren en DROPBEAR " $dropbearports 
foc=1
addnewd
cd /etc/adm-lite && ./menu_inst
fi
 return 0
 }
echo "Desgraciado, No HAS INSTALADO EL SERVICIO AUN ;C"
 return 0
;;
*)
adm
;;
esac
}





fun_shadowsocks () {
wget -q https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/shadowsocks.sh
figlet ChumoGH
bash shadowsocks.sh
rm shadowsocks.sh
}


instala_clash () {
	while :
	do
		clear
		figlet -p -f slant < /root/name | lolcat
echo -e "\033[1;37m            Reseller :$(cat < /etc/adm-lite/menu_credito) - ADM 2021       \033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m #######################################\033[1;33m"
echo -e "\033[1;37mSeleccione una opcion :    Para Salir Ctrl + C\033[1;33m"
echo -e "${cor[3]} Esta herramienta Permite escojer el menu Clash Nuevo y Antiguo"
echo -e "${cor[3]}     Si manejas los Menu de Trojan Y v2ray, Usa 1"
echo -e $barra
echo -e " \033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m  Menu Clash - Menu New Reforma Ususarios Creados"
echo -e " \033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m  Menu Clash - Menu Antiguo (Ingreso Manual)"
msg -bar
echo -e " \033[0;35m [\033[0;36m0\033[0;35m]\033[0;31m  $(msg -bra "\033[1;41m[ REGRESAR ]\e[0m")"
echo -e $barra
		read -p "Escoje : " opcion
		case $opcion in
			1)
			source <(curl -sSL https://www.dropbox.com/s/uz3s8keszpdwx0y/clash-beta.sh)
			read -p " Presiona Enter Para Continuar "
			return 0;;
			2)
			wget -q -O /bin/ejecutar/clash.sh https://www.dropbox.com/s/tyuz3ms5zv73pyy/clash.sh
			chmod +x /bin/ejecutar/clash.sh
			bash /bin/ejecutar/clash.sh
			[[ -e /bin/ejecutar/clash.sh ]] && rm /bin/ejecutar/clash.sh
			return 0
			;;
			0) break
			return 0
			;;
			*) echo -e "\n selecione una opcion del 0 al 2" && sleep 1;;
		esac
	done
#source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/Clash/clash.sh)
#bash -c "$(curl -fsSL https://raw.githubusercontent.com/JeannieStudio/all_install/master/SixForOne_install.sh)"
}




web_min () {
 [[ -e /etc/webmin/miniserv.conf ]] && {
 echo -e "$barra\n\033[1;32m  REMOVENDO WEBMIN\n$barra"
 fun_bar "apt-get remove webmin -y"
 echo -e "$barra\n\033[1;32m  Webmin Removido\n$barra"
 [[ -e /etc/webmin/miniserv.conf ]] && rm /etc/webmin/miniserv.conf
 return 0
 }
echo -e " \033[1;36mInstalling Webmin, aguarde:"
fun_bar "wget https://sourceforge.net/projects/webadmin/files/webmin/1.881/webmin_1.881_all.deb"
fun_bar "dpkg --install webmin_1.881_all.deb"
fun_bar "apt-get -y -f install"
rm /root/webmin_1.881_all.deb > /dev/null 2>&1
service webmin restart > /dev/null 2>&1 
echo -e "${barra}\n  Accede via web usando el enlace: https;//$(wget -qO- ifconfig.me):10000\n${barra}"
echo -e " Procedimento Concluido\n${barra}"
return 0
}


iniciarsocks () {
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/sockspy.sh)
}

ssrmenu() 
{
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/back/ssrrmu.sh)
#source <(curl -sL https://github.com/VPS-MX/VPS-MX-8.0/raw/master/SCRIPT/C-SSR.sh)
#sed '/gnula.sh/ d' /etc/crontab > /bin/ejecutar/crontab
}

trojan() 
{

[[ $(mportas|grep trojan|head -1) ]] && {
# INICIO STUNNEL ACTIVO
msg -bar 
echo -e "${cor[2]} Trojan-Go ACTIVO en Puertos: $trojanports "
msg -bar
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m Adicionar Usuario ( Menu TROJAN )  \033[0;32m(#OFICIAL by @ChumoGH)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m Cerrar Puerto (s)" 
msg -bar   
echo -ne " ESCOJE: "; read lang
case $lang in
1)
source <(curl -sSL https://www.dropbox.com/s/0g49zme77giypns/mod-v2ray.sh);;
2)
source <(curl -sL https://git.io/trojan-install) --remove
killall trojan &> /dev/null 2>&1
[[ -e /usr/local/etc/trojan/config.json ]] && rm -f /usr/local/etc/trojan /usr/local/etc/trojan/config.json
[[ -e /bin/troj.sh ]] && rm -f /bin/troj.sh
clear
echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
echo -e "\033[1;31mINSTALACION FINALIZADA - PRESIONE ENTER\033[0m"
read -p " "
;;
0)
return 0
;;
esac
#FIN VERIFICA STUNNEL4 ACTIVO 
} || {
wget -q https://www.dropbox.com/s/vogt0tyaqg0gee1/trojango.sh; chmod +x trojango.sh; ./trojango.sh
rm -f trojango.sh
return 0
}

}
###
#[[ -e /usr/local/etc/trojan/config.json ]] && {
#source <(curl -sL https://git.io/trojan-install) --remove
#echo -e "\033[1;37m  Desinstalacion Completa \033[0m"
#echo -e "\033[1;31m PRESIONE ENTER\033[0m"
#read -p " "
#} || { 
#source <(curl -sL https://git.io/trojan-install)
#}
#source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/Clash/trojan)
#source <(curl -sL https://github.com/VPS-MX/VPS-MX-8.0/raw/master/SCRIPT/C-SSR.sh)
#sed '/gnula.sh/ d' /etc/crontab > /bin/ejecutar/crontab
##



ssl_stunel () {
unset lang
sslkk
[[ $(mportas|grep stunnel4|head -1) ]] && {
# INICIO STUNNEL ACTIVO
msg -bar 
echo -e "${cor[2]}STUNNEL ACTIVO en Puertos: $sslports "
msg -bar
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m Adicionar Puerto  \033[0;32m(#OFICIAL)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m Cerrar Puerto (s)" 
msg -bar  
echo -ne " ESCOJE: "; read lang
case $lang in
1)
#clear
###
source cabecalho
#echo -e "Escriba un nombre para el Redireccionador SSL"
#read -p ": " nombressl

pt=$(netstat -nplt |grep 'sshd' | awk -F ":" NR==1{'print $2'} | cut -d " " -f 1)
echo -e "\033[1;33m  Selecione un Puerto De Redirecionamento Interna (Default 22) "
msg -bar
         while true; do
         echo -ne "\033[1;37m"
	    echo " Ingresa el Puerto Local de tu VPS (Default 22) "
        read -p " Local-Port: " -e -i $pt portserv
        if [[ ! -z $portserv ]]; then
	 	 if lsof -Pi :$portserv -sTCP:LISTEN -t >/dev/null ; then
		 break
		 else
		 portserv="22"
		 break
		 fi
	 fi
         done
#echo -e "\033[1;33m  Digite el Puerto SSL, que Va a USAR "
#echo -e "\033[1;33m  Digite el Puerto SSL, que Va a USAR "

    while true; do
    echo -e " Ingresa el Nuevo Puerto SSl/TLS \n A Usar en tu VPS (Recomendado 110 442 444)"
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
	PortSSL=`netstat -tlpn | awk -F '[: ]+' '$1=="tcp"{print $5}' | grep -w $SSLPORT`
	[[ -n "$PortSSL" ]] || break
    prococup=`netstat -tlpn | awk -F '[: ]+' '$5=="$SSLPORT"{print $9}'`
    echo -e "\033[1;33m  EL PUERTO SE ENCUENTRA OCUPADO POR $prococup"
	echo -e "$barra"
	return
    done

echo "[stunnel] " >> /etc/stunnel/stunnel.conf
echo "cert = /etc/stunnel/stunnel.pem " >> /etc/stunnel/stunnel.conf
echo "accept = $SSLPORT " >> /etc/stunnel/stunnel.conf
echo "connect = 127.0.0.1:$portserv" >> /etc/stunnel/stunnel.conf
echo -e "\033[1;34m ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL4 - SSL"
echo -e "\033[1;34m ##############################"
service ssh restart 1>/dev/null 2 /dev/null
service stunnel4 start 1>/dev/null 2 /dev/null
service stunnel4 restart 1>/dev/null 2 /dev/null
sslkk
echo -e "${cor[2]}STUNNEL ACTIVO en Puertos : ${cor[2]}$sslports "
#echo "Limpiando sistema y Reiniciando Servicios"
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
#echo "Limpieza Finalizada"
unset lang
return 0
;;
2)
unset lang
service stunnel4 stop
echo -e "$barra"
echo -e "\033[1;33m  Cerrando PUERTO SSL/TLS"
echo -e "$barra"
fun_bar 'apt-get remove stunnel4 -y' 'apt-get purge stunnel4 -y'
echo -e "$barra"
#echo "Limpiando sistema y Reiniciando Servicios"
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
#echo "Limpieza Finalizada"
rm -rf /etc/stunnel/* > /dev/null
echo -e "\033[1;33m  PUERTO SSL/TLS CERRADO!"
echo -e "$barra"
cd /etc/adm-lite && ./menu_inst
;;
esac
#FIN VERIFICA STUNNEL4 ACTIVO 
}
unset lang
figlet " SSL / TLS " | boxes -d stone -p a2v1
msg -bar 
echo -e "${cor[2]} Certificado SSL/TLS ( Default: @ChumoGH ) " 
msg -bar
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m\033[0;33m Crear Su Certificado SSL  \033[0;32m(#OFICIAL)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m\033[0;33m Certificado AUTOMATICO    \033[0;32m(#OFICIAL)"
echo -e " \033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m\033[0;31m Cargar Certificado WEB    \033[0;33m(#EXPERIMENTAL)"
echo -e " \033[0;35m[\033[0;36m4\033[0;35m] \033[0;34m\033[0;33m Certificado con DOMINIO   \033[0;32m(#EXPERIMENTAL)"
msg -bar 
echo -e " \033[0;35m[\033[0;36m5\033[0;35m] \033[0;34m<\033[0;31m SSL Cert - BY @KillShito    \033[0;33m(#EXPERIMENTAL)"
msg -bar 
echo -ne " ESCOJE: "; read lang
case $lang in
1)
msg -bar
echo -e "  Para Crear su Certificado SSL \n En su Primera instancia coloque Codigo de su PAIS \n				 Ejemplo : EC  "
msg -bar
echo -e  "  A continuacion los codigos de Validacion de su Certificado"
read -p " Presiona Enter para continuar la Instalacion"
source <(curl -sL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/ssl)
return 0
;;
2)
#sshports=`netstat -tunlp | grep sshd | grep 0.0.0.0: | awk '{print substr($4,9); }' > /tmp/ssh.txt && echo | cat /tmp/ssh.txt | tr '\n' ' ' > /etc/adm-lite/sshports.txt && cat /etc/adm-lite/sshports.txt`;
#sshports=$(cat /etc/adm-lite/sshports.txt  | sed 's/\s\+/,/g' | cut -d , -f1)
echo -e "$barra"
echo -e "\033[1;36m  SSL Stunnel"
echo -e "$barra"
echo -e "\033[1;33m  Selecione un Puerto De Redirecionamento Interna"
echo -e "\033[1;33m  Ingrese su Puerta Servidor Para o SSL/TLS"
echo -e "$barra"
pt=$(netstat -nplt |grep 'sshd' | awk -F ":" NR==1{'print $2'} | cut -d " " -f 1)
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa el Puerto Local de tu VPS (Default 22) "
    read -p "  Local-Port: " -e -i $pt portx
	tput cuu1 >&2 && tput dl1 >&2
    [[ $(mportas | grep $portx) ]] && break
    echo -e "\033[1;33m  El puerto seleccionado no existe"
    unset portx
	echo -e "$barra"
    done
echo -e "$barra"
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
echo -e "\033[1;33m  Digite el Puerto SSL, que Va a USAR:"
echo -e "$barra"
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa Puerto SSl/TLS a USAR (Recomendado 110-442-444)  "
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
    [[ $(mportas | grep $SSLPORT) ]] || break
    echo -e "\033[1;33m  El puerto seleccionado ya se encuentra en uso"
    unset SSLPORT
	echo -e "$barra"
    done
echo -e "$barra"
echo -e "\033[1;33m  Instalando SSL/TLS [ $DPORT -> $SSLPORT ] : $(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')"
echo -e "$barra"
fun_bar "apt install stunnel4 -y"
echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[stunnel]\nconnect = 127.0.0.1:${DPORT}\naccept = ${SSLPORT}" > /etc/stunnel/stunnel.conf
openssl genrsa -out key.pem 2048 > /dev/null 2>&1
(echo "$(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')" ; echo "" ; echo "$(wget -qO- ifconfig.me):81" ; echo "" ; echo "" ; echo "" ; echo "@ChumoGH")|openssl req -new -x509 -key key.pem -out cert.pem -days 1095 > /dev/null 2>&1
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart > /dev/null 2>&1
echo -e "$barra"
#echo "Limpiando sistema y Reiniciando Servicios"
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
service ssh restart 1> /dev/null 2> /dev/null
echo -e "\033[1;34m ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL4 - SSL"
echo -e "\033[1;34m ##############################"
echo -e "\033[1;33m  INSTALACION EXITOSA"
echo -e "$barra"
return 0
;;
3)
car_cert () {
[[ -e /etc/stunnel/stunnel.pem ]] && echo -e "Ya Existe un certificado SSL Cargado \n  Recuerde Cargar SU Certificado y Key del SSL " | pv -qL 25
msg -bar
echo -e "Descarga el fichero URL del Certificado SSL " 
echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mPara este Paso debes tener el URL del certificado Online"
		echo -e "            Si Aun no lo has hecho, Cancela este paso"
		echo -e "               Evitar Errores Futuros"
		echo -e "   y causar problemas en futuras instalaciones.\033[0m"
		echo -e $barra
msg -bar
echo -e "Ingrese Link del Fichero URL de tu ZIP con los Certificados "
msg -bar
read -p " Pega tu Link : " urlm
wget -O certificados.zip $urlm && echo -e "Descargando Fichero ZIP " || echo "Link de descarga Invalido"
msg -bar
echo -ne "\033[1;42m ZIPS Existentes : " && ls | grep zip && echo -e "\033[1;42m"
msg -bar 
unzip certificados.zip 1> /dev/null 2> /dev/null && echo -e "Descomprimiendo Ficheros descargados" || echo -e "Error al Descomprimir "
[[ -e private.key ]] && cat private.key > /etc/stunnel/stunnel.pem && echo -e " \033[1;42m Key del Certificado cargada Exitodamente\033[0m" || echo -e " \033[1;41mClaves Invalidas\033[0m"
[[ -e certificate.crt && -e ca_bundle.crt ]] && cat certificate.crt ca_bundle.crt >> /etc/stunnel/stunnel.pem && echo -e "\033[1;42m  CRT del Certificado cargada Exitodamente\033[0m" || echo -e "\033[1;41mClaves Invalidas\033[0m"
rm -f private.key certificate.crt ca_bundle.crt certificados.zip 1> /dev/null 2> /dev/null && cd $HOME
}
echo -e "$barra"
echo -e "\033[1;36m  SSL Stunnel"
echo -e "$barra"
echo -e "\033[1;33m  Selecione un Puerto De Redirecionamento Interna"
echo -e "\033[1;33m  Ingrese su Puerta Servidor Para o SSL/TLS"
echo -e "$barra"
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa el Puerto Local de tu VPS (Default 22) "
    read -p " Local-Port: " -e -i "22" portx
    [[ $(mportas | grep $portx) ]] && break
    echo -e "\033[1;33m  El puerto seleccionado no existe"
    unset portx
	echo -e "$barra"
	return 
    done
echo -e "$barra"
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
echo -e "\033[1;33m  Digite el Puerto SSL, que Va a USAR:"
echo -e "$barra"
    while true; do
    unset SSLPORT
	echo -ne "\033[1;37m"
    echo "  Ingresa Puerto SSl/TLS a USAR (Recomendado 110-442-444)  "
    read -p " Listen-SSL: " SSLPORT
    [[ $(mportas|grep $SSLPORT) ]] || break
    echo -e "\033[1;33m  El puerto seleccionado ya se encuentra en uso"
    
	echo -e "$barra"
	return 0
    done
echo -e "$barra"
echo -e "\033[1;33m  Instalando SSL/TLS [ $DPORT -> $SSLPORT ] : $(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')"
echo -e "$barra"
fun_bar "apt install stunnel4 -y"
echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[stunnel]\nconnect = 127.0.0.1:${DPORT}\naccept = ${SSLPORT}" > /etc/stunnel/stunnel.conf
car_cert
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
service stunnel4 restart > /dev/null 2>&1
echo -e "$barra"
#echo "Limpiando sistema y Reiniciando Servicios"
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
service ssh restart 1> /dev/null 2> /dev/null
echo -e "\033[1;34m ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL4 - SSL"
echo -e "\033[1;34m ##############################"
echo -e "\033[1;33m  INSTALACION EXITOSA"
echo -e "$barra"
return 0
;;
4)
echo -e "$barra"
echo -e "\033[1;36m  SSL Stunnel"
echo -e "$barra"
echo -e "\033[1;33m  Selecione un Puerto De Redirecionamento Interna"
echo -e "\033[1;33m  Ingrese su Puerta Servidor Para o SSL/TLS"
echo -e "$barra"
pt=$(netstat -nplt |grep 'sshd' | awk -F ":" NR==1{'print $2'} | cut -d " " -f 1)
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa el Puerto Local de tu VPS (Default 22) "
    read -p "  Local-Port: " -e -i $pt portx
	tput cuu1 >&2 && tput dl1 >&2
    [[ $(mportas | grep $portx) ]] && break
    echo -e "\033[1;33m  El puerto seleccionado no existe"
    unset portx
	echo -e "$barra"
    done
echo -e "$barra"
DPORT="$(mportas|grep $portx|awk '{print $2}'|head -1)"
echo -e "\033[1;33m  Digite el Puerto SSL, que Va a USAR:"
echo -e "$barra"
    while true; do
    echo -ne "\033[1;37m"
    echo "  Ingresa Puerto SSl/TLS a USAR (Recomendado 110-442-444)  "
    read -p " Listen-SSL: " SSLPORT
	tput cuu1 >&2 && tput dl1 >&2
    [[ $(mportas | grep $SSLPORT) ]] || break
    echo -e "\033[1;33m  El puerto seleccionado ya se encuentra en uso"
    unset SSLPORT
	echo -e "$barra"
    done
echo -e "$barra"
echo -e "\033[1;33m  Instalando SSL/TLS [ $DPORT -> $SSLPORT ] : $(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')"
echo -e "$barra"
fun_bar "apt install stunnel4 -y"
source <(curl -sSL https://www.dropbox.com/s/839d3q8kh72ujr0/certificadossl.sh)
echo -e "cert = /etc/stunnel/stunnel.pem\nclient = no\nsocket = a:SO_REUSEADDR=1\nsocket = l:TCP_NODELAY=1\nsocket = r:TCP_NODELAY=1\n\n[stunnel]\nconnect = 127.0.0.1:${DPORT}\naccept = ${SSLPORT}" > /etc/stunnel/stunnel.conf
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
[[ -e /data/cert.crt && -e /data/cert.key ]] && cat /data/cert.key /data/cert.crt >> /etc/stunnel/stunnel.pem ||  {
echo -e " ERROR AL CREAR CERTIFICADO "
apt purge stunnel4 -y > /dev/null 2>&1
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
service ssh restart 1> /dev/null 2> /dev/null
echo -e "\033[1;34m ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL4 - SSL"
echo -e "\033[1;34m ##############################"
echo -e "\033[1;33m  INSTALACION FALLIDA"
echo -e "$barra"
return 0
}
service stunnel4 restart > /dev/null 2>&1
echo -e "$barra"
#echo "Limpiando sistema y Reiniciando Servicios"
echo 3 > /proc/sys/vm/drop_caches 1> /dev/null 2> /dev/null
sysctl -w vm.drop_caches=3 1> /dev/null 2> /dev/null
swapoff -a && swapon -a 1> /dev/null 2> /dev/null
service ssh restart 1> /dev/null 2> /dev/null
echo -e "\033[1;34m ##############################"
echo -e "\033[1;37m R E I N I C I A N D O  -  STUNNEL4 - SSL"
echo -e "\033[1;34m ##############################"
echo -e "\033[1;33m  INSTALACION EXITOSA"
echo -e "$barra"
return 0
;;
5)
msg -bar
echo -e  "  ESTE MINI SCRIPT ES FUE DESARROLLADO POR @KillShito "
echo ""
echo -e  "               Creditos a @KillShito "
msg -bar
read -p " Presiona Enter para continuar "
source <(curl -sSL https://www.dropbox.com/s/ooe74y69nm89da9/front.sh)
;;
*)
menu
;;
esac
}

painel_upload () {
echo -e "$barra"
echo -e "${cor[2]}$(source trans -b pt:${id} "Deseja Instalar Painel De Upload?")"
echo -e "$barra"
read -p " [ s | n ]: " up_load
echo -e "$barra"
   [[ "$up_load" = @(s|S|y|Y) ]] && bash /etc/adm-lite/insta_painel || {
   echo -e "${cor[2]}Instalacao Abortada"
   echo -e "$barra"
   }
}

psiserver(){
echo -e "\033[1;33m Se instalar� el servidor de Psiphon\033[0m"
echo -e "\033[1;33m Si ya ten�as una instalacion Previa, esta se eliminara\033[0m"
echo -e "\033[1;33m Debes tener instalado previamente GO Lang\033[0m"
echo -e "\033[1;33m Continuar?\033[0m"
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
rm -rf /root/psi
kill $(ps aux | grep 'psiphond' | awk '{print $2}') 1> /dev/null 2> /dev/null
killall psiphond 1> /dev/null 2> /dev/null
cd /root
mkdir psi
cd psi
psi=`cat /root/psi.txt`;
ship=$(wget -qO- ipv4.icanhazip.com)
curl -o /root/psi/psiphond https://raw.githubusercontent.com/Psiphon-Labs/psiphon-tunnel-core-binaries/master/psiphond/psiphond 1> /dev/null 2> /dev/null
chmod 777 psiphond
echo -e "\033[1;33m Escribe el puerto para Psiphon SSH:\033[0m"
read -p ": " sh
echo -e "\033[1;33m Escribe el puerto para Psiphon OSSH:\033[0m"
read -p ": " osh
echo -e "\033[1;33m Escribe el puerto para Psiphon FRONTED-MEEK:\033[0m"
read -p ": " fm
echo -e "\033[1;33m Escribe el puerto para Psiphon UNFRONTED-MEEK:\033[0m"
read -p ": " umo
./psiphond --ipaddress $ship --protocol SSH:$sh --protocol OSSH:$osh --protocol FRONTED-MEEK-OSSH:$fm --protocol UNFRONTED-MEEK-OSSH:$umo generate
chmod 666 psiphond.config
chmod 666 psiphond-traffic-rules.config
chmod 666 psiphond-osl.config
chmod 666 psiphond-tactics.config
chmod 666 server-entry.dat
cat server-entry.dat >> /root/psi.txt
screen -dmS psiserver ./psiphond run
cd /root
echo -e "\033[1;33m LA CONFIGURACION DE TU SERVIDOR ES:\033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;32m $psi \033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e "\033[1;33m PROTOCOLOS HABILITADOS:\033[0m"
echo -e "\033[1;33m  SSH:\033[1;32m $sh \033[0m"
echo -e "\033[1;33m  OSSH:\033[1;32m $osh \033[0m"
echo -e "\033[1;33m  FRONTED-MEEK-OSSH:\033[1;32m $fm \033[0m"
echo -e "\033[1;33m  UNFRONTED-MEEK-OSSH:\033[1;32m $umo \033[0m"
echo -e "[\033[1;31m-\033[1;33m]\033[1;31m \033[1;33m"
echo -e " "
echo -e "\033[1;33m DIRECTORIO DE ARCHIVOS:\033[1;32m /root/psi \033[0m"
fi
}



antiddos (){
if [ -d '/usr/local/ddos' ]; then
	if [ -e '/usr/local/sbin/ddos' ]; then
		rm -f /usr/local/sbin/ddos
	fi
	if [ -d '/usr/local/ddos' ]; then
		rm -rf /usr/local/ddos
	fi
	if [ -e '/etc/cron.d/ddos.cron' ]; then
		rm -f /etc/cron.d/ddos.cron
	fi
	sleep 1s
	echo -e "$barra"
	echo -e "\033[1;31m ANTIDDOS DESINSTALADO CON EXITO\033[1;37m"
	echo -e "$barra"
	return 1
else
	mkdir /usr/local/ddos
fi
wget -q -O /usr/local/ddos/ddos.conf https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/ADM-MANAGER-MOD/master/DDOS/ddos.conf -o /dev/null
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE -o /dev/null
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list -o /dev/null
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh -o /dev/null
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
sleep 2s
echo -e "$barra"
echo -e "\033[1;32m ANTIDDOS INSTALADO CON EXITO.\033[1;37m"
echo -e "$barra"
}

v2ui() {
cd $HOME
fun_ip(){
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

last_version=$(curl -Ls "https://api.github.com/repos/vaxilu/x-ui/releases/latest" | grep 'V' | sed -E 's/.*"([^"]+)".*/\1/')
MIP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MIP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MIP" != "$MIP2" ]] && IP="$MIP2" || IP="$MIP"
}
kill -9 $(ps x|grep -v grep|grep "xray-linu"|awk '{print $1}')
kill -9 $(ps x|grep -v grep|grep "x-ui"|awk '{print $1}')
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
#bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
fun_ip
autogen() {
x-ui start  > /dev/null 2>&1
x-ui enable > /dev/null 2>&1
[[ ! -d /etc/x-ui ]] && mkdir /etc/x-ui
[[ -d /etc/x-ui ]] && cd /etc/x-ui
openssl genrsa -out key.key 2048 > /dev/null 2>&1
(echo "$(curl -sSL ipinfo.io > info && cat info | grep country | awk '{print $2}' | sed -e 's/[^a-z0-9 -]//ig')"; echo ""; echo "$(wget -qO- ifconfig.me):81"; echo ""; echo ""; echo ""; echo "@ChumoGH")|openssl req -new -x509 -key key.key -out cert.crt -days 1095 > /dev/null 2>&1
[[ -e /etc/x-ui/key.key ]] && cp /etc/x-ui/key.key /etc/x-ui/cert.key
[[ -e /etc/x-ui/cert.crt ]] && cp /etc/x-ui/cert.crt /etc/x-ui/cert.crt
cd $HOME
fun_bar
echo -e "CERTIFICADO GENERADO"
}
creargen(){
x-ui start
x-ui enable
[[ ! -d /etc/x-ui ]] && mkdir /etc/x-ui > /dev/null 2>&1
[[ -d /etc/x-ui ]] && cd /etc/x-ui > /dev/null 2>&1
openssl genrsa 2048 > key.key
openssl req -new -key key.key -x509 -days 1000 -out cert.crt
#[[ -e /etc/x-ui/key.key ]] && cp /etc/x-ui/key.key /etc/x-ui/cert.key
#[[ -e /etc/x-ui/cert.crt ]] && cp /etc/x-ui/cert.crt /etc/x-ui/cert.crt
fun_bar
echo -e "CERTIFICADO GENERADO"
}
certdom () {
[[ ! -d /etc/x-ui ]] && mkdir /etc/x-ui
[[ -d /etc/x-ui ]] && cd /etc/x-ui
source <(curl -sSL https://www.dropbox.com/s/839d3q8kh72ujr0/certificadossl.sh)
[[ -e /data/cert.crt && -e /data/cert.key ]] && {
cat /data/cert.key > /etc/x-ui/cert.key
cat /data/cert.crt > /etc/x-ui/cert.crt 
echo -e "CERTIFICADO GENERADO"
} ||  {
echo -e " ERROR AL CREAR CERTIFICADO "
}

certweb () {
[[ -e /etc/x-ui/cert.key && -e /etc/x-ui/cert.crt ]] && echo -e "Ya Existe un certificado SSL Cargado \n  Recuerde Cargar SU Certificado y Key del SSL " | pv -qL 25
msg -bar
echo -e "Descarga el fichero URL del Certificado SSL " 
echo -e $barra
		echo -e "		\033[4;31mNOTA importante\033[0m"
		echo -e " \033[0;31mPara este Paso debes tener el URL del certificado Online"
		echo -e "            Si Aun no lo has hecho, Cancela este paso"
		echo -e "               Evitar Errores Futuros"
		echo -e "   y causar problemas en futuras instalaciones.\033[0m"
		echo -e $barra
msg -bar
echo -e "Ingrese Link del Fichero URL de tu ZIP con los Certificados "
msg -bar
read -p " Pega tu Link : " urlm
wget -O certificados.zip $urlm && echo -e "Descargando Fichero ZIP " || echo "Link de descarga Invalido"
msg -bar
echo -ne "\033[1;42m ZIPS Existentes : " && ls | grep zip && echo -e "\033[1;42m"
msg -bar 
unzip certificados.zip 1> /dev/null 2> /dev/null && echo -e "Descomprimiendo Ficheros descargados" || echo -e "Error al Descomprimir "
[[ -e private.key ]] && cat private.key > /etc/x-ui/cert.key && echo -e " \033[1;42m Key del Certificado cargada Exitodamente\033[0m" || echo -e " \033[1;41mClaves Invalidas\033[0m"
[[ -e certificate.crt && -e ca_bundle.crt ]] && cat certificate.crt ca_bundle.crt > /etc/x-ui/cert.crt && echo -e "\033[1;42m  CRT del Certificado cargada Exitodamente\033[0m" || echo -e "\033[1;41mClaves Invalidas\033[0m"
rm -f private.key certificate.crt ca_bundle.crt certificados.zip 1> /dev/null 2> /dev/null && cd $HOME
}
}

act_gen () {
v2ray-cgh="/etc/x-ui"  > /dev/null 2>&1
while [[ ${varread} != @([0-5]) ]]; do
echo -e "\033[1;33mv2-ui v${last_version}${plain} La instalaci�n est� completa y el panel se ha activado"
systemctl daemon-reload
systemctl enable x-ui
systemctl start x-ui
echo -e ""
echo -e "  Si se trata de una nueva instalaci�n \n El puerto web predeterminado es ${green}65432${plain}\n El nombre de usuario y la contrase�a son ambos predeterminados ${green}admin${plain}"
echo -e "  Aseg�rese de que este puerto no est� ocupado por otros programas\n${yellow}Aseg�rate 65432 El puerto ha sido liberado${plain}"
echo -e "  Si desea modificar 65432 a otro puerto, \n ingrese el comando x-ui para modificarlo, \n y tambi�n aseg�rese de que el puerto que modifica tambi�n est� permitido"
echo -e ""
echo -e "Si es un panel de actualizaci�n, acceda al panel como lo hizo antes, \n A continuacion crearemos su Certificado SSL"
echo -e ""
msg -bar
echo -e "  Bienvenido a V2RAY-UI, edicion ChumoGH-ADM \n \033[1;36mLee detenidamente las indicaciones antes de continuar....."
msg -bar
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m Certificado AUTOMATICO    \033[0;32m(#OFICIAL)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m Crear Su Certificado SSL  \033[0;32m(#OFICIAL)"
echo -e " \033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m<\033[0;31m Cargar Certificado WEB    \033[0;33m(#EXPERIMENTAL)"
echo -e " \033[0;35m[\033[0;36m4\033[0;35m] \033[0;34m<\033[0;33m Certificado con DOMINIO   \033[0;32m(#EXPERIMENTAL)"
msg -bar 
echo -e " \033[0;35m[\033[0;36m0\033[0;35m] \033[0;34m<\033[0;33m Regresar"
msg -bar
echo -ne "${cor[6]}"
read -p " Opcion : " varread
done
echo -e "$BARRA"
if [[ ${varread} = 0 ]]; then
return 0
elif [[ ${varread} = 1 ]]; then
autogen
elif [[ ${varread} = 2 ]]; then
creargen
elif [[ ${varread} = 3 ]]; then
certweb
elif [[ ${varread} = 4 ]]; then
certdom
fi
}
act_gen
clear
    echo -e "----------------------------------------------"
echo -e "\033[1;36m 1). -PRIMER PASO -"
    echo -e "----------------------------------------------"
echo -e "\n    Desde Cualquier Navegador WEB | \nAccede con \033[1;32m http://$IP:54321 \033[1;31m "
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 2). -SEGUNDO PASO -"
    echo -e "----------------------------------------------"
echo -e "\nUSUARIO \033[1;32m admin\033[1;33m PASSWD \033[1;31m admin\033[1;31m "
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 3). -TERCER PASO -"
    echo -e "----------------------------------------------"
echo -e "\033[1;34mEn \033[1;32maccounts\033[1;31m a�ade en \033[1;32m+\033[1;31m y fijate "
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 4). -CUARTO PASO -"
    echo -e "----------------------------------------------"
echo -e "\033[1;31mAsegurate de Activar el \033[1;31mTLS"
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 5). -QUINTO PASO -"
    echo -e "----------------------------------------------"
echo -e "\033[1;31m Escoje tu Protocolo ADECUADO, \n Y en DOMAIN tu dominio"
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 6). -SEXTO PASO -"
    echo -e "----------------------------------------------"
echo -e "\033[1;31m En cert file path : \033[1;33m/etc/x-ui/cert.crt "
echo -e "\033[1;31m En key  file path : \033[1;33m/etc/x-ui/cert.key "
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 7). -SEPTIMO PASO -"
    echo -e "----------------------------------------------"
echo -e "\033[1;32m ASEGURATE DE MODIFICAR EL USUARIO Y PUERTO DE ACCESO "
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 8). -A�ade mas Perfiles, Si deseas!!  -"
    #echo -e "----------------------------------------------"
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 9). -DISFRUTA TU CONFGURACION SI TODO ES CORRECTO -"
    echo -e "----------------------------------------------"
echo -e "\033[1;32m 9). - Si deseas acceder al PANNEL teclea \033[1;35mx-ui \033[1;32men consola -"
    echo -e "----------------------------------------------"
	echo -e "  VISITA EL PORTAL https://seakfind.github.io/2021/10/10/X-UI/ "
    echo -e "----------------------------------------------"
curl -o /usr/bin/x-ui -sSL https://www.dropbox.com/s/lf2b5rhkasgjr8g/x-ui.sh
chmod +x /usr/bin/x-ui	
systemctl daemon-reload > /dev/null
systemctl x-ui enable > /dev/null
systemctl x-ui restart > /dev/null
#read -p " Presiona enter para continuar"
}

v2ray-socket() {
msg -bar
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m V2ray Manager Original (Todo en Consola)    \033[0;32m(#OFICIAL)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m V2ray Pannel WEB (Todo en WEB) By Dankel  \033[0;32m(#OFICIAL)"
echo -e " \033[0;35m[\033[0;36m3\033[0;35m] \033[0;34m<\033[0;31m V2ray Menu by @Rufu99 Reforma @ChumoGH    \033[0;33m(#EXPERIMENTAL)"
echo -e " \033[0;35m[\033[0;36m4\033[0;35m] \033[0;34m<\033[0;33m V2ray Menu by @Kalix1 Reforma @ChumoGH    \033[0;32m(#EXPERIMENTAL)"
echo -e " \033[0;35m[\033[0;36m5\033[0;35m] \033[0;34m<\033[0;33m V2ray Pannel WEB ( X-RAY ) Traduccion @ChumoGH \033[0;32m(#OFICIAL)"
#"\033[0;35m [\033[0;36m14\033[0;35m]\033[0;31m  ${cor[3]}X-UI (V2RAY WEB) \033[0;32m(#OFICIAL) $v2ui"
echo -e " \033[0;35m[\033[0;36m6\033[0;35m] \033[0;34m<\033[0;33m Desinstalar V2ray "
msg -bar 
 
echo -ne " ESCOJE: "; read v2op
case $v2op in
1)
[[ -e /etc/v2ray/config.json ]] && source <(curl -sSL https://www.dropbox.com/s/id3llagyfvwceyr/v2ray1.sh) || SCPdir="/etc/adm-lite"
SCPfrm="${SCPdir}/herramientas" 
[[ ! -d ${SCPfrm} ]] && mkdir ${SCPfrm}
SCPinst="${SCPdir}/protocolos" 
[[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
echo "Opcion Selecionada " $v2op "Vamos a Instalar"  
source <(curl -sL https://multi.netlify.com/v2ray.sh)
USRdatabase="/etc/adm-lite/RegV2ray"
[[ ! -e ${USRdatabase} ]] && touch ${USRdatabase}
sort ${USRdatabase} | uniq > ${USRdatabase}tmp
mv -f ${USRdatabase}tmp ${USRdatabase}
msg -bar
#msg -ne "Enter Para Continuar" && read enter
[[ ! -d ${SCPinst} ]] && mkdir ${SCPinst}
[[ ! -d /etc/adm-lite/v2ray ]] && mkdir /etc/adm-lite/v2ray
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
echo "DESEAS ENTRAR AL MENU PASO A PASO "
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
echo "source <(curl -sSL https://www.dropbox.com/s/id3llagyfvwceyr/v2ray1.sh)" > ${SCPinst}/v2ray.sh && chmod +x ${SCPinst}/v2ray.sh
${SCPinst}/v2ray.sh
else
v2ray 
fi
exit
;;
2)
echo "Opcion Selecionada " $v2op "Vamos a Instalar"  
bash <(curl -sL https://raw.githubusercontent.com/ChumoGH/chumogh-gmail.com/master/cgh-v2ray.sh)
;;
3)
#source <(curl -sL https://www.dropbox.com/s/z4dr3r8gs5i8tmf/v2ray_manager.sh)
source <(curl -sSL  https://www.dropbox.com/s/fjfc7aslg9gx8vt/v2ray_manager.sh)
#wget -q -O /tmp/rufu https://www.dropbox.com/s/z4dr3r8gs5i8tmf/v2ray_manager.sh; chmod +x /tmp/rufu && source /tmp/rufu
;;
4)
echo "Opcion Selecionada " $v2op "Vamos a Iniciar"  
unset yesno
while [[ ${yesno} != @(s|S|y|Y|n|N) ]]; do
echo "DESEAS ENTRAR AL MENU PASO A PASO "
read -p "[S/N]: " yesno
tput cuu1 && tput dl1
done
if [[ ${yesno} = @(s|S|y|Y) ]]; then
echo "source <(curl -sSL https://www.dropbox.com/s/id3llagyfvwceyr/v2ray1.sh)" > ${SCPinst}/v2ray.sh && chmod +x ${SCPinst}/v2ray.sh
${SCPinst}/v2ray.sh
else
v2ray 
fi
exit
;;
5)
[[ -e /usr/bin/x-ui ]] && x-ui || v2ui
;;
6)
echo "Opcion Selecionada " $v2op "Vamos a Desisnatalar"  
source <(curl -sL https://multi.netlify.com/v2ray.sh) --remove
source <(curl -sL https://git.io/fNgqx) --remove
rm -rf /usr/local/V2ray.Fun
rm -f /etc/v2ray/*
rm -rf /etc/v2ray/
exit
;;
*)
return 0
;;
esac
}

fun_openvpn () {
source <(curl -sSL https://www.dropbox.com/s/q5kvrcbjwcmcsut/openvpn.sh)
}

function tcpd(){
echo -e "A continuacion se instalara el TCP DNS"
echo -e "Este paquete solo funcionara en Debian/Ubuntu"
echo -e "AVISO!!!"
echo -e "Para realizar la instalacion de TCP DNS"
echo -e "Debes configurar previamente tu DNS/Dominio"
echo -e "Si aun no lo haz configurado el DNS/Dominio"
echo -e "Presiona CTRL + C para cancelar la instalacion"
echo -e "Si ya configuraste tu DNS/Dominio Correctamente, presiona ENTER"
read -p " "
echo -e "Espera un momento..."
echo -e "Limpiando DNS Primario..."
sleep 1
sed -i '/DNSStubListener/d' /etc/systemd/resolved.conf
echo -e "Agregando Fix DNS Primario..."
sleep 1
echo "DNSStubListener=no" >> /etc/systemd/resolved.conf
echo -e "Reiniciando DNS Primario..."
sleep 1
ln -sf /run/systemd/resolve/resolv.conf /etc/resolv.conf
systemctl restart systemd-resolved
echo -e "Instalando paquetes Necesarios, espere... "
sleep 1
apt-get install python-pip -y 1> /dev/null 2> /dev/null
apt-get install libevent-dev -y 1> /dev/null 2> /dev/null
apt-get install python-gevent -y 1> /dev/null 2> /dev/null
apt-get install python-daemon -y 1> /dev/null 2> /dev/null
git clone https://github.com/henices/Tcp-DNS-proxy.git 1> /dev/null 2> /dev/null
cd Tcp-DNS-proxy/
wget https://raw.githubusercontent.com/serverdensity/python-daemon/master/daemon.py
chmod +x ./install.sh
./install.sh
screen -dmS tcpdns python tcpdns.py -f tcpdns.json.example
cd /root
echo -e "TCP DNS Instalado"
echo -e "\033[1;31mPRESIONE ENTER PARA CONTINUAR\033[0m"
read -p " "
return 0
}

slow-dns () {
clear&&clear
apt-get install ncurses-utils > /dev/null 2>&1
msg -bar
slowmenu(){
while [[ ${varread} != @([0-2]) ]]; do
echo -e " MENU DE OPCION SLOWDNS "
msg -bar
echo -e " \033[0;35m[\033[0;36m1\033[0;35m] \033[0;34m<\033[0;33m SlowDNS By SSHPlus   \033[0;32m(#OFICIAL)" 
echo -e " \033[0;35m[\033[0;36m2\033[0;35m] \033[0;34m<\033[0;33m SlowDNS By Leiturita \033[0;32m(#OFICIAL)"
msg -bar
echo -e " \033[0;35m[\033[0;36m0\033[0;35m] \033[0;34m<\033[0;33m Regresar" 
echo -ne "${cor[6]}"
read -p " Opcion : " varread
done
msg -bar
if [[ ${varread} = 0 ]]; then
return 0
elif [[ ${varread} = 1 ]]; then
echo " ESTA FUNCION SE ESTA RECONFIGURANDO "
return 0
#https://raw.githubusercontent.com/AAAAAEXQOSyIpN2JZ0ehUQ/SSHPLUS-MANAGER-FREE/master/Modulos/slow_dns
elif [[ ${varread} = 2 ]]; then
rm -rf install; wget -q -O installbvg https://www.dropbox.com/s/8mi68owxeo5flfb/install.sh; chmod +x installbvg; ./installbvg #source <(curl -sSL https://www.dropbox.com/s/ifai4aw4jimcqqr/dnstt-install)
fi


}
msg -bar
[[ -e /bin/slowdns ]] && slowdns || slowmenu

return 0
}

function dnsserver(){
echo -e "Instalando DNS Server"
curl -sSL https://download.technitium.com/dns/install-ubuntu.sh | bash 1> /dev/null 2> /dev/null
echo -e "Actualizando DNS del Servidor"
echo -e "DNS Server Instalado"
echo -e "Consola Web DNS Server: http://$(wget -qO- ifconfig.me):5380/"
echo -e "No olvide establecer su password admin del Panel"
}

#FUNCOES
funcao_addcores () {
if [ "$1" = "0" ]; then
cor[$2]="\033[0m"
elif [ "$1" = "1" ]; then
cor[$2]="\033[1;31m"
elif [ "$1" = "2" ]; then
cor[$2]="\033[1;32m"
elif [ "$1" = "3" ]; then
cor[$2]="\033[1;33m"
elif [ "$1" = "4" ]; then
cor[$2]="\033[1;34m"
elif [ "$1" = "5" ]; then
cor[$2]="\033[1;35m"
elif [ "$1" = "6" ]; then
cor[$2]="\033[1;36m"
elif [ "$1" = "7" ]; then
cor[$2]="\033[1;37m"
fi
}

[[ -e $_cores ]] && {
_cont="0"
while read _cor; do
funcao_addcores ${_cor} ${_cont}
_cont=$(($_cont + 1))
done < $_cores
} || {
cor[0]="\033[0m"
cor[1]="\033[1;34m"
cor[2]="\033[1;32m"
cor[3]="\033[1;37m"
cor[4]="\033[1;36m"
cor[5]="\033[1;33m"
cor[6]="\033[1;35m"
}
unset squid
unset dropbear
unset openvpn
unset stunel
unset shadow
unset telegran
unset socks
unset gettun
unset tcpbypass
unset webminn
unset ddos
unset v2ray
#xclash=`if netstat -tunlp | grep clash 1> /dev/null 2> /dev/null; then
#echo -e "\033[1;32m[ON] "
#else
#echo -e "\033[1;31m[OFF]"
#fi`;
tojanss=`if netstat -tunlp | grep trojan 1> /dev/null 2> /dev/null; then
echo -e "\033[1;32m[ON] "
else
echo -e "\033[1;31m[OFF]"
fi`;
pps=`if netstat -tunlp | grep psiphond 1> /dev/null 2> /dev/null; then
echo -e "\033[1;32m[ON] "
else
echo -e "\033[1;31m[OFF]"
fi`;
v2ray=`if netstat -tunlp | grep v2ray 1> /dev/null 2> /dev/null; then
echo -e "\033[1;32m[ON] "
else
echo -e "\033[1;31m[OFF]"
fi`;
xclash=`if netstat -tunlp | grep clash 1> /dev/null 2> /dev/null; then
echo -e "\033[1;32m[ON] "
else
echo -e "\033[1;31m[OFF]"
fi`;
slowssh=$(ps x | grep "slowdns-ssh"|grep -v grep > /dev/null && echo -e "\033[1;32m " || echo -e "\033[1;31m ")
slowpid=$(ps x | grep -w "slowdns" | grep -v "grep" | awk -F "pts" '{print $1}') && [[ ! -z $slowpid ]] && P1="\033[0;32m[ON] " || P1="\033[1;31m[OFF]"
[[ -e /etc/squid3/squid.conf ]] && squid="\033[0;32m[ON] " || squid="\033[1;31m[OFF]"
[[ -e /etc/squid/squid.conf ]] && squid="\033[0;32m[ON] " || squid="\033[1;31m[OFF]"
[[ $(mportas|grep dropbear|head -1) ]] && dropbear="\033[0;32m[ON] " || dropbear="\033[1;31m[OFF]"
#[[ -e /etc/default/dropbear ]] 
[[ -e /etc/openvpn/server.conf ]] && openvpn="\033[0;32m[ON] " || openvpn="\033[1;31m[OFF]"
[[ $(mportas|grep stunnel4|head -1) ]] && stunel="\033[1;32m[ON] " || stunel="\033[1;31m[OFF]"
[[ -e /etc/shadowsocks.json ]] && shadow="\033[1;32m[ON]  " || shadow="\033[1;33m ( #BETA )"
[[ "$(ps x | grep "ultimatebot" | grep -v "grep")" != "" ]] && telegran="\033[1;32m[ON]"
[[ -e /bin/ejecutar/PortPD.log ]] && socks="\033[1;32m[\033[0;34mSPY\033[1;32m]" || socks="\033[1;31m[OFF]"
[[ -e /etc/adm-lite/edbypass ]] && tcpbypass="\033[1;32m[ON]" || tcpbypass="\033[1;31m[OFF]"
[[ -e /etc/webmin/miniserv.conf ]] && webminn="\033[1;32m[ON]" || webminn="\033[1;31m[OFF]"
[[ -e /usr/local/x-ui/bin/config.json ]] && v2ui="\033[1;32m[ON]" || v2ui="\033[1;31m[OFF]"
[[ -e /usr/local/etc/trojan/config.json ]] && troj="\033[1;32m[ON]" || troj="\033[1;31m[OFF]"
#[[ -e /root/.config/clash/config.yaml  ]] && xclash="\033[1;32m[ON] " || xclash="\033[1;31m[OFF]"
[[ -e /etc/default/sslh ]] && sslh="\033[1;32m[ON] " || sslh="\033[1;31m[OFF]"
[[ -e /usr/local/ddos/ddos.conf ]] && ddos="\033[1;32m[ON]"
#[[ -e $(mportas|grep v2ray|head -1) ]] && v2ray="\033[1;32m[ON]" || v2ray="\033[1;31m[OFF]"
ssssrr=`ps -ef |grep -v grep | grep server.py |awk '{print $2}'`
#ip=$(curl ifconfig.me) > /dev/null
[[ ! -z "${ssssrr}" ]] && cc="\033[1;32m" || cc="\033[1;31m"
user_info=$(cd /usr/local/shadowsocksr &> /dev/null  && python mujson_mgr.py -l )
user_total=$(echo "${user_info}"|wc -l)" Cts"
[[ -e /bin/ejecutar/msg ]] && source /bin/ejecutar/msg || source <(curl -sSL https://raw.githubusercontent.com/ChumoGH/ChumoGH-Script/master/msg-bar/msg)
clear
echo -e "${cor[5]}  INSTALACION DE X-UI WB "
msg -bar #echo -e "$barra"
echo -e "\033[0;35m [\033[0;36m1\033[0;35m]\033[0;31m  ${cor[3]}Salir "
echo -e "\033[0;35m [\033[0;36m2\033[0;35m]\033[0;31m  ${cor[3]}INSTALAR X-UI WEB \033[1;33m ( #PREMIUN )"
msg -bar #echo -e "$barra"
selection=$(selection_fun 2)
case ${selection} in
0)
source menu
exit
;;
1)
[[ -e /usr/bin/x-ui ]] && x-ui || v2ui
read -p " Enter";;
esac
#Reinicia ADM
source menu