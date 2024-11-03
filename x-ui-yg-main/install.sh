#!/bin/bash
export LANG=en_US.UTF-8
sred='\033[5;31m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;36m'
bblue='\033[0;34m'
plain='\033[0m'
red() { echo -e "\033[31m\033[01m$1\033[0m"; }
green() { echo -e "\033[32m\033[01m$1\033[0m"; }
yellow() { echo -e "\033[33m\033[01m$1\033[0m"; }
blue() { echo -e "\033[36m\033[01m$1\033[0m"; }
white() { echo -e "\033[37m\033[01m$1\033[0m"; }
readp() { read -p "$(yellow "$1")" $2; }
[[ $EUID -ne 0 ]] && yellow "Ejecute el script en modo raíz." && exit
#[[ -e /etc/hosts ]] && grep -qE '^ *172.65.251.78 gitlab.com' /etc/hosts || echo -e '\n172.65.251.78 gitlab.com' >> /etc/hosts
if [[ -f /etc/redhat-release ]]; then
  release="Centos"
elif cat /etc/issue | grep -q -E -i "debian"; then
  release="Debian"
elif cat /etc/issue | grep -q -E -i "ubuntu"; then
  release="Ubuntu"
elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
  release="Centos"
elif cat /proc/version | grep -q -E -i "debian"; then
  release="Debian"
elif cat /proc/version | grep -q -E -i "ubuntu"; then
  release="Ubuntu"
elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
  release="Centos"
else
  red "El sistema actual no es compatible. Elija utilizar el sistema Ubuntu, Debian o Centos." && exit
fi
vsid=$(grep -i version_id /etc/os-release | cut -d \" -f2 | cut -d . -f1)
op=$(cat /etc/redhat-release 2>/dev/null || cat /etc/os-release 2>/dev/null | grep -i pretty_name | cut -d \" -f2)
if [[ $(echo "$op" | grep -i -E "arch|alpine") ]]; then
  red "El script no es compatible con la versión actual. $op Sistema, elija utilizar el sistema Ubuntu, Debian, Centos." && exit
fi
version=$(uname -r | cut -d "-" -f1)
vi=$(systemd-detect-virt)
case $(uname -m) in
aarch64) cpu=arm64 ;;
x86_64) cpu=amd64 ;;
*) red "Actualmente el script no soporta $(uname -m)Arquitectura" && exit ;;
esac

if [[ -n $(sysctl net.ipv4.tcp_congestion_control 2>/dev/null | awk -F ' ' '{print $3}') ]]; then
  bbr=$(sysctl net.ipv4.tcp_congestion_control | awk -F ' ' '{print $3}')
elif [[ -n $(ping 10.0.0.2 -c 2 | grep ttl) ]]; then
  bbr="Openvz bbr-plus"
else
  bbr="Openvz/Lxc"
fi

if [ ! -f xuiyg_update ]; then
  green "Instale las dependencias necesarias del script x-ui-yg por primera vez..."
  if [[ $release = Centos && ${vsid} =~ 8 ]]; then
    cd /etc/yum.repos.d/ && mkdir backup && mv *repo backup/
    curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-8.repo
    sed -i -e "s|mirrors.cloud.aliyuncs.com|mirrors.aliyun.com|g " /etc/yum.repos.d/CentOS-*
    sed -i -e "s|releasever|releasever-stream|g" /etc/yum.repos.d/CentOS-*
    yum clean all && yum makecache
    cd
  fi
  if [ -x "$(command -v apt-get)" ]; then
    apt update -y
    apt install jq tzdata -y
  elif [ -x "$(command -v yum)" ]; then
    yum update -y && yum install epel-release -y
    yum install jq tzdata -y
  elif [ -x "$(command -v dnf)" ]; then
    dnf update -y
    dnf install jq tzdata -y
  fi
  if [ -x "$(command -v yum)" ] || [ -x "$(command -v dnf)" ]; then
    if ! command -v "cronie" &>/dev/null; then
      if [ -x "$(command -v yum)" ]; then
        yum install -y cronie
      elif [ -x "$(command -v dnf)" ]; then
        dnf install -y cronie
      fi
    fi
  fi
  touch xuiyg_update
fi

packages=("curl" "openssl" "tar" "expect" "wget" "git" "cron")
inspackages=("curl" "openssl" "tar" "expect" "wget" "git" "cron")
for i in "${!packages[@]}"; do
  package="${packages[$i]}"
  inspackage="${inspackages[$i]}"
  if ! command -v "$package" &>/dev/null; then
    if [ -x "$(command -v apt-get)" ]; then
      apt-get install -y "$inspackage"
    elif [ -x "$(command -v yum)" ]; then
      yum install -y "$inspackage"
    elif [ -x "$(command -v dnf)" ]; then
      dnf install -y "$inspackage"
    fi
  fi
done

if [[ $vi = openvz ]]; then
  TUN=$(cat /dev/net/tun 2>&1)
  if [[ ! $TUN =~ 'in bad state' ]] && [[ ! $TUN =~ 'en estado de error' ]] && [[ ! $TUN =~ 'Die Dateizugriffsnummer ist in schlechter Verfassung' ]]; then
    red "Se detecta que TUN no está habilitado. Ahora intente agregar soporte TUN." && sleep 4
    cd /dev && mkdir net && mknod net/tun c 10 200 && chmod 0666 net/tun
    TUN=$(cat /dev/net/tun 2>&1)
    if [[ ! $TUN =~ 'in bad state' ]] && [[ ! $TUN =~ 'en estado de error' ]] && [[ ! $TUN =~ 'Die Dateizugriffsnummer ist in schlechter Verfassung' ]]; then
      green "No se pudo agregar compatibilidad con TUN. Se recomienda comunicarse con el fabricante del VPS o habilitar la configuración en segundo plano." && exit
    else
      echo '#!/bin/bash' >/root/tun.sh && echo 'cd /dev && mkdir net && mknod net/tun c 10 200 && chmod 0666 net/tun' >>/root/tun.sh && chmod +x /root/tun.sh
      grep -qE "^ *@reboot root bash /root/tun.sh >/dev/null 2>&1" /etc/crontab || echo "@reboot root bash /root/tun.sh >/dev/null 2>&1" >>/etc/crontab
      green "Se ha iniciado la función TUN Guard"
    fi
  fi
fi

argopid() {
  ym=$(cat /usr/local/x-ui/xuiargoympid.log 2>/dev/null)
  ls=$(cat /usr/local/x-ui/xuiargopid.log 2>/dev/null)
}

v4v6() {
  v4=$(curl -s4m5 icanhazip.com -k)
  v6=$(curl -s6m5 icanhazip.com -k)
}

