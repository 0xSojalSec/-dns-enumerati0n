#!/bin/bash

RED='\033[0;31m'
NC='\033[0m'
DARK_GRAY='\033[\1;30m'
LIGHT_RED='\033[1;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
WHITE='\033[0;37m'
CYAN='\033[0;36m'
  
  
  /  _ \/ \  /|/ ___\      /  __// \  /|/ \ /\/ \__/|/  __//  __\/  _ \/__ __\/ \/  _ \/ \  /|
  _____ | | \|| |\ |||    \_____ |  \  | |\ ||| | ||| |\/|||  \  |  \/|| / \|  / \  | || / \|| |\ ||
  \____\| |_/|| | \||\___ |\____\|  /_ | | \||| \_/|| |  |||  /_ |    /| |-||  | |  | || \_/|| | \||
        \____/\_/  \|\____/      \____\\_/  \|\____/\_/  \|\____\\_/\_\\_/ \|  \_/  \_/\____/\_/  \|

echo -en "Enter the ip address: " 
read ip
echo -en "Enter the Domain name: " 
read domain_name
echo -e "\n\n"

printf "${CYAN}================================================================== Find email servers ====================================================================================="
echo -e ""
printf "\t${PURPLE}# host -t mx ${ip}${NC}"
echo -e ""
host -t mx $ip
echo -e "\n\n"

printf "${CYAN}================================================================== Zone transfer request ====================================================================================="
echo ""
printf "\t${PURPLE}# host -l $ip ns1.${ip}${NC}"
echo -e ""
host -l $ip ns1.$ip
echo -e "\n\n"

printf "\t${PURPLE}# host -l $ip ns2.${ip}${NC}"
echo -e ""
host -l $ip ns2.$ip
echo -e "\n\n"

for server in $(host -t ns $domain_name | cut -d " " -f4); do
host -l $domain_name $server |grep "has address"
done

printf "${CYAN}================================================================== DNS enumeration scripts ====================================================================================="
echo -e ""
printf "\t${PURPLE}# dnsrecon -d $ip -t axfr${NC}"
echo -e ""
dnsrecon -d $ip -t axfr
echo -e "\n\n"

printf "${CYAN}=============================================================== Finds nameservers for a given domain ================================================================================="
echo -e ""
printf "\t${PURPLE}# host -t ns $ip| cut -d " " -f 4${NC}"
echo -e ""
host -t ns $ip| cut -d " " -f 4host -t mx $ip
echo -e "\n\n"
printf "\t${PURPLE}# dnsenum $ip${NC}"
echo -e ""
dnsenum $ip
echo -e "\n\n"

printf "${CYAN}================================================================== Nmap zone transfer scan ====================================================================================="
echo -e ""
printf "\t${PURPLE}# nmap $ip --script=dns-zone-transfer -p 53${NC}"
echo -e ""
nmap $ip --script=dns-zone-transfer -p 53
echo -e "\n\n"

printf "${CYAN}================================================================== Finds miss configure DNS entries ====================================================================================="
echo -e ""
printf "\t${PURPLE}# host -t ns $ip${NC}"
echo -e ""
host -t ns $ip
echo -e "\n\n"

printf "${CYAN}=============================================================== Subdomain bruteforcing using common hostnames =================================================================================="
echo -e ""
printf "\t${PURPLE}# for ip in $(cat list.txt); do host $ip.website.com; done${NC}"
echo -e ""
for ip in $(cat list.txt); do host $ip.website.com; done
echo -e "\n\n"

printf "${CYAN}================================================================== Reverse dns lookup bruteforcing ====================================================================================="
echo -e ""
printf "\t${PURPLE}# for ip in $(seq 155 190);do host 50.7.67.$ip;done |grep -v "not found"${NC}"
echo -e ""
for ip in $(seq 155 190);do host 50.7.67.$ip;done |grep -v "not found"
echo -e "\n\n"
