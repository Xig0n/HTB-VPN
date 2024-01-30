#!/bin/bash


## GLOBBAL VARIABLES
declare -r vpn_sp=""   # Starting-Point PATH 
declare -r vpn_ma=""   # Machines PATH

declare -r interface_sp="tun10"
declare -r interface_ma="tun11"

scriptName=$0

# COLOURS
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"




## CHECK  ROOT
if [ $(id -u) != 0 ]; then
    echo -e "\n${redColour}[!]${endColour} This program requires root privileges\n"
    exit 3
fi


## BANER
banner () {

  echo -e "\033c ${turquoiseColour}  
    __  ____________      _    ______  _   __
   / / / /_  __/ __ )    | |  / / __ \/ | / /
  / /_/ / / / / __  |____| | / / /_/ /  |/ / 
 / __  / / / / /_/ /_____/ |/ / ____/ /|  /  
/_/ /_/ /_/ /_____/      |___/_/   /_/ |_/   ${endColour} ${purpleColour}Developed by Xig0n${endColour}\n\n"
  sleep 0.5
}


checkOpenvpn () {
  if [ -z "$(openvpn --version 2>/dev/null)" ]; then
    echo -e "\n${redColour}[!]${endColour}${grayColour} Openvpn is not installed\n${endColour}"
    sleep 2
    echo -e "\n${blueColour}[*]${endColour} ${purpleColour}Installing openvpn...${endColour}\n"
    sleep 1
    apt update -y && apt install openvpn -y 
    echo -e "\033c"
    banner
    helpPanel 0
  fi
}

firstUse () {
  if [[ -z $vpn_ma || -z $vpn_sp ]]; then
    echo -e "\n${redColour}[!]${endColour} ${grayColour}Complete de vars path\n${endColour}"
    exit 10
  else
    sed -i "s/dev tun$/dev $interface_ma/1" $vpn_ma
    sed -i "s/dev tun$/dev $interface_sp/1" $vpn_sp
  fi
}

helpPanel () {
  echo -e "\nUsage: ${redColour}$scriptName${endColour} ${turquoiseColour}{Options}${endColour}"
  echo -e "\t${blueColour}-m ${endColour} : Start VPN connexion to LAB"
  echo -e "\t${blueColour}-s ${endColour} : Start VPN connexion to Starting Point"
  echo -e "\t${blueColour}-k ${endColour} : Kill all VPN process" 
  echo -e "\t${blueColour}-h ${endColour} : Display this help and exit\n"
  exit $1
}

# VPN Machine
startOpenvpn () {
    echo -e "\n${yellowColour}[*]${endColour} Runing machine VPN"
    openvpn $1 >/dev/null &
    while [[ -z "$(ip address show $2 2>/dev/null | grep -E "inet [0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}" -o 2>/dev/null | cut -d " " -f 2 2>/dev/null)" ]]; do
      sleep 0.5
    done
    echo -e "\t${blueColour}[*]${blueColour} PID: $!"
    echo -e "\t${blueColour}[*]${blueColour}${purpleColour} IP: ${interface}${endColour} $(ip address show $2 | grep -E "inet [0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}" -o | cut -d " " -f 2)"
}

## Kill openvpn process
killOpenvpn () {
  echo -e "\n${yellowColour}[*]${endColour} Killing VPN process\n"
  killall openvpn >/dev/null 2>&1
  if [ $? == 1 ]; then
    echo -e "\t${redColour}[!]${endColour} There are no active process\n"
    exit 5
  fi
}


checkOpenvpn
firstUse
if [[ -z $1 ]]; then  
  banner
  helpPanel
fi
while getopts "mskh" arg; do
  case $arg in
    m) banner; startOpenvpn $vpn_ma $interface_ma;;
    s) banner; startOpenvpn $vpn_sp $interface_sp;;
    k) killOpenvpn;;
    h) helpPanel 0;;
    \?) helpPanel 1;;
  esac
done