warpcheck() {
  wgcfv6=$(curl -s6m5 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
  wgcfv4=$(curl -s4m5 https://www.cloudflare.com/cdn-cgi/trace -k | grep warp | cut -d= -f2)
}

v6() {
  warpcheck
  if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
    v4=$(curl -s4m5 icanhazip.com -k)
    if [ -z $v4 ]; then
      yellow "VPS IPV6 puro detectado, agregue DNS64"
      echo -e "nameserver 2a00:1098:2b::1\nnameserver 2a00:1098:2c::1\nnameserver 2a01:4f8:c2c:123f::1" >/etc/resolv.conf
    fi
  fi
}

serinstall() {
  green "Descargue e instale componentes relacionados con x-ui..."
  cd /usr/local/
  #curl -sSL -o /usr/local/x-ui-linux-${cpu}.tar.gz --insecure https://gitlab.com/rwkgyg/x-ui-yg/raw/main/x-ui-linux-${cpu}.tar.gz
  curl -sSL -o /usr/local/x-ui-linux-${cpu}.tar.gz --insecure https://raw.githubusercontent.com/yonggekkk/x-ui-yg/main/x-ui-linux-${cpu}.tar.gz
  tar zxvf x-ui-linux-${cpu}.tar.gz >/dev/null 2>&1
  rm x-ui-linux-${cpu}.tar.gz -f
  cd x-ui
  chmod +x x-ui bin/xray-linux-${cpu}
  cp -f x-ui.service /etc/systemd/system/
  systemctl daemon-reload
  systemctl enable x-ui >/dev/null 2>&1
  systemctl start x-ui
  cd
  #curl -sSL -o /usr/bin/x-ui --insecure https://gitlab.com/rwkgyg/x-ui-yg/raw/main/1install.sh >/dev/null 2>&1
  curl -sSL -o /usr/bin/x-ui --insecure https://raw.githubusercontent.com/yonggekkk/x-ui-yg/main/install.sh >/dev/null 2>&1
  chmod +x /usr/bin/x-ui
  if [[ -f /usr/bin/x-ui && -f /usr/local/x-ui/bin/xray-linux-${cpu} ]]; then
    green "Descarga exitosa"
  else
    red "La descarga falló. Verifique si la red VPS es normal y el script se cierra."
    systemctl stop x-ui
    systemctl disable x-ui
    rm /etc/systemd/system/x-ui.service -f
    systemctl daemon-reload
    systemctl reset-failed
    rm /etc/x-ui-yg/ -rf
    rm /usr/local/x-ui/ -rf
    rm /usr/bin/x-ui -f
    rm -rf xuiyg_update
    exit
  fi
}

userinstall() {
  readp "Configure el nombre de usuario de inicio de sesión de x-ui (presione Enter para saltar a 6 caracteres aleatorios):" username
  sleep 1
  if [[ -z ${username} ]]; then
    username=$(date +%s%N | md5sum | cut -c 1-6)
  fi
  while true; do
    if [[ ${username} == *admin* ]]; then
      red "Los nombres de usuario que contienen la palabra admin no son compatibles, restablezca" && readp "Configure el nombre de usuario de inicio de sesión de x-ui (presione Enter para saltar a 6 caracteres aleatorios):" username
    else
      break
    fi
  done
  sleep 1
  green "Nombre de usuario de inicio de sesión de x-ui: ${username}"
  echo
  readp "Establezca la contraseña de inicio de sesión de x-ui (presione Enter para saltar a 6 caracteres aleatorios): " password
  sleep 1
  if [[ -z ${password} ]]; then
    password=$(date +%s%N | md5sum | cut -c 1-6)
  fi
  while true; do
    if [[ ${password} == *admin* ]]; then
      red "Las contraseñas que contienen la palabra admin no son compatibles; restablezcalas" && readp "Establezca la contraseña de inicio de sesión de x-ui (presione Enter para saltar a 6 caracteres aleatorios): " password
    else
      break
    fi
  done
  sleep 1
  green "contraseña de inicio de sesión x-ui: ${password}"
  /usr/local/x-ui/x-ui setting -username ${username} -password ${password} >/dev/null 2>&1
}

portinstall() {
  echo
  readp "Configure el puerto de inicio de sesión x-ui [1-65535] (presione Enter para saltar a un puerto aleatorio entre 2000-65535): " port
  sleep 1
  if [[ -z $port ]]; then
    port=$(shuf -i 2000-65535 -n 1)
    until [[ -z $(ss -tunlp | grep -w udp | awk '{print $5}' | sed 's/.*://g' | grep -w "$port") && -z $(ss -tunlp | grep -w tcp | awk '{print $5}' | sed 's/.*://g' | grep -w "$port") ]]; do
      [[ -n $(ss -tunlp | grep -w udp | awk '{print $5}' | sed 's/.*://g' | grep -w "$port") || -n $(ss -tunlp | grep -w tcp | awk '{print $5}' | sed 's/.*://g' | grep -w "$port") ]] && yellow "\nEl puerto está ocupado, vuelva a ingresar al puerto." && readp "Puerto personalizado:" port
    done
  else
    until [[ -z $(ss -tunlp | grep -w udp | awk '{print $5}' | sed 's/.*://g' | grep -w "$port") && -z $(ss -tunlp | grep -w tcp | awk '{print $5}' | sed 's/.*://g' | grep -w "$port") ]]; do
      [[ -n $(ss -tunlp | grep -w udp | awk '{print $5}' | sed 's/.*://g' | grep -w "$port") || -n $(ss -tunlp | grep -w tcp | awk '{print $5}' | sed 's/.*://g' | grep -w "$port") ]] && yellow "\nEl puerto está ocupado, vuelva a ingresar al puerto." && readp "Puerto personalizado:" port
    done
  fi
  sleep 1
  /usr/local/x-ui/x-ui setting -port $port >/dev/null 2>&1
  green "Puerto de inicio de sesión x-ui: ${port}"
}

resinstall() {
  echo "----------------------------------------------------------------------"
  restart
  #curl -sL https://gitlab.com/rwkgyg/x-ui-yg/-/raw/main/version/version | awk -F "更新内容" '{print $1}' | head -n 1 > /usr/local/x-ui/v
  curl -sL https://raw.githubusercontent.com/yonggekkk/x-ui-yg/main/version | awk -F "Actualizar contenido" '{print $1}' | head -n 1 >/usr/local/x-ui/v
  xuilogin() {
    v4v6
    if [[ -z $v4 ]]; then
      echo "[$v6]" >/usr/local/x-ui/xip
    elif [[ -n $v4 && -n $v6 ]]; then
      echo "$v4" >/usr/local/x-ui/xip
      echo "[$v6]" >>/usr/local/x-ui/xip
    else
      echo "$v4" >/usr/local/x-ui/xip
    fi
  }
  warpcheck
  if [[ ! $wgcfv4 =~ on|plus && ! $wgcfv6 =~ on|plus ]]; then
    xuilogin
  else
    systemctl stop wg-quick@wgcf >/dev/null 2>&1
    kill -15 $(pgrep warp-go) >/dev/null 2>&1 && sleep 2
    xuilogin
    systemctl start wg-quick@wgcf >/dev/null 2>&1
    systemctl restart warp-go >/dev/null 2>&1
    systemctl enable warp-go >/dev/null 2>&1
    systemctl start warp-go >/dev/null 2>&1
  fi
  sleep 2
  xuigo
  cronxui
  echo "----------------------------------------------------------------------"
  blue "x-ui-yg $(cat /usr/local/x-ui/v 2>/dev/null) La instalación es exitosa y ingresa automáticamente a x-ui para mostrar el menú de administración." && sleep 4
  echo
  show_menu
}

xuiinstall() {
  v6
  echo "----------------------------------------------------------------------"
  openyn
  echo "----------------------------------------------------------------------"
  serinstall
  echo "----------------------------------------------------------------------"
  userinstall
  portinstall
  resinstall
  [[ -e /etc/gai.conf ]] && grep -qE '^ *precedence ::ffff:0:0/96  100' /etc/gai.conf || echo 'precedence ::ffff:0:0/96  100' >>/etc/gai.conf 2>/dev/null
}

update() {
  yellow "También puede haber accidentes durante la actualización. Las sugerencias son las siguientes: "
  yellow "1. Haga clic en Copia de seguridad y restauración en el panel x-ui y descargue el archivo de copia de seguridad x-ui-yg.db"
  yellow "2. Exporte el archivo de copia de seguridad x-ui-yg.db en la ruta /etc/x-ui-yg"
  readp "Para confirmar la actualización, presione Enter (para salir, presione Ctrl+c):" ins
  if [[ -z $ins ]]; then
    systemctl stop x-ui
    #rm /usr/local/x-ui/ -rf
    serinstall && sleep 2
    restart
    #curl -sL https://gitlab.com/rwkgyg/x-ui-yg/-/raw/main/version/version | awk -F "更新内容" '{print $1}' | head -n 1 > /usr/local/x-ui/v
    curl -sL https://raw.githubusercontent.com/yonggekkk/x-ui-yg/main/version | awk -F "Actualizar contenido" '{print $1}' | head -n 1 >/usr/local/x-ui/v
    green "Actualización de x-ui completada" && sleep 2 && x-ui
  else
    red "Entrada incorrecta" && update
  fi
}

uninstall() {
  yellow "Esta desinstalación borrará todos los datos. Las sugerencias son las siguientes: "
  yellow "1. Haga clic en Copia de seguridad y restauración en el panel x-ui y descargue el archivo de copia de seguridad x-ui-yg.db"
  yellow "2. Exporte el archivo de copia de seguridad x-ui-yg.db en la ruta /etc/x-ui-yg"
  readp "Para confirmar la desinstalación, presione Enter (para salir, presione Ctrl+c):" ins
  if [[ -z $ins ]]; then
    systemctl stop x-ui
    systemctl disable x-ui
    rm /etc/systemd/system/x-ui.service -f
    systemctl daemon-reload
    systemctl reset-failed
    rm /etc/x-ui-yg/ -rf
    rm /usr/local/x-ui/ -rf
    rm /usr/bin/x-ui -f
    uncronxui
    rm -rf xuiyg_update
    sed -i '/^precedence ::ffff:0:0\/96  100/d' /etc/gai.conf 2>/dev/null
    echo
    green "x-ui ha sido desinstalado"
    echo
    blue "Bienvenido a continuar usando el script x-ui-yg: bash <(curl -Ls https://raw.githubusercontent.com/yonggekkk/x-ui-yg/main/install.sh)"
    echo
  else
    red "输入有误" && uninstall
  fi
}

reset_config() {
  /usr/local/x-ui/x-ui setting -reset
  sleep 1
  portinstall
}

stop() {
  systemctl stop x-ui
  check_status
  if [[ $? == 1 ]]; then
    crontab -l >/tmp/crontab.tmp
    sed -i '/goxui.sh/d' /tmp/crontab.tmp
    crontab /tmp/crontab.tmp
    rm /tmp/crontab.tmp
    green "x-ui停止成功"
  else
    red "x-ui no pudo detenerse, ejecute x-ui log para ver el registro y proporcionar comentarios" && exit
  fi
}

restart() {
  systemctl restart x-ui
  sleep 2
  check_status
  if [[ $? == 0 ]]; then
    crontab -l >/tmp/crontab.tmp
    sed -i '/goxui.sh/d' /tmp/crontab.tmp
    crontab /tmp/crontab.tmp
    rm /tmp/crontab.tmp
    crontab -l >/tmp/crontab.tmp
    echo "* * * * * /usr/local/x-ui/goxui.sh" >>/tmp/crontab.tmp
    crontab /tmp/crontab.tmp
    rm /tmp/crontab.tmp
    green "x-ui se reinició exitosamente"
  else
    red "x-ui no pudo reiniciarse, ejecute x-ui log para ver el registro y proporcionar comentarios" && exit
  fi
}

show_log() {
  journalctl -u x-ui.service -e --no-pager -f
}

get_char() {
  SAVEDSTTY=$(stty -g)
  stty -echo
  stty cbreak
  dd if=/dev/tty bs=1 count=1 2>/dev/null
  stty -raw
  stty echo
  stty $SAVEDSTTY
}

back() {
  white "------------------------------------------------------------------------------------"
  white "Para regresar al menú principal de x-ui, presione cualquier tecla"
  white "Para salir del script, presione Ctrl+C"
  get_char && show_menu
}

acme() {
  bash <(curl -Ls https://gitlab.com/rwkgyg/acme-script/raw/main/acme.sh)
  back
}

bbr() {
  bash <(curl -Ls https://raw.githubusercontent.com/teddysun/across/master/bbr.sh)
  back
}

cfwarp() {
  bash <(curl -Ls https://gitlab.com/rwkgyg/CFwarp/raw/main/CFwarp.sh)
  back
}

xuirestop() {
  echo
  readp "1. detener x-ui \n2. Reanudar x-ui \n0. Volver al menú principal\nPor favor seleccione: " action
  if [[ $action == "1" ]]; then
    stop
  elif [[ $action == "2" ]]; then
    restart
  else
    show_menu
  fi
}

xuichange() {
  echo
  readp "1. Cambiar nombre de usuario y contraseña de x-ui \n2. Cambiar el puerto de inicio de sesión del panel x-ui \n3. Restablezca la configuración del panel x-ui (todas las configuraciones en las opciones de configuración del panel se restaurarán a la configuración de fábrica, el puerto de inicio de sesión se volverá a personalizar y la cuenta y la contraseña permanecerán sin cambios)\n0. Volver al menú principal\nPor favor seleccione:" action
  if [[ $action == "1" ]]; then
    userinstall && restart
  elif [[ $action == "2" ]]; then
    portinstall && restart
  elif [[ $action == "3" ]]; then
    reset_config && restart
  else
    show_menu
  fi
}

check_status() {
  if [[ ! -f /etc/systemd/system/x-ui.service ]]; then
    return 2
  fi
  temp=$(systemctl status x-ui | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
  if [[ x"${temp}" == x"running" ]]; then
    return 0
  else
    return 1
  fi
}

check_enabled() {
  temp=$(systemctl is-enabled x-ui)
  if [[ x"${temp}" == x"enabled" ]]; then
    return 0
  else
    return 1
  fi
}

check_uninstall() {
  check_status
  if [[ $? != 2 ]]; then
    yellow "Se ha instalado x-ui. Puede elegir 2 para desinstalarlo primero y luego instalarlo." && sleep 3
    if [[ $# == 0 ]]; then
      show_menu
    fi
    return 1
  else
    return 0
  fi
}

check_install() {
  check_status
  if [[ $? == 2 ]]; then
    yellow "x-ui no está instalado, instale x-ui primero" && sleep 3
    if [[ $# == 0 ]]; then
      show_menu
    fi
    return 1
  else
    return 0
  fi
}

show_status() {
  check_status
  case $? in
  0)
    echo -e "estado x-ui: $blue ya corre $plain"
    show_enable_status
    ;;
  1)
    echo -e "estado x-ui: $yellow no corriendo $plain"
    show_enable_status
    ;;
  2)
    echo -e "estado x-ui: $red No instalado $plain"
    ;;
  esac
  show_xray_status
}

show_enable_status() {
  check_enabled
  if [[ $? == 0 ]]; then
    echo -e "x-ui inicio automático: $blue Sí $plain"
  else
    echo -e "x-ui inicio automático: $red No $plain"
  fi
}

check_xray_status() {
  count=$(ps -ef | grep "xray-linux" | grep -v "grep" | wc -l)
  if [[ count -ne 0 ]]; then
    return 0
  else
    return 1
  fi
}

show_xray_status() {
  check_xray_status
  if [[ $? == 0 ]]; then
    echo -e "estado de la xray: $blue Comenzo $plain"
  else
    echo -e "estado de la xray: $red No iniciado $plain"
  fi
}

xuigo() {
  cat >/usr/local/x-ui/goxui.sh <<-\EOF
#!/bin/bash
xui=`ps -aux |grep "x-ui" |grep -v "grep" |wc -l`
xray=`ps -aux |grep "xray" |grep -v "grep" |wc -l`
if [ $xui = 0 ];then
x-ui restart
fi
if [ $xray = 0 ];then
x-ui restart
fi
EOF
  chmod +x /usr/local/x-ui/goxui.sh
}

cronxui() {
  uncronxui
  crontab -l >/tmp/crontab.tmp
  echo "* * * * * /usr/local/x-ui/goxui.sh" >>/tmp/crontab.tmp
  echo "0 2 * * * x-ui restart" >>/tmp/crontab.tmp
  crontab /tmp/crontab.tmp
  rm /tmp/crontab.tmp
}

uncronxui() {
  crontab -l >/tmp/crontab.tmp
  sed -i '/goxui.sh/d' /tmp/crontab.tmp
  sed -i '/x-ui restart/d' /tmp/crontab.tmp
  sed -i '/xuiargoport.log/d' /tmp/crontab.tmp
  sed -i '/xuiargopid.log/d' /tmp/crontab.tmp
  sed -i '/xuiargoympid/d' /tmp/crontab.tmp
  crontab /tmp/crontab.tmp
  rm /tmp/crontab.tmp
}

close() {
  systemctl stop firewalld.service >/dev/null 2>&1
  systemctl disable firewalld.service >/dev/null 2>&1
  setenforce 0 >/dev/null 2>&1
  ufw disable >/dev/null 2>&1
  iptables -P INPUT ACCEPT >/dev/null 2>&1
  iptables -P FORWARD ACCEPT >/dev/null 2>&1
  iptables -P OUTPUT ACCEPT >/dev/null 2>&1
  iptables -t mangle -F >/dev/null 2>&1
  iptables -F >/dev/null 2>&1
  iptables -X >/dev/null 2>&1
  netfilter-persistent save >/dev/null 2>&1
  if [[ -n $(apachectl -v 2>/dev/null) ]]; then
    systemctl stop httpd.service >/dev/null 2>&1
    systemctl disable httpd.service >/dev/null 2>&1
    service apache2 stop >/dev/null 2>&1
    systemctl disable apache2 >/dev/null 2>&1
  fi
  sleep 1
  green "执行开放端口，关闭防火墙完毕"
}

openyn() {
  echo
  readp "是否开放端口，关闭防火墙？\n1、是，执行(回车默认)\n2、否，跳过！自行处理\n请选择：" action
  if [[ -z $action ]] || [[ $action == "1" ]]; then
    close
  elif [[ $action == "2" ]]; then
    echo
  else
    red "输入错误,请重新选择" && openyn
  fi
}

changeserv() {
  echo
  readp "1：设置Argo临时、固定隧道\n2：设置vmess与vless节点在订阅链接中的优选IP地址\n3：设置Gitlab订阅分享链接\n0：返回上层\n请选择【0-3】：" menu
  if [ "$menu" = "1" ]; then
    xuiargo
  elif [ "$menu" = "2" ]; then
    xuicfadd
  elif [ "$menu" = "3" ]; then
    gitlabsub
  else
    show_menu
  fi
}

cloudflaredargo() {
  if [ ! -e /usr/local/x-ui/cloudflared ]; then
    case $(uname -m) in
    aarch64) cpu=arm64 ;;
    x86_64) cpu=amd64 ;;
    #aarch64) cpu=car;;
    #x86_64) cpu=cam;;
    esac
    curl -L -o /usr/local/x-ui/cloudflared -# --retry 2 https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-$cpu
    #curl -L -o /usr/local/x-ui/cloudflared -# --retry 2 https://gitlab.com/rwkgyg/sing-box-yg/-/raw/main/$cpu
    chmod +x /usr/local/x-ui/cloudflared
  fi
}

xuiargo() {
  echo
  yellow "开启Argo隧道节点的两个前提要求："
  green "一、节点的传输协议是WS"
  green "二、节点的TLS必须关闭"
  green "节点类别可选：vmess-ws、vless-ws、trojan-ws、shadowsocks-ws。推荐vmess-ws"
  echo
  yellow "1：设置Argo临时隧道"
  yellow "2：设置Argo固定隧道"
  yellow "0：返回上层"
  readp "请选择【0-2】：" menu
  if [ "$menu" = "1" ]; then
    cfargo
  elif [ "$menu" = "2" ]; then
    cfargoym
  else
    changeserv
  fi
}

cfargo() {
  echo
  yellow "1：重置Argo临时隧道域名"
  yellow "2：停止Argo临时隧道"
  yellow "0：返回上层"
  readp "请选择【0-2】：" menu
  if [ "$menu" = "1" ]; then
    readp "请输入Argo监听的WS节点端口：" port
    echo "$port" >/usr/local/x-ui/xuiargoport.log
    cloudflaredargo
    i=0
    while [ $i -le 4 ]; do
      let i++
      yellow "第$i次刷新验证Cloudflared Argo隧道域名有效性，请稍等……"
      if [[ -n $(ps -e | grep cloudflared) ]]; then
        kill -15 $(cat /usr/local/x-ui/xuiargopid.log 2>/dev/null) >/dev/null 2>&1
      fi
      /usr/local/x-ui/cloudflared tunnel --url http://localhost:$port --edge-ip-version auto --no-autoupdate >/usr/local/x-ui/argo.log 2>&1 &
      echo "$!" >/usr/local/x-ui/xuiargopid.log
      sleep 20
      if [[ -n $(curl -sL https://$(cat /usr/local/x-ui/argo.log 2>/dev/null | grep -a trycloudflare.com | awk 'NR==2{print}' | awk -F// '{print $2}' | awk '{print $1}')/ -I | awk 'NR==1 && /404|400|503/') ]]; then
        argo=$(cat /usr/local/x-ui/argo.log 2>/dev/null | grep -a trycloudflare.com | awk 'NR==2{print}' | awk -F// '{print $2}' | awk '{print $1}')
        blue "Argo隧道申请成功，域名验证有效：$argo" && sleep 2
        break
      fi
      if [ $i -eq 5 ]; then
        red "请注意"
        yellow "1：请确保你输入的端口是x-ui已创建WS协议端口"
        yellow "2：Argo域名验证暂不可用，稍后可能会自动恢复，或者再次重置" && sleep 2
      fi
    done
    crontab -l >/tmp/crontab.tmp
    sed -i '/xuiargoport.log/d' /tmp/crontab.tmp
    crontab /tmp/crontab.tmp
    rm /tmp/crontab.tmp
    crontab -l >/tmp/crontab.tmp
    echo '@reboot /bin/bash -c "/usr/local/x-ui/cloudflared tunnel --url http://localhost:$(cat /usr/local/x-ui/xuiargoport.log) --edge-ip-version auto --no-autoupdate > /usr/local/x-ui/argo.log 2>&1 & pid=\$! && echo \$pid > /usr/local/x-ui/xuiargopid.log"' >>/tmp/crontab.tmp
    crontab /tmp/crontab.tmp
    rm /tmp/crontab.tmp
  elif [ "$menu" = "2" ]; then
    kill -15 $(cat /usr/local/x-ui/xuiargopid.log 2>/dev/null) >/dev/null 2>&1
    rm -rf /usr/local/x-ui/argo.log /usr/local/x-ui/xuiargopid.log /usr/local/x-ui/xuiargoport.log
    crontab -l >/tmp/crontab.tmp
    sed -i '/xuiargopid.log/d' /tmp/crontab.tmp
    crontab /tmp/crontab.tmp
    rm /tmp/crontab.tmp
    green "已卸载Argo临时隧道"
  else
    xuiargo
  fi
}

cfargoym() {
  echo
  if [[ -f /usr/local/x-ui/xuiargotoken.log && -f /usr/local/x-ui/xuiargoym.log ]]; then
    green "当前Argo固定隧道域名：$(cat /usr/local/x-ui/xuiargoym.log 2>/dev/null)"
    green "当前Argo固定隧道Token：$(cat /usr/local/x-ui/xuiargotoken.log 2>/dev/null)"
  fi
  echo
  green "请确保Cloudflare官网 --- Zero Trust --- Networks --- Tunnels已设置完成"
  yellow "1：重置/设置Argo固定隧道域名"
  yellow "2：停止Argo固定隧道"
  yellow "0：返回上层"
  readp "请选择【0-2】：" menu
  if [ "$menu" = "1" ]; then
    readp "请输入Argo监听的WS节点端口：" port
    echo "$port" >/usr/local/x-ui/xuiargoymport.log
    cloudflaredargo
    readp "输入Argo固定隧道Token: " argotoken
    readp "输入Argo固定隧道域名: " argoym
    if [[ -n $(ps -e | grep cloudflared) ]]; then
      kill -15 $(cat /usr/local/x-ui/xuiargoympid.log 2>/dev/null) >/dev/null 2>&1
    fi
    echo
    if [[ -n "${argotoken}" && -n "${argoym}" ]]; then
      nohup /usr/local/x-ui/cloudflared tunnel --edge-ip-version auto run --token ${argotoken} >/dev/null 2>&1 &
      echo "$!" >/usr/local/x-ui/xuiargoympid.log
      sleep 20
    fi
    echo ${argoym} >/usr/local/x-ui/xuiargoym.log
    echo ${argotoken} >/usr/local/x-ui/xuiargotoken.log
    crontab -l >/tmp/crontab.tmp
    sed -i '/xuiargoympid/d' /tmp/crontab.tmp
    echo '@reboot /bin/bash -c "nohup /usr/local/x-ui/cloudflared tunnel --edge-ip-version auto run --token $(cat /usr/local/x-ui/xuiargotoken.log 2>/dev/null) >/dev/null 2>&1 & pid=\$! && echo \$pid > /usr/local/x-ui/xuiargoympid.log"' >>/tmp/crontab.tmp
    crontab /tmp/crontab.tmp
    rm /tmp/crontab.tmp
    argo=$(cat /usr/local/x-ui/xuiargoym.log 2>/dev/null)
    blue "Argo固定隧道设置完成，固定域名：$argo"
  elif [ "$menu" = "2" ]; then
    kill -15 $(cat /usr/local/x-ui/xuiargoympid.log 2>/dev/null) >/dev/null 2>&1
    rm -rf /usr/local/x-ui/xuiargoym.log /usr/local/x-ui/xuiargoymport.log /usr/local/x-ui/xuiargoympid.log /usr/local/x-ui/xuiargotoken.log
    crontab -l >/tmp/crontab.tmp
    sed -i '/xuiargoympid/d' /tmp/crontab.tmp
    crontab /tmp/crontab.tmp
    rm /tmp/crontab.tmp
    green "已卸载Argo固定隧道"
  else
    xuiargo
  fi
}

xuicfadd() {
  [[ -s /usr/local/x-ui/bin/xuicdnip_ws.txt ]] && cdnwsname=$(cat /usr/local/x-ui/bin/xuicdnip_ws.txt 2>/dev/null) || cdnwsname='域名或IP直连'
  [[ -s /usr/local/x-ui/bin/xuicdnip_argo.txt ]] && cdnargoname=$(cat /usr/local/x-ui/bin/xuicdnip_argo.txt 2>/dev/null) || cdnargoname=www.visa.com.sg
  echo
  green "推荐使用稳定的世界大厂或组织的CDN网站作为客户端优选IP地址："
  blue "www.visa.com.sg"
  blue "www.wto.org"
  blue "www.web.com"
  echo
  yellow "1：设置所有主节点vmess/vless订阅节点客户端优选IP地址 【当前正使用：$cdnwsname】"
  yellow "2：设置Argo节点vmess/vless订阅节点客户端优选IP地址 【当前正使用：$cdnargoname】"
  yellow "0：返回上层"
  readp "请选择【0-2】：" menu
  if [ "$menu" = "1" ]; then
    red "请确保本地IP已解析到CF托管的域名上，节点端口已设置为13个CF标准端口："
    red "关tls端口：2052、2082、2086、2095、80、8880、8080"
    red "开tls端口：2053、2083、2087、2096、8443、443"
    red "如果VPS不支持以上13个CF标准端口（NAT类VPS），请在CF规则页面---Origin Rules页面下设置好回源规则" && sleep 2
    echo
    readp "输入自定义的优选IP/域名 (回车跳过表示恢复本地IP直连)：" menu
    [[ -z "$menu" ]] && >/usr/local/x-ui/bin/xuicdnip_ws.txt || echo "$menu" >/usr/local/x-ui/bin/xuicdnip_ws.txt
    green "设置成功，可选择7刷新" && sleep 2 && show_menu
  elif [ "$menu" = "2" ]; then
    red "请确保Argo临时隧道或者固定隧道的节点功能已启用" && sleep 2
    readp "输入自定义的优选IP/域名 (回车跳过表示用默认优选域名：www.visa.com.sg)：" menu
    [[ -z "$menu" ]] && >/usr/local/x-ui/bin/xuicdnip_argo.txt || echo "$menu" >/usr/local/x-ui/bin/xuicdnip_argo.txt
    green "设置成功，可选择7刷新" && sleep 2 && show_menu
  else
    changeserv
  fi
}

gitlabsub() {
  echo
  green "请确保Gitlab官网上已建立项目，已开启推送功能，已获取访问令牌"
  yellow "1：重置/设置Gitlab订阅链接"
  yellow "0：返回上层"
  readp "请选择【0-1】：" menu
  if [ "$menu" = "1" ]; then
    chown -R root:root /usr/local/x-ui/bin /usr/local/x-ui
    cd /usr/local/x-ui/bin
    readp "输入登录邮箱: " email
    readp "输入访问令牌: " token
    readp "输入用户名: " userid
    readp "输入项目名: " project
    echo
    green "多台VPS可共用一个令牌及项目名，可创建多个分支订阅链接"
    green "回车跳过表示不新建，仅使用主分支main订阅链接(首台VPS建议回车跳过)"
    readp "新建分支名称(可随意填写): " gitlabml
    echo
    sharesub_sbcl >/dev/null 2>&1
    if [[ -z "$gitlabml" ]]; then
      gitlab_ml=''
      git_sk=main
      rm -rf /usr/local/x-ui/bin/gitlab_ml_ml
    else
      gitlab_ml=":${gitlabml}"
      git_sk="${gitlabml}"
      echo "${gitlab_ml}" >/usr/local/x-ui/bin/gitlab_ml_ml
    fi
    echo "$token" >/usr/local/x-ui/bin/gitlabtoken.txt
    rm -rf /usr/local/x-ui/bin/.git
    git init >/dev/null 2>&1
    git add xui_singbox.json xui_clashmeta.yaml xui_ty.txt >/dev/null 2>&1
    git config --global user.email "${email}" >/dev/null 2>&1
    git config --global user.name "${userid}" >/dev/null 2>&1
    git commit -m "commit_add_$(date +"%F %T")" >/dev/null 2>&1
    branches=$(git branch)
    if [[ $branches == *master* ]]; then
      git branch -m master main >/dev/null 2>&1
    fi
    git remote add origin https://${token}@gitlab.com/${userid}/${project}.git >/dev/null 2>&1
    if [[ $(ls -a | grep '^\.git$') ]]; then
      cat >/usr/local/x-ui/bin/gitpush.sh <<EOF
#!/usr/bin/expect
spawn bash -c "git push -f origin main${gitlab_ml}"
expect "Password for 'https://$(cat /usr/local/x-ui/bin/gitlabtoken.txt 2>/dev/null)@gitlab.com':"
send "$(cat /usr/local/x-ui/bin/gitlabtoken.txt 2>/dev/null)\r"
interact
EOF
      chmod +x gitpush.sh
      ./gitpush.sh "git push -f origin main${gitlab_ml}" cat /usr/local/x-ui/bin/gitlabtoken.txt >/dev/null 2>&1
      echo "https://gitlab.com/api/v4/projects/${userid}%2F${project}/repository/files/xui_singbox.json/raw?ref=${git_sk}&private_token=${token}" >/usr/local/x-ui/bin/sing_box_gitlab.txt
      echo "https://gitlab.com/api/v4/projects/${userid}%2F${project}/repository/files/xui_clashmeta.yaml/raw?ref=${git_sk}&private_token=${token}" >/usr/local/x-ui/bin/clash_meta_gitlab.txt
      echo "https://gitlab.com/api/v4/projects/${userid}%2F${project}/repository/files/xui_ty.txt/raw?ref=${git_sk}&private_token=${token}" >/usr/local/x-ui/bin/xui_ty_gitlab.txt
      sharesubshow
    else
      yellow "设置Gitlab订阅链接失败，请反馈"
    fi
    cd
  else
    changeserv
  fi
}

sharesubshow() {
  green "当前X-ui-Sing-box节点已更新并推送"
  green "Sing-box订阅链接如下："
  blue "$(cat /usr/local/x-ui/bin/sing_box_gitlab.txt 2>/dev/null)"
  echo
  green "Sing-box订阅链接二维码如下："
  qrencode -o - -t ANSIUTF8 "$(cat /usr/local/x-ui/bin/sing_box_gitlab.txt 2>/dev/null)"
  sleep 3
  echo
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo
  green "当前X-ui-Clash-meta节点配置已更新并推送"
  green "Clash-meta订阅链接如下："
  blue "$(cat /usr/local/x-ui/bin/clash_meta_gitlab.txt 2>/dev/null)"
  echo
  green "Clash-meta订阅链接二维码如下："
  qrencode -o - -t ANSIUTF8 "$(cat /usr/local/x-ui/bin/clash_meta_gitlab.txt 2>/dev/null)"
  sleep 3
  echo
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo
  green "当前X-ui聚合通用节点配置已更新并推送"
  green "聚合通用节点订阅链接如下："
  blue "$(cat /usr/local/x-ui/bin/xui_ty_gitlab.txt 2>/dev/null)"
  sleep 3
  echo
  yellow "可以在网页上输入以上三个订阅链接查看配置内容，如果无配置内容，请自检Gitlab相关设置并重置"
  echo
}

sharesub() {
  sharesub_sbcl
  echo
  red "Gitlab订阅链接如下："
  echo
  cd /usr/local/x-ui/bin
  if [[ $(ls -a | grep '^\.git$') ]]; then
    if [ -f /usr/local/x-ui/bin/gitlab_ml_ml ]; then
      gitlab_ml=$(cat /usr/local/x-ui/bin/gitlab_ml_ml)
    fi
    git rm --cached xui_singbox.json xui_clashmeta.yaml xui_ty.txt >/dev/null 2>&1
    git commit -m "commit_rm_$(date +"%F %T")" >/dev/null 2>&1
    git add xui_singbox.json xui_clashmeta.yaml xui_ty.txt >/dev/null 2>&1
    git commit -m "commit_add_$(date +"%F %T")" >/dev/null 2>&1
    chmod +x gitpush.sh
    ./gitpush.sh "git push -f origin main${gitlab_ml}" cat /usr/local/x-ui/bin/gitlabtoken.txt >/dev/null 2>&1
    sharesubshow
  else
    yellow "未设置Gitlab订阅链接"
  fi
  cd
  echo
  white "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  red "🚀X-UI聚合通用节点分享链接显示如下："
  red "文件目录 /usr/local/x-ui/bin/xui_ty.txt ，可直接在客户端剪切板导入添加" && sleep 2
  echo
  cat /usr/local/x-ui/bin/xui_ty.txt
  echo
  white "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo
  white "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  red "🚀X-UI-Clash-Meta配置文件操作如下："
  red "文件目录 /usr/local/x-ui/bin/xui_clashmeta.yaml ，复制自建以yaml文件格式为准"
  echo
  red "输入：cat /usr/local/x-ui/bin/xui_clashmeta.yaml 即可显示配置内容" && sleep 2
  echo
  white "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo
  white "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  red "🚀XUI-Sing-box-SFA/SFI/SFW配置文件操作如下："
  red "文件目录 /usr/local/x-ui/bin/xui_singbox.json ，复制自建以json文件格式为准"
  echo
  red "输入：cat /usr/local/x-ui/bin/xui_singbox.json 即可显示配置内容" && sleep 2
  echo
  white "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo
}

sharesub_sbcl() {
  if [[ -s /usr/local/x-ui/bin/xuicdnip_argo.txt ]]; then
    cdnargo=$(cat /usr/local/x-ui/bin/xuicdnip_argo.txt 2>/dev/null)
  else
    cdnargo=www.visa.com.sg
  fi
  green "请稍等……"
  xip1=$(cat /usr/local/x-ui/xip 2>/dev/null | sed -n 1p)
  if [[ "$xip1" =~ : ]]; then
    dnsip='tls://[2001:4860:4860::8888]/dns-query'
  else
    dnsip='tls://8.8.8.8/dns-query'
  fi
  cat >/usr/local/x-ui/bin/xui_singbox.json <<EOF
{
  "log": {
    "disabled": false,
    "level": "info",
    "timestamp": true
  },
  "experimental": {
    "clash_api": {
      "external_controller": "127.0.0.1:9090",
      "external_ui": "ui",
      "external_ui_download_url": "",
      "external_ui_download_detour": "",
      "secret": "",
      "default_mode": "Rule"
       },
      "cache_file": {
            "enabled": true,
            "path": "cache.db",
            "store_fakeip": true
        }
    },
    "dns": {
        "servers": [
            {
                "tag": "proxydns",
                "address": "$dnsip",
                "detour": "select"
            },
            {
                "tag": "localdns",
                "address": "h3://223.5.5.5/dns-query",
                "detour": "direct"
            },
            {
                "address": "rcode://refused",
                "tag": "block"
            },
            {
                "tag": "dns_fakeip",
                "address": "fakeip"
            }
        ],
        "rules": [
            {
                "outbound": "any",
                "server": "localdns",
                "disable_cache": true
            },
            {
                "clash_mode": "Global",
                "server": "proxydns"
            },
            {
                "clash_mode": "Direct",
                "server": "localdns"
            },
            {
                "rule_set": "geosite-cn",
                "server": "localdns"
            },
            {
                 "rule_set": "geosite-geolocation-!cn",
                 "server": "proxydns"
            },
             {
                "rule_set": "geosite-geolocation-!cn",         
                "query_type": [
                    "A",
                    "AAAA"
                ],
                "server": "dns_fakeip"
            }
          ],
           "fakeip": {
           "enabled": true,
           "inet4_range": "198.18.0.0/15",
           "inet6_range": "fc00::/18"
         },
          "independent_cache": true,
          "final": "proxydns"
        },
      "inbounds": [
    {
      "type": "tun",
      "inet4_address": "172.19.0.1/30",
      "inet6_address": "fd00::1/126",
      "auto_route": true,
      "strict_route": true,
      "sniff": true,
      "sniff_override_destination": true,
      "domain_strategy": "prefer_ipv4"
    }
  ],
  "outbounds": [

//_0

    {
      "tag": "direct",
      "type": "direct"
    },
    {
      "tag": "block",
      "type": "block"
    },
    {
      "tag": "dns-out",
      "type": "dns"
    },
    {
      "tag": "select",
      "type": "selector",
      "default": "auto",
      "outbounds": [
        "auto",

//_1

      ]
    },
    {
      "tag": "auto",
      "type": "urltest",
      "outbounds": [

//_2

      ],
      "url": "https://www.gstatic.com/generate_204",
      "interval": "1m",
      "tolerance": 50,
      "interrupt_exist_connections": false
    }
  ],
  "route": {
      "rule_set": [
            {
                "tag": "geosite-geolocation-!cn",
                "type": "remote",
                "format": "binary",
                "url": "https://cdn.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@sing/geo/geosite/geolocation-!cn.srs",
                "download_detour": "select",
                "update_interval": "1d"
            },
            {
                "tag": "geosite-cn",
                "type": "remote",
                "format": "binary",
                "url": "https://cdn.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@sing/geo/geosite/geolocation-cn.srs",
                "download_detour": "select",
                "update_interval": "1d"
            },
            {
                "tag": "geoip-cn",
                "type": "remote",
                "format": "binary",
                "url": "https://cdn.jsdelivr.net/gh/MetaCubeX/meta-rules-dat@sing/geo/geoip/cn.srs",
                "download_detour": "select",
                "update_interval": "1d"
            }
        ],
    "auto_detect_interface": true,
    "final": "select",
    "rules": [
      {
        "outbound": "dns-out",
        "protocol": "dns"
      },
      {
        "clash_mode": "Direct",
        "outbound": "direct"
      },
      {
        "clash_mode": "Global",
        "outbound": "select"
      },
      {
        "rule_set": "geoip-cn",
        "outbound": "direct"
      },
      {
        "rule_set": "geosite-cn",
        "outbound": "direct"
      },
      {
      "ip_is_private": true,
      "outbound": "direct"
      },
      {
        "rule_set": "geosite-geolocation-!cn",
        "outbound": "select"
      }
    ]
  },
    "ntp": {
    "enabled": true,
    "server": "time.apple.com",
    "server_port": 123,
    "interval": "30m",
    "detour": "direct"
  }
}
EOF

  cat >/usr/local/x-ui/bin/xui_clashmeta.yaml <<EOF
port: 7890
allow-lan: true
mode: rule
log-level: info
unified-delay: true
global-client-fingerprint: chrome
dns:
  enable: true
  listen: :53
  ipv6: true
  enhanced-mode: fake-ip
  fake-ip-range: 198.18.0.1/16
  default-nameserver: 
    - 223.5.5.5
    - 8.8.8.8
  nameserver:
    - https://dns.alidns.com/dns-query
    - https://doh.pub/dns-query
  fallback:
    - https://1.0.0.1/dns-query
    - tls://dns.google
  fallback-filter:
    geoip: true
    geoip-code: CN
    ipcidr:
      - 240.0.0.0/4

proxies:

#_0

proxy-groups:
- name: 负载均衡
  type: load-balance
  url: https://www.gstatic.com/generate_204
  interval: 300
  strategy: round-robin
  proxies: 

#_1


- name: 自动选择
  type: url-test
  url: https://www.gstatic.com/generate_204
  interval: 300
  tolerance: 50
  proxies:  

#_2                         
    
- name: 🌍选择代理节点
  type: select
  proxies:
    - 负载均衡                                         
    - 自动选择
    - DIRECT

#_3

rules:
  - GEOIP,LAN,DIRECT
  - GEOIP,CN,DIRECT
  - MATCH,🌍选择代理节点
EOF

  xui_sb_cl() {
    sed -i "/#_0/r /usr/local/x-ui/bin/cl${i}.log" /usr/local/x-ui/bin/xui_clashmeta.yaml
    sed -i "/#_1/ i\\    - $tag" /usr/local/x-ui/bin/xui_clashmeta.yaml
    sed -i "/#_2/ i\\    - $tag" /usr/local/x-ui/bin/xui_clashmeta.yaml
    sed -i "/#_3/ i\\    - $tag" /usr/local/x-ui/bin/xui_clashmeta.yaml
    sed -i "/\/\/_0/r /usr/local/x-ui/bin/sb${i}.log" /usr/local/x-ui/bin/xui_singbox.json
    sed -i "/\/\/_1/ i\\ \"$tag\"," /usr/local/x-ui/bin/xui_singbox.json
    sed -i "/\/\/_2/ i\\ \"$tag\"," /usr/local/x-ui/bin/xui_singbox.json
  }

  tag_count=$(jq '.inbounds | map(select(.protocol == "vless" or .protocol == "vmess" or .protocol == "trojan" or .protocol == "shadowsocks")) | length' /usr/local/x-ui/bin/config.json)
  for ((i = 0; i < tag_count; i++)); do
    jq -c ".inbounds | map(select(.protocol == \"vless\" or .protocol == \"vmess\" or .protocol == \"trojan\" or .protocol == \"shadowsocks\"))[$i]" /usr/local/x-ui/bin/config.json >"/usr/local/x-ui/bin/$((i + 1)).log"
  done
  rm -rf /usr/local/x-ui/bin/ty.txt
  xip1=$(cat /usr/local/x-ui/xip 2>/dev/null | sed -n 1p)
  ymip=$(cat /root/ygkkkca/ca.log 2>/dev/null)
  directory="/usr/local/x-ui/bin/"
  for i in $(seq 1 $tag_count); do
    file="${directory}${i}.log"
    if [ -f "$file" ]; then
      #vless-reality-vision
      if grep -q "vless" "$file" && grep -q "reality" "$file" && grep -q "vision" "$file"; then
        finger=$(jq -r '.streamSettings.realitySettings.fingerprint' /usr/local/x-ui/bin/${i}.log)
        vl_name=$(jq -r '.streamSettings.realitySettings.serverNames[0]' /usr/local/x-ui/bin/${i}.log)
        public_key=$(jq -r '.streamSettings.realitySettings.publicKey' /usr/local/x-ui/bin/${i}.log)
        short_id=$(jq -r '.streamSettings.realitySettings.shortIds[0]' /usr/local/x-ui/bin/${i}.log)
        uuid=$(jq -r '.settings.clients[0].id' /usr/local/x-ui/bin/${i}.log)
        vl_port=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)
        tag=$vl_port-vless-reality-vision
        cat >/usr/local/x-ui/bin/sb${i}.log <<EOF

 {
      "type": "vless",
      "tag": "$tag",
      "server": "$xip1",
      "server_port": $vl_port,
      "uuid": "$uuid",
      "packet_encoding": "xudp",
      "flow": "xtls-rprx-vision",
      "tls": {
        "enabled": true,
        "server_name": "$vl_name",
        "utls": {
          "enabled": true,
          "fingerprint": "$finger"
        },
      "reality": {
          "enabled": true,
          "public_key": "$public_key",
          "short_id": "$short_id"
        }
      }
    },
EOF

        cat >/usr/local/x-ui/bin/cl${i}.log <<EOF

- name: $tag               
  type: vless
  server: $xip1                           
  port: $vl_port                                
  uuid: $uuid   
  network: tcp
  udp: true
  tls: true
  flow: xtls-rprx-vision
  servername: $vl_name                 
  reality-opts: 
    public-key: $public_key    
    short-id: '$short_id'                      
  client-fingerprint: $finger   

EOF
        echo "vless://$uuid@$xip1:$vl_port?type=tcp&security=reality&sni=$vl_name&pbk=$public_key&flow=xtls-rprx-vision&sid=$short_id&fp=$finger#$tag" >>/usr/local/x-ui/bin/ty.txt
        xui_sb_cl

      #vless-tcp-vision
      elif grep -q "vless" "$file" && grep -q "vision" "$file" && grep -q "keyFile" "$file"; then
        [[ -n $ymip ]] && servip=$ymip || servip=$xip1
        uuid=$(jq -r '.settings.clients[0].id' /usr/local/x-ui/bin/${i}.log)
        vl_port=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)
        tag=$vl_port-vless-tcp-vision
        cat >/usr/local/x-ui/bin/sb${i}.log <<EOF

{
            "server": "$servip",
            "server_port": $vl_port,
            "tag": "$tag",
            "tls": {
                "enabled": true,
                "insecure": false
            },
            "type": "vless",
            "flow": "xtls-rprx-vision",
            "uuid": "$uuid"
        },
EOF

        cat >/usr/local/x-ui/bin/cl${i}.log <<EOF

- name: $tag           
  type: vless
  server: $servip                     
  port: $vl_port                                  
  uuid: $uuid  
  network: tcp
  tls: true
  udp: true
  flow: xtls-rprx-vision


EOF
        echo "vless://$uuid@$servip:$vl_port?type=tcp&security=tls&flow=xtls-rprx-vision#$tag" >>/usr/local/x-ui/bin/ty.txt
        xui_sb_cl

      #vless-ws
      elif grep -q "vless" "$file" && grep -q "ws" "$file" && ! grep -qw "{}}}" "$file"; then
        ws_path=$(jq -r '.streamSettings.wsSettings.path' /usr/local/x-ui/bin/${i}.log)
        tls=$(jq -r '.streamSettings.security' /usr/local/x-ui/bin/${i}.log)
        vl_port=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)
        [[ $tls == 'tls' ]] && tls=true || tls=false
        if ! [[ "$vl_port" =~ ^(2052|2082|2086|2095|80|8880|8080|2053|2083|2087|2096|8443|443)$ ]] && [[ -s /usr/local/x-ui/bin/xuicdnip_ws.txt ]]; then
          servip=$(cat /usr/local/x-ui/bin/xuicdnip_ws.txt 2>/dev/null)
          if [[ $(jq -r '.streamSettings.security' /usr/local/x-ui/bin/${i}.log) == 'tls' ]]; then
            vl_port=8443
            tag=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)-回源-vless-ws-tls
          else
            vl_port=8880
            tag=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)-回源-vless-ws
          fi
        elif [[ "$vl_port" =~ ^(2052|2082|2086|2095|80|8880|8080|2053|2083|2087|2096|8443|443)$ ]] && [[ -s /usr/local/x-ui/bin/xuicdnip_ws.txt ]]; then
          servip=$(cat /usr/local/x-ui/bin/xuicdnip_ws.txt 2>/dev/null)
          [[ $(jq -r '.streamSettings.security' /usr/local/x-ui/bin/${i}.log) == 'tls' ]] && tag=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)-vless-ws-tls || tag=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)-vless-ws
        else
          [[ -n $ymip ]] && servip=$ymip || servip=$xip1
          [[ $(jq -r '.streamSettings.security' /usr/local/x-ui/bin/${i}.log) == 'tls' ]] && tag=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)-vless-ws-tls || tag=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)-vless-ws
        fi
        vl_name=$(jq -r '.streamSettings.wsSettings.headers.Host' /usr/local/x-ui/bin/${i}.log)
        uuid=$(jq -r '.settings.clients[0].id' /usr/local/x-ui/bin/${i}.log)

        cat >/usr/local/x-ui/bin/sb${i}.log <<EOF

{
            "server": "$servip",
            "server_port": $vl_port,
            "tag": "$tag",
            "tls": {
                "enabled": $tls,
                "server_name": "$vl_name",
                "insecure": false,
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            },
            "packet_encoding": "packetaddr",
            "transport": {
                "headers": {
                    "Host": [
                        "$vl_name"
                    ]
                },
                "path": "$ws_path",
                "type": "ws"
            },
            "type": "vless",
            "uuid": "$uuid"
        },
EOF

        cat >/usr/local/x-ui/bin/cl${i}.log <<EOF

- name: $tag                         
  type: vless
  server: $servip                       
  port: $vl_port                                     
  uuid: $uuid     
  udp: true
  tls: $tls
  network: ws
  servername: $vl_name                    
  ws-opts:
    path: "$ws_path"                             
    headers:
      Host: $vl_name 

EOF
        echo "vless://$uuid@$servip:$vl_port?type=ws&security=$tls&sni=$vl_name&path=$ws_path&host=$vl_name#$tag" >>/usr/local/x-ui/bin/ty.txt
        xui_sb_cl

      #vmess-ws
      elif grep -q "vmess" "$file" && grep -q "ws" "$file" && ! grep -qw "{}}}" "$file"; then
        ws_path=$(jq -r '.streamSettings.wsSettings.path' /usr/local/x-ui/bin/${i}.log)
        vm_port=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)
        tls=$(jq -r '.streamSettings.security' /usr/local/x-ui/bin/${i}.log)
        if [[ $tls == 'tls' ]]; then
          tls=true
          tlsw=tls
        else
          tls=false
          tlsw=''
        fi
        if ! [[ "$vm_port" =~ ^(2052|2082|2086|2095|80|8880|8080|2053|2083|2087|2096|8443|443)$ ]] && [[ -s /usr/local/x-ui/bin/xuicdnip_ws.txt ]]; then
          servip=$(cat /usr/local/x-ui/bin/xuicdnip_ws.txt 2>/dev/null)
          if [[ $(jq -r '.streamSettings.security' /usr/local/x-ui/bin/${i}.log) == 'tls' ]]; then
            vm_port=8443
            tag=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)-回源-vmess-ws-tls
          else
            vm_port=8880
            tag=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)-回源-vmess-ws
          fi
        elif [[ "$vm_port" =~ ^(2052|2082|2086|2095|80|8880|8080|2053|2083|2087|2096|8443|443)$ ]] && [[ -s /usr/local/x-ui/bin/xuicdnip_ws.txt ]]; then
          servip=$(cat /usr/local/x-ui/bin/xuicdnip_ws.txt 2>/dev/null)
          [[ $(jq -r '.streamSettings.security' /usr/local/x-ui/bin/${i}.log) == 'tls' ]] && tag=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)-vmess-ws-tls || tag=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)-vmess-ws
        else
          [[ -n $ymip ]] && servip=$ymip || servip=$xip1
          [[ $(jq -r '.streamSettings.security' /usr/local/x-ui/bin/${i}.log) == 'tls' ]] && tag=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)-vmess-ws-tls || tag=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)-vmess-ws
        fi
        vm_name=$(jq -r '.streamSettings.wsSettings.headers.Host' /usr/local/x-ui/bin/${i}.log)
        uuid=$(jq -r '.settings.clients[0].id' /usr/local/x-ui/bin/${i}.log)
        cat >/usr/local/x-ui/bin/sb${i}.log <<EOF

