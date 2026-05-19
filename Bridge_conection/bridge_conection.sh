#!/usr/bin/zsh


#for iface in /sys/class/net/*; do
#    if [ -d "$iface/device" ]; then
#			interface= basename "$iface"
#			type=$(cat $iface/$interface/type)
#			nics+=($interface)
#    fi
#done

echo -e "\n[..] Creando el bridge 'br0' con la interfaz ethernet"

if [ ! -d "/sys/class/net/br0" ]; then

	ipaddrcird=$(ip addr show enp58s0 | grep -E "inet " | awk '{print($2)}')
	ipaddr=$(ip addr show enp58s0 | grep -E "inet " | awk '{print($2)}' | sed 's/\/24/ /')
	iproute=$(ip route | grep "via" | awk '{print($3)}')

	ip link add name br0 type bridge
	ip link set dev br0 up
	ip address add $ipaddrcird dev br0
	ip route append default via $iproute dev br0

	ip link set enp58s0 master br0
	ip addr del $ipaddrcird dev enp58s0
else
	echo -e "\n[*] It already exists, Here are the devices connected\n"
	bridge link
fi
