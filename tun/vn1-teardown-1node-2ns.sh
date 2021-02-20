#!/bin/bash

. env.sh

echo "Deleting the namespaces"
ip netns list | grep $CON1
if [ $? -eq 0 ]; then
    sudo ip netns delete $CON1
fi
ip netns list | grep $CON2
if [ $? -eq 0 ]; then
    sudo ip netns delete $CON2
fi

echo "Deleting the bridge"
sudo ip link delete br0

echo "Deleting the veths"
sudo ip link del veth10
sudo ip link del veth20

#echo "Stoping the UDP tunnel"
#sudo pkill socat

echo "Deleting route rules"
sudo ip route del 172.16.0.0/16
sudo ip route del 172.16.0.0/24
sudo ip route del 172.16.1.0/24
sudo ip route del 172.16.2.0/24
sudo ip route del 192.168.0.0/16
sudo ip route del 169.254.0.0/16
sudo ip route del 169.254.0.0/16