{
            "server": "$servip",
            "server_port": $vm_port,
            "tag": "$tag",
            "tls": {
                "enabled": $tls,
                "server_name": "$vm_name",
                "insecure": false,
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            },
            "packet_encoding": "packetaddr",
            "transport": {
                "headers": {
                    "Host": [
                        "$vm_name"
                    ]
                },
                "path": "$ws_path",
                "type": "ws"
            },
            "type": "vmess",
            "security": "auto",
            "uuid": "$uuid"
        },
EOF

        cat >/usr/local/x-ui/bin/cl${i}.log <<EOF

- name: $tag                         
  type: vmess
  server: $servip                        
  port: $vm_port                                     
  uuid: $uuid       
  alterId: 0
  cipher: auto
  udp: true
  tls: $tls
  network: ws
  servername: $vm_name                    
  ws-opts:
    path: "$ws_path"                             
    headers:
      Host: $vm_name

EOF
        echo -e "vmess://$(echo '{"add":"'$servip'","aid":"0","host":"'$vm_name'","id":"'$uuid'","net":"ws","path":"'$ws_path'","port":"'$vm_port'","ps":"'$tag'","tls":"'$tlsw'","sni":"'$vm_name'","type":"none","v":"2"}' | base64 -w 0)" >>/usr/local/x-ui/bin/ty.txt
        xui_sb_cl

      #vmess-tcp
      elif grep -q "vmess" "$file" && grep -q "tcp" "$file"; then
        [[ -n $ymip ]] && servip=$ymip || servip=$xip1
        tls=$(jq -r '.streamSettings.security' /usr/local/x-ui/bin/${i}.log)
        if [[ $tls == 'tls' ]]; then
          tls=true
          tlst=tls
        else
          tls=false
          tlst=''
        fi
        uuid=$(jq -r '.settings.clients[0].id' /usr/local/x-ui/bin/${i}.log)
        vm_port=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)
        tag=$vm_port-vmess-tcp
        cat >/usr/local/x-ui/bin/sb${i}.log <<EOF

