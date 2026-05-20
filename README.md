# Bridge Connection

My Nic's are :

- enp58s0 (Ethernet)
- wlo1 (Wirless)

So I decided to use the ethernet device, and with that create my bridge 
for my vm's, because I want that my Vms have ip's and My vm's were like
own pc in the network.

My infrestructure was:

```bash

router <-> interface (Ethernet)

```

But I want this:

```bash

router <-> interface (Ethernet) <-> bridge ->  Host and VM'S
```

Why?, Well as I know when I create a bridge is like create a virtual switch,
so that means that my interface will be the "real" connection to the internet,
because the interface will be like a port of my bridge.

**And I remove the old configuration:**

```bash
sudo nmcli connection delete "Wired connection 1"
```

**Create a new bridge slave:** This ethernet act like a port in my virtual switch + the logic of the interface, 
that's why I can use that my device also.
```bash
sudo nmcli connection add type bridge-slave ifname enp58s0 master br0

nmcli device status

DEVICE        TYPE      STATE                   CONNECTION
enp58s0       ethernet  connected               bridge-slave-enp58s0
br0           bridge    connected (externally)  br0
lo            loopback  connected (externally)  lo
virbr0        bridge    connected (externally)  virbr0
wlo1          wifi      disconnected            --
p2p-dev-wlo1  wifi-p2p  disconnected            --
```

And we need to check the "device" and virtual devices that are connected in or "virtual-switch":

```bash
bridge link

> 2: enp58s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 master br0 state forwarding priority 32 cost 100
```

If I want to revert this process: 
```bash
sudo nmcli connection delete bridge-slave-enp58s0
sudo nmcli connection delete br0
sudo nmcli connection add type ethernet ifname enp58s0 con-name "Wired connection 1"
sudo nmcli connection modify "Wired connection 1" connection.autoconnect yes
sudo nmcli connection up "Wired connection 1"
```
