#!/usr/bin/zsh
interfaces_nics=()

for iface in /sys/class/net/*; do
	if [ -d "$iface/device" ]; then
		interface=$(basename "$iface")
		interfaces_nics+=("$interface")
	fi
done

echo -en "\n[*] Physical Interfaces: "

echo "[ $interfaces_nics ]"