{
            "server": "$servip",
            "server_port": $vm_port,
            "tag": "$tag",
            "tls": {
                "enabled": $tls,
                "insecure": false,
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            },
            "packet_encoding": "packetaddr",
            "type": "vmess",
            "security": "auto",
            "uuid": "$uuid"
        },
EOF

        cat >/usr/local/x-ui/bin/cl${i}.log <<EOF

- name: $tag                         
  type: vmess
  server: $servip                        
  port: $vm_port                                     
  uuid: $uuid       
  alterId: 0
  cipher: auto
  udp: true
  tls: $tls

EOF
        echo -e "vmess://$(echo '{"add":"'$servip'","aid":"0","id":"'$uuid'","net":"tcp","port":"'$vm_port'","ps":"'$tag'","tls":"'$tlst'","type":"none","v":"2"}' | base64 -w 0)" >>/usr/local/x-ui/bin/ty.txt
        xui_sb_cl

      #vless-tcp
      elif grep -q "vless" "$file" && grep -q "tcp" "$file"; then
        [[ -n $ymip ]] && servip=$ymip || servip=$xip1
        tls=$(jq -r '.streamSettings.security' /usr/local/x-ui/bin/${i}.log)
        [[ $tls == 'tls' ]] && tls=true || tls=false
        uuid=$(jq -r '.settings.clients[0].id' /usr/local/x-ui/bin/${i}.log)
        vl_port=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)
        tag=$vl_port-vless-tcp
        cat >/usr/local/x-ui/bin/sb${i}.log <<EOF

