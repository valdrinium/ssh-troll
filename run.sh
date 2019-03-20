#!/bin/bash

echo -n "What is the ssh username? "
read ssh_user
echo -n "What is the ssh password? "
read ssh_pass

readonly IP_CACHE_FILE=.ips
if [ ! -f $IP_CACHE_FILE ]
then
    echo -n "What is the network ip? "
    read network_ip

    nmap_ips=$(nmap -sn $network_ip 2>/dev/null | grep report | awk -F '(' '{print $2}' | awk -F ')' '{print $1}' | grep -v '^$')

    echo "$nmap_ips" >> $IP_CACHE_FILE
else
    nmap_ips=$(cat $IP_CACHE_FILE)
fi

readarray -t ip_array <<< "$nmap_ips"

declare -a ip_host_mapping
for ip in "${ip_array[@]}"
do
    hostname=$(timeout 2s sshpass -p "$ssh_pass" ssh -o StrictHostKeyChecking=no $ssh_user@$ip hostname)
    if [ -n "$hostname" ]
    then
        ip_host_mapping=("${ip_host_mapping[@]}" "$ip -> $hostname")
    fi
done

echo -e "\nWe have found the following ${#ip_host_mapping[@]} entries: "
for entry in "${ip_host_mapping[@]}"
do
    echo -e "$entry"

    ip=$(echo -e "$entry" | awk -F ' -> ' '{print $1}')
    ./run.exp $ip "$ssh_user" "$ssh_pass" 1>/dev/null &
done