{
            "server": "$servip",
            "server_port": $vl_port,
            "tag": "$tag",
            "tls": {
                "enabled": $tls,
                "insecure": false,
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            },
            "packet_encoding": "packetaddr",
            "type": "vless",
            "uuid": "$uuid"
        },
EOF

        cat >/usr/local/x-ui/bin/cl${i}.log <<EOF

- name: $tag                         
  type: vless
  server: $servip                       
  port: $vl_port                                     
  uuid: $uuid     
  udp: true
  tls: $tls

EOF
        echo "vless://$uuid@$servip:$vl_port?type=tcp&security=$tls#$tag" >>/usr/local/x-ui/bin/ty.txt
        xui_sb_cl

      #trojan-tcp-tls
      elif grep -q "trojan" "$file" && grep -q "tcp" "$file" && grep -q "keyFile" "$file"; then
        [[ -n $ymip ]] && servip=$ymip || servip=$xip1
        password=$(jq -r '.settings.clients[0].password' /usr/local/x-ui/bin/${i}.log)
        vl_port=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)
        tag=$vl_port-trojan-tcp-tls
        cat >/usr/local/x-ui/bin/sb${i}.log <<EOF

{
            "server": "$servip",
            "server_port": $vl_port,
            "tag": "$tag",
            "tls": {
                "enabled": true,
                "insecure": false
            },
            "type": "trojan",
            "password": "$password"
        },
EOF

        cat >/usr/local/x-ui/bin/cl${i}.log <<EOF

- name: $tag                         
  type: trojan
  server: $servip                       
  port: $vl_port                                     
  password: $password    
  udp: true
  sni: $servip
  skip-cert-verify: false

EOF
        echo "trojan://$password@$servip:$vl_port?security=tls&type=tcp#$tag" >>/usr/local/x-ui/bin/ty.txt
        xui_sb_cl

      #trojan-ws-tls
      elif grep -q "trojan" "$file" && grep -q "ws" "$file" && grep -q "keyFile" "$file"; then
        ws_path=$(jq -r '.streamSettings.wsSettings.path' /usr/local/x-ui/bin/${i}.log)
        vm_name=$(jq -r '.streamSettings.wsSettings.headers.Host' /usr/local/x-ui/bin/${i}.log)
        [[ -n $ymip ]] && servip=$ymip || servip=$xip1
        tls=$(jq -r '.streamSettings.security' /usr/local/x-ui/bin/${i}.log)
        [[ $tls == 'tls' ]] && tls=true || tls=false
        password=$(jq -r '.settings.clients[0].password' /usr/local/x-ui/bin/${i}.log)
        vl_port=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)
        tag=$vl_port-trojan-ws-tls
        cat >/usr/local/x-ui/bin/sb${i}.log <<EOF

{
            "server": "$servip",
            "server_port": $vl_port,
            "tag": "$tag",
            "tls": {
                "enabled": $tls,
                "insecure": false
            },
            "transport": {
                "headers": {
                    "Host": [
                        "$vm_name"
                    ]
                },
                "path": "$ws_path",
                "type": "ws"
            },
            "type": "trojan",
            "password": "$password"
        },
EOF

        cat >/usr/local/x-ui/bin/cl${i}.log <<EOF

- name: $tag                         
  type: trojan
  server: $servip                       
  port: $vl_port                                     
  password: $password    
  udp: true
  sni: $servip
  skip-cert-verify: false
  network: ws                 
  ws-opts:
    path: "$ws_path"                             
    headers:
      Host: $vm_name

EOF
        echo "trojan://$password@$servip:$vl_port?security=tls&type=ws&path=$ws_path&host=$vm_name#$tag" >>/usr/local/x-ui/bin/ty.txt
        xui_sb_cl

      #shadowsocks-tcp
      elif grep -q "shadowsocks" "$file" && grep -q "tcp" "$file"; then
        [[ -n $ymip ]] && servip=$ymip || servip=$xip1
        password=$(jq -r '.settings.password' /usr/local/x-ui/bin/${i}.log)
        vm_port=$(jq -r '.port' /usr/local/x-ui/bin/${i}.log)
        ssmethod=$(jq -r '.settings.method' /usr/local/x-ui/bin/${i}.log)
        tag=$vm_port-ss-tcp
        cat >/usr/local/x-ui/bin/sb${i}.log <<EOF

{
      "type": "shadowsocks",
      "tag": "$tag",
      "server": "$servip",
      "server_port": $vm_port,
      "method": "$ssmethod",
      "password": "$password"
},
EOF

        cat >/usr/local/x-ui/bin/cl${i}.log <<EOF

- name: $tag                         
  type: ss
  server: $servip                        
  port: $vm_port                                     
  password: $password
  cipher: $ssmethod
  udp: true

EOF
        echo -e "ss://$ssmethod:$password@$servip:$vm_port#$tag" >>/usr/local/x-ui/bin/ty.txt
        xui_sb_cl
      fi
    else
      red "当前x-ui未设置有效的节点配置" && exit
    fi
  done

  argopid
  argoprotocol=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .protocol' /usr/local/x-ui/bin/config.json 2>/dev/null)
  uuid=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .settings.clients[0].id' /usr/local/x-ui/bin/config.json 2>/dev/null)
  ws_path=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .streamSettings.wsSettings.path' /usr/local/x-ui/bin/config.json 2>/dev/null)
  argotls=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .streamSettings.security' /usr/local/x-ui/bin/config.json 2>/dev/null)
  argolsym=$(cat /usr/local/x-ui/argo.log 2>/dev/null | grep -a trycloudflare.com | awk 'NR==2{print}' | awk -F// '{print $2}' | awk '{print $1}')
  if [[ -n $(ps -e | grep -w $ls 2>/dev/null) ]] && [[ -f /usr/local/x-ui/xuiargoport.log ]] && [[ $argoprotocol =~ vless|vmess ]] && [[ ! "$argotls" = "tls" ]]; then
    if [[ $argoprotocol = vless ]]; then
      #vless-ws-tls-argo临时
      cat >/usr/local/x-ui/bin/sbvltargo.log <<EOF

{
            "server": "$cdnargo",
            "server_port": 8443,
            "tag": "vl-tls-argo临时-8443",
            "tls": {
                "enabled": true,
                "server_name": "$argolsym",
                "insecure": false,
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            },
            "packet_encoding": "packetaddr",
            "transport": {
                "headers": {
                    "Host": [
                        "$argolsym"
                    ]
                },
                "path": "$ws_path",
                "type": "ws"
            },
            "type": "vless",
            "uuid": "$uuid"
        },
EOF

      cat >/usr/local/x-ui/bin/clvltargo.log <<EOF

- name: vl-tls-argo临时-8443                         
  type: vless
  server: $cdnargo                       
  port: 8443                                     
  uuid: $uuid     
  udp: true
  tls: true
  network: ws
  servername: $argolsym                    
  ws-opts:
    path: "$ws_path"                             
    headers:
      Host: $argolsym 

EOF

      #vless-ws-argo临时
      cat >/usr/local/x-ui/bin/sbvlargo.log <<EOF

{
            "server": "$cdnargo",
            "server_port": 8880,
            "tag": "vl-argo临时-8880",
            "tls": {
                "enabled": false,
                "server_name": "$argolsym",
                "insecure": false,
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            },
            "packet_encoding": "packetaddr",
            "transport": {
                "headers": {
                    "Host": [
                        "$argolsym"
                    ]
                },
                "path": "$ws_path",
                "type": "ws"
            },
            "type": "vless",
            "uuid": "$uuid"
        },
EOF

      cat >/usr/local/x-ui/bin/clvlargo.log <<EOF

- name: vl-argo临时-8880                         
  type: vless
  server: $cdnargo                       
  port: 8880                                     
  uuid: $uuid     
  udp: true
  tls: false
  network: ws
  servername: $argolsym                    
  ws-opts:
    path: "$ws_path"                             
    headers:
      Host: $argolsym 

EOF
      sed -i "/#_0/r /usr/local/x-ui/bin/clvltargo.log" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_1/ i\\    - vl-tls-argo临时-8443" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_2/ i\\    - vl-tls-argo临时-8443" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_3/ i\\    - vl-tls-argo临时-8443" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_0/r /usr/local/x-ui/bin/clvlargo.log" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_1/ i\\    - vl-argo临时-8880" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_2/ i\\    - vl-argo临时-8880" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_3/ i\\    - vl-argo临时-8880" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/\/\/_0/r /usr/local/x-ui/bin/sbvltargo.log" /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_1/ i\\ \"vl-tls-argo临时-8443\"," /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_2/ i\\ \"vl-tls-argo临时-8443\"," /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_0/r /usr/local/x-ui/bin/sbvlargo.log" /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_1/ i\\ \"vl-argo临时-8880\"," /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_2/ i\\ \"vl-argo临时-8880\"," /usr/local/x-ui/bin/xui_singbox.json
      echo "vless://$uuid@$cdnargo:8880?type=ws&security=none&path=$ws_path&host=$argolsym#vl-argo临时-8880" >>/usr/local/x-ui/bin/ty.txt
      echo "vless://$uuid@$cdnargo:8443?type=ws&security=tls&path=$ws_path&host=$argolsym#vl-tls-argo临时-8443" >>/usr/local/x-ui/bin/ty.txt

    elif [[ $argoprotocol = vmess ]]; then
      #vmess-ws-tls-argo临时
      cat >/usr/local/x-ui/bin/sbvmtargo.log <<EOF

{
            "server": "$cdnargo",
            "server_port": 8443,
            "tag": "vm-tls-argo临时-8443",
            "tls": {
                "enabled": true,
                "server_name": "$argolsym",
                "insecure": false,
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            },
            "packet_encoding": "packetaddr",
            "transport": {
                "headers": {
                    "Host": [
                        "$argolsym"
                    ]
                },
                "path": "$ws_path",
                "type": "ws"
            },
            "type": "vmess",
            "security": "auto",
            "uuid": "$uuid"
        },
EOF

      cat >/usr/local/x-ui/bin/clvmtargo.log <<EOF

- name: vm-tls-argo临时-8443                        
  type: vmess
  server: $cdnargo                        
  port: 8443                                     
  uuid: $uuid       
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  network: ws
  servername: $argolsym                    
  ws-opts:
    path: "$ws_path"                             
    headers:
      Host: $argolsym

EOF

      #vmess-ws-argo临时
      cat >/usr/local/x-ui/bin/sbvmargo.log <<EOF

{
            "server": "$cdnargo",
            "server_port": 8880,
            "tag": "vm-argo临时-8880",
            "tls": {
                "enabled": false,
                "server_name": "$argolsym",
                "insecure": false,
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            },
            "packet_encoding": "packetaddr",
            "transport": {
                "headers": {
                    "Host": [
                        "$argolsym"
                    ]
                },
                "path": "$ws_path",
                "type": "ws"
            },
            "type": "vmess",
            "security": "auto",
            "uuid": "$uuid"
        },
EOF

      cat >/usr/local/x-ui/bin/clvmargo.log <<EOF

- name: vm-argo临时-8880                         
  type: vmess
  server: $cdnargo                       
  port: 8880                                     
  uuid: $uuid       
  alterId: 0
  cipher: auto
  udp: true
  tls: false
  network: ws
  servername: $argolsym                    
  ws-opts:
    path: "$ws_path"                             
    headers:
      Host: $argolsym

EOF
      sed -i "/#_0/r /usr/local/x-ui/bin/clvmtargo.log" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_1/ i\\    - vm-tls-argo临时-8443" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_2/ i\\    - vm-tls-argo临时-8443" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_3/ i\\    - vm-tls-argo临时-8443" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_0/r /usr/local/x-ui/bin/clvmargo.log" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_1/ i\\    - vm-argo临时-8880" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_2/ i\\    - vm-argo临时-8880" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_3/ i\\    - vm-argo临时-8880" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/\/\/_0/r /usr/local/x-ui/bin/sbvmtargo.log" /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_1/ i\\ \"vm-tls-argo临时-8443\"," /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_2/ i\\ \"vm-tls-argo临时-8443\"," /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_0/r /usr/local/x-ui/bin/sbvmargo.log" /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_1/ i\\ \"vm-argo临时-8880\"," /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_2/ i\\ \"vm-argo临时-8880\"," /usr/local/x-ui/bin/xui_singbox.json
      echo -e "vmess://$(echo '{"add":"'$cdnargo'","aid":"0","host":"'$argolsym'","id":"'$uuid'","net":"ws","path":"'$ws_path'","port":"8880","ps":"vm-argo临时-8880","v":"2"}' | base64 -w 0)" >>/usr/local/x-ui/bin/ty.txt
      echo -e "vmess://$(echo '{"add":"'$cdnargo'","aid":"0","host":"'$argolsym'","id":"'$uuid'","net":"ws","path":"'$ws_path'","port":"8443","ps":"vm-tls-argo临时-8443","tls":"tls","sni":"'$argolsym'","type":"none","v":"2"}' | base64 -w 0)" >>/usr/local/x-ui/bin/ty.txt
    fi
  fi

  argoprotocol=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoymport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .protocol' /usr/local/x-ui/bin/config.json 2>/dev/null)
  uuid=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoymport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .settings.clients[0].id' /usr/local/x-ui/bin/config.json 2>/dev/null)
  ws_path=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoymport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .streamSettings.wsSettings.path' /usr/local/x-ui/bin/config.json 2>/dev/null)
  argotls=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoymport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .streamSettings.security' /usr/local/x-ui/bin/config.json 2>/dev/null)
  argoym=$(cat /usr/local/x-ui/xuiargoym.log 2>/dev/null)
  if [[ -n $(ps -e | grep -w $ym 2>/dev/null) ]] && [[ -f /usr/local/x-ui/xuiargoymport.log ]] && [[ $argoprotocol =~ vless|vmess ]] && [[ ! "$argotls" = "tls" ]]; then
    if [[ $argoprotocol = vless ]]; then
      #vless-ws-tls-argo固定
      cat >/usr/local/x-ui/bin/sbvltargoym.log <<EOF

{
            "server": "$cdnargo",
            "server_port": 8443,
            "tag": "vl-tls-argo固定-8443",
            "tls": {
                "enabled": true,
                "server_name": "$argoym",
                "insecure": false,
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            },
            "packet_encoding": "packetaddr",
            "transport": {
                "headers": {
                    "Host": [
                        "$argoym"
                    ]
                },
                "path": "$ws_path",
                "type": "ws"
            },
            "type": "vless",
            "uuid": "$uuid"
        },
EOF

      cat >/usr/local/x-ui/bin/clvltargoym.log <<EOF

- name: vl-tls-argo固定-8443                         
  type: vless
  server: $cdnargo                       
  port: 8443                                     
  uuid: $uuid     
  udp: true
  tls: true
  network: ws
  servername: $argoym                    
  ws-opts:
    path: "$ws_path"                             
    headers:
      Host: $argoym 

EOF

      #vless-ws-argo固定
      cat >/usr/local/x-ui/bin/sbvlargoym.log <<EOF

{
            "server": "$cdnargo",
            "server_port": 8880,
            "tag": "vl-argo固定-8880",
            "tls": {
                "enabled": false,
                "server_name": "$argoym",
                "insecure": false,
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            },
            "packet_encoding": "packetaddr",
            "transport": {
                "headers": {
                    "Host": [
                        "$argoym"
                    ]
                },
                "path": "$ws_path",
                "type": "ws"
            },
            "type": "vless",
            "uuid": "$uuid"
        },
EOF

      cat >/usr/local/x-ui/bin/clvlargoym.log <<EOF

- name: vl-argo固定-8880                         
  type: vless
  server: $cdnargo                       
  port: 8880                                     
  uuid: $uuid     
  udp: true
  tls: false
  network: ws
  servername: $argoym                    
  ws-opts:
    path: "$ws_path"                             
    headers:
      Host: $argoym 

EOF
      sed -i "/#_0/r /usr/local/x-ui/bin/clvltargoym.log" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_1/ i\\    - vl-tls-argo固定-8443" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_2/ i\\    - vl-tls-argo固定-8443" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_3/ i\\    - vl-tls-argo固定-8443" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_0/r /usr/local/x-ui/bin/clvlargoym.log" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_1/ i\\    - vl-argo固定-8880" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_2/ i\\    - vl-argo固定-8880" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_3/ i\\    - vl-argo固定-8880" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/\/\/_0/r /usr/local/x-ui/bin/sbvltargoym.log" /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_1/ i\\ \"vl-tls-argo固定-8443\"," /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_2/ i\\ \"vl-tls-argo固定-8443\"," /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_0/r /usr/local/x-ui/bin/sbvlargoym.log" /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_1/ i\\ \"vl-argo固定-8880\"," /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_2/ i\\ \"vl-argo固定-8880\"," /usr/local/x-ui/bin/xui_singbox.json
      echo "vless://$uuid@$cdnargo:8880?type=ws&security=none&path=$ws_path&host=$argoym#vl-argo临时-8880" >>/usr/local/x-ui/bin/ty.txt
      echo "vless://$uuid@$cdnargo:8443?type=ws&security=tls&path=$ws_path&host=$argoym#vl-tls-argo临时-8443" >>/usr/local/x-ui/bin/ty.txt

    elif [[ $argoprotocol = vmess ]]; then
      #vmess-ws-tls-argo固定
      cat >/usr/local/x-ui/bin/sbvmtargoym.log <<EOF

{
            "server": "$cdnargo",
            "server_port": 8443,
            "tag": "vm-tls-argo固定-8443",
            "tls": {
                "enabled": true,
                "server_name": "$argoym",
                "insecure": false,
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            },
            "packet_encoding": "packetaddr",
            "transport": {
                "headers": {
                    "Host": [
                        "$argoym"
                    ]
                },
                "path": "$ws_path",
                "type": "ws"
            },
            "type": "vmess",
            "security": "auto",
            "uuid": "$uuid"
        },
EOF

      cat >/usr/local/x-ui/bin/clvmtargoym.log <<EOF

- name: vm-tls-argo固定-8443                        
  type: vmess
  server: $cdnargo                        
  port: 8443                                     
  uuid: $uuid       
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  network: ws
  servername: $argoym                    
  ws-opts:
    path: "$ws_path"                             
    headers:
      Host: $argoym

EOF

      #vmess-ws-argo固定
      cat >/usr/local/x-ui/bin/sbvmargoym.log <<EOF

{
            "server": "$cdnargo",
            "server_port": 8880,
            "tag": "vm-argo固定-8880",
            "tls": {
                "enabled": false,
                "server_name": "$argoym",
                "insecure": false,
                "utls": {
                    "enabled": true,
                    "fingerprint": "chrome"
                }
            },
            "packet_encoding": "packetaddr",
            "transport": {
                "headers": {
                    "Host": [
                        "$argoym"
                    ]
                },
                "path": "$ws_path",
                "type": "ws"
            },
            "type": "vmess",
            "security": "auto",
            "uuid": "$uuid"
        },
EOF

      cat >/usr/local/x-ui/bin/clvmargoym.log <<EOF

- name: vm-argo固定-8880                         
  type: vmess
  server: $cdnargo                       
  port: 8880                                     
  uuid: $uuid       
  alterId: 0
  cipher: auto
  udp: true
  tls: false
  network: ws
  servername: $argoym                    
  ws-opts:
    path: "$ws_path"                             
    headers:
      Host: $argoym

EOF
      sed -i "/#_0/r /usr/local/x-ui/bin/clvmtargoym.log" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_1/ i\\    - vm-tls-argo固定-8443" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_2/ i\\    - vm-tls-argo固定-8443" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_3/ i\\    - vm-tls-argo固定-8443" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_0/r /usr/local/x-ui/bin/clvmargoym.log" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_1/ i\\    - vm-argo固定-8880" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_2/ i\\    - vm-argo固定-8880" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/#_3/ i\\    - vm-argo固定-8880" /usr/local/x-ui/bin/xui_clashmeta.yaml
      sed -i "/\/\/_0/r /usr/local/x-ui/bin/sbvmtargoym.log" /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_1/ i\\ \"vm-tls-argo固定-8443\"," /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_2/ i\\ \"vm-tls-argo固定-8443\"," /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_0/r /usr/local/x-ui/bin/sbvmargoym.log" /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_1/ i\\ \"vm-argo固定-8880\"," /usr/local/x-ui/bin/xui_singbox.json
      sed -i "/\/\/_2/ i\\ \"vm-argo固定-8880\"," /usr/local/x-ui/bin/xui_singbox.json
      echo -e "vmess://$(echo '{"add":"'$cdnargo'","aid":"0","host":"'$argoym'","id":"'$uuid'","net":"ws","path":"'$ws_path'","port":"8880","ps":"vm-argo固定-8880","v":"2"}' | base64 -w 0)" >>/usr/local/x-ui/bin/ty.txt
      echo -e "vmess://$(echo '{"add":"'$cdnargo'","aid":"0","host":"'$argoym'","id":"'$uuid'","net":"ws","path":"'$ws_path'","port":"8443","ps":"vm-tls-argo固定-8443","tls":"tls","sni":"'$argoym'","type":"none","v":"2"}' | base64 -w 0)" >>/usr/local/x-ui/bin/ty.txt
    fi
  fi
  line=$(grep -B1 "//_1" /usr/local/x-ui/bin/xui_singbox.json | grep -v "//_1")
  new_line=$(echo "$line" | sed 's/,//g')
  sed -i "/^$line$/s/.*/$new_line/g" /usr/local/x-ui/bin/xui_singbox.json
  sed -i '/\/\/_0\|\/\/_1\|\/\/_2/d' /usr/local/x-ui/bin/xui_singbox.json
  sed -i '/#_0\|#_1\|#_2\|#_3/d' /usr/local/x-ui/bin/xui_clashmeta.yaml
  find /usr/local/x-ui/bin -type f -name "*.log" -delete
  url=$(cat /usr/local/x-ui/bin/ty.txt 2>/dev/null)
  baseurl=$(echo -e "$url" | base64 -w 0)
  echo "$baseurl" >/usr/local/x-ui/bin/xui_ty.txt
}

show_menu() {
  clear
  white "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

  white "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  white "Github  ：github.com/"
  white "Blogger：ygkkk.blogspot.com"
  white "YouTube ：www.youtube.com/@"
  white "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  white "x-ui-yg script shortcut: x-ui"
  red "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  green " 1. Instalación de x-ui con un clic"
  green " 2. Eliminar/desinstalar x-ui"
  echo "----------------------------------------------------------------------------------"
  green " 3. Otras configuraciones 【Doble túnel Argo, IP preferente de suscripción, enlace de suscripción Gitlab】"
  green " 4. Cambiar la configuración del panel x-ui 【Usuario y contraseña, puerto de acceso, restaurar panel】"
  green " 5. Apagar, reiniciar x-ui"
  green " 6. Actualizar el script de x-ui"
  echo "----------------------------------------------------------------------------------"
  green " 7. Actualizar y ver configuración y enlaces de suscripción de nodos comunes, clientes clash-meta y sing-box"
  green " 8. Ver el registro de ejecución de x-ui"
  green " 9. Aceleración con BBR+FQ de un clic"
  green "10. Administrar certificados de dominio con Acme"
  green "11. Administrar Warp, ver estado de desbloqueo de Netflix y ChatGPT localmente, obtener configuración de cuenta warp-wireguard ilimitada"
  green "12. Refrescar visualización de parámetros del menú principal actual"
  green " 0. Salir del script"
  red "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  insV=$(cat /usr/local/x-ui/v 2>/dev/null)
  #latestV=$(curl -s https://gitlab.com/rwkgyg/x-ui-yg/-/raw/main/version/version | awk -F "Actualizar contenido" '{print $1}' | head -n 1)
  latestV=$(curl -sL https://raw.githubusercontent.com/yonggekkk/x-ui-yg/main/version | awk -F "Actualizar contenido" '{print $1}' | head -n 1)
  if [[ -f /usr/local/x-ui/v ]]; then
    if [ "$insV" = "$latestV" ]; then
      echo -e "Versión actual del script x-ui-yg más reciente: ${bblue}${insV}${plain} (ya instalada)"
    else
      echo -e "Número de versión actual del script x-ui-yg: ${bblue}${insV}${plain}"
      echo -e "Se detectó la versión más reciente del script x-ui-yg: ${yellow}${latestV}${plain} (puedes elegir 6 para actualizar)"
      echo -e "${yellow}$(curl -sL https://raw.githubusercontent.com/yonggekkk/x-ui-yg/main/version)${plain}"
    #echo -e "${yellow}$(curl -sL https://gitlab.com/rwkgyg/x-ui-yg/-/raw/main/version/version)${plain}"
    fi
  else
    echo -e "Número de versión actual del script x-ui-yg: ${bblue}${latestV}${plain}"
    echo -e "Por favor, selecciona primero 1 para instalar el script x-ui-yg"
  fi
  red "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "El estado de VPS es el siguiente："
  echo -e "Sistema: $blue$op$plain  \c"
  echo -e "Núcleo: $blue$version$plain  \c"
  echo -e "Procesador: $blue$cpu$plain  \c"
  echo -e "Virtualización: $blue$vi$plain  \c"
  echo -e "Algoritmo BBR: $blue$bbr$plain"
  v4v6
  if [[ "$v6" == "2a09"* ]]; then
    w6="【WARP】"
  fi
  if [[ "$v4" == "104.28"* ]]; then
    w4="【WARP】"
  fi
  if [[ -z $v4 ]]; then
    ps_ipv4='Sin IPV4'
    vps_ipv6="$v6"
  elif [[ -n $v4 && -n $v6 ]]; then
    vps_ipv4="$v4"
    vps_ipv6="$v6"
  else
    vps_ipv4="$v4"
    vps_ipv6='Sin IPV6'
  fi
  echo -e "Dirección IPV4 local: $blue$vps_ipv4$w4$plain   Dirección IPV6 local: $blue$vps_ipv6$w6$plain"
  echo "------------------------------------------------------------------------------------"
  argopid
  if [[ -n $(ps -e | grep -w $ym 2>/dev/null) || -n $(ps -e | grep -w $ls 2>/dev/null) ]]; then
    if [[ -f /usr/local/x-ui/xuiargoport.log ]]; then
      argoprotocol=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .protocol' /usr/local/x-ui/bin/config.json)
      echo -e "Estado del túnel temporal Argo: $blue Iniciado 【Escuchando en el puerto $yellow${argoprotocol}-ws$plain$blue】$plain"
      argotro=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .settings.clients[0].password' /usr/local/x-ui/bin/config.json)
      argoss=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .settings.password' /usr/local/x-ui/bin/config.json)
      argouuid=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .settings.clients[0].id' /usr/local/x-ui/bin/config.json)
      argopath=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .streamSettings.wsSettings.path' /usr/local/x-ui/bin/config.json)
      if [[ ! $argouuid = "null" ]]; then
        argoma=$argouuid
      elif [[ ! $argoss = "null" ]]; then
        argoma=$argoss
      else
        argoma=$argotro
      fi
      argotls=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .streamSettings.security' /usr/local/x-ui/bin/config.json)
      if [[ -n $argouuid ]]; then
        if [[ "$argotls" = "tls" ]]; then
          echo -e "Retroalimentación de error: $red El nodo ws creado por el panel tiene TLS activado, lo que no es compatible con Argo. Por favor, desactiva TLS en el nodo correspondiente del panel.$plain"
        else
          echo -e "Contraseña/UUID de Argo: $blue$argoma$plain"
          echo -e "Ruta de Argo: $blue$argopath$plain"
          argolsym=$(cat /usr/local/x-ui/argo.log 2>/dev/null | grep -a trycloudflare.com | awk 'NR==2{print}' | awk -F// '{print $2}' | awk '{print $1}')
          [[ $(echo "$argolsym" | grep -w "api.trycloudflare.com/tunnel") ]] && argolsyms='Generación fallida, por favor reinicia' || argolsyms=$argolsym
          echo -e "Nombre de dominio temporal de Argo: $blue$argolsyms$plain"
        fi
      else
        echo -e "Retroalimentación de error: $red El panel aún no ha creado un nodo ws en el puerto $yellow$(cat /usr/local/x-ui/xuiargoport.log 2>/dev/null)$plain$red, se recomienda vmess-ws$plain$plain"
      fi
    fi

    if [[ -f /usr/local/x-ui/xuiargoymport.log && -f /usr/local/x-ui/xuiargoport.log ]]; then
      echo "--------------------------"
    fi

    if [[ -f /usr/local/x-ui/xuiargoymport.log ]]; then
      argoprotocol=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoymport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .protocol' /usr/local/x-ui/bin/config.json)
      echo -e "Estado del túnel fijo de Argo: $blue Iniciado 【Escuchando el puerto $yellow${argoprotocol}-ws$plain$blue del nodo:$plain$yellow$(cat /usr/local/x-ui/xuiargoymport.log 2>/dev/null)$plain$blue】$plain$plain"
      argotro=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoymport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .settings.clients[0].password' /usr/local/x-ui/bin/config.json)
      argoss=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoymport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .settings.password' /usr/local/x-ui/bin/config.json)
      argouuid=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoymport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .settings.clients[0].id' /usr/local/x-ui/bin/config.json)
      argopath=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoymport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .streamSettings.wsSettings.path' /usr/local/x-ui/bin/config.json)

      if [[ ! $argouuid = "null" ]]; then
        argoma=$argouuid
      elif [[ ! $argoss = "null" ]]; then
        argoma=$argoss
      else
        argoma=$argotro
      fi

      argotls=$(jq -r --arg port "$(cat /usr/local/x-ui/xuiargoymport.log 2>/dev/null)" '.inbounds[] | select(.port == ($port | tonumber)) | .streamSettings.security' /usr/local/x-ui/bin/config.json)

      if [[ -n $argouuid ]]; then
        if [[ "$argotls" = "tls" ]]; then
          echo -e "Retroalimentación de error: $red El nodo ws creado por el panel tiene TLS activado, lo que no es compatible con Argo. Por favor, desactiva TLS en el nodo correspondiente del panel.$plain"
        else
          echo -e "Contraseña/UUID de Argo: $blue$argoma$plain"
          echo -e "Ruta de Argo: $blue$argopath$plain"
          echo -e "Nombre de dominio fijo de Argo: $blue$(cat /usr/local/x-ui/xuiargoym.log 2>/dev/null)$plain"
        fi
      else
        echo -e "Retroalimentación de error: $red El panel aún no ha creado un nodo ws en el puerto $yellow$(cat /usr/local/x-ui/xuiargoymport.log 2>/dev/null)$plain$red, se recomienda vmess-ws$plain$plain"
      fi
    fi
  else
    echo -e "Estado de Argo: $blue No iniciado $plain"
  fi
  echo "------------------------------------------------------------------------------------"
  show_status
  echo "------------------------------------------------------------------------------------"
  acp=$(/usr/local/x-ui/x-ui setting -show 2>/dev/null)
  if [[ -n $acp ]]; then
    if [[ $acp == *admin* ]]; then
      red "Error en x-ui, por favor restablece el nombre de usuario o desinstala y reinstala x-ui"
    else
      xpath=$(echo $acp | awk '{print $8}')
      xport=$(echo $acp | awk '{print $6}')
      xip1=$(cat /usr/local/x-ui/xip 2>/dev/null | sed -n 1p)
      xip2=$(cat /usr/local/x-ui/xip 2>/dev/null | sed -n 2p)
      if [ "$xpath" == "/" ]; then
        path="$sred【Advertencia de seguridad grave: por favor, ve a la configuración del panel y añade la ruta raíz de URL】$plain"
      fi
      echo -e "La información de inicio de sesión de x-ui es la siguiente:"
      echo -e "$blue$acp$path$plain"
      if [[ -n $xip2 ]]; then
        xuimb="http://${xip1}:${xport}${xpath} o http://${xip2}:${xport}${xpath}"
      else
        xuimb="http://${xip1}:${xport}${xpath}"
      fi
      echo -e "$blue Dirección de inicio de sesión IP predeterminada (no segura): $xuimb$plain"
      if [[ -f /root/ygkkkca/ca.log ]]; then
        echo -e "$blue Dirección de inicio de sesión de dominio de ruta (segura): https://$(cat /root/ygkkkca/ca.log 2>/dev/null):${xport}${xpath}$plain"
      fi
    fi
  else
    echo -e "La información de inicio de sesión de x-ui es la siguiente:"
    echo -e "$red No se ha instalado x-ui, no hay información para mostrar $plain"
  fi
  red "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo
  readp "Por favor, introduce un número:" Input
  case "$Input" in
  1) check_uninstall && xuiinstall ;;
  2) check_install && uninstall ;;
  3) check_install && changeserv ;;
  4) check_install && xuichange ;;
  5) check_install && xuirestop ;;
  6) check_install && update ;;
  7) check_install && sharesub ;;
  8) check_install && show_log ;;
  9) bbr ;;
  10) acme ;;
  11) cfwarp ;;
  12) show_menu ;;
  *) exit ;;
  esac
}
show_menu
