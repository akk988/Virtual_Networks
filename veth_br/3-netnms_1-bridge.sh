#!/bin/bash -e

. env.sh

echo "Creating three namespaces"
sudo ip netns add $CON1
sudo ip netns add $CON2
sudo ip netns add $CON3

echo "Creating the veth pairs"
sudo ip link add veth10 type veth peer name veth11
sudo ip link add veth20 type veth peer name veth21

echo "Adding the veth pairs to the namespaces"
sudo ip link set veth11 netns $CON1
sudo ip link set veth21 netns $CON2
sudo ip link set veth10 netns $CON3
sudo ip link set veth20 netns $CON3

echo "Configuring the interfaces in the network namespaces with IP address"
sudo ip netns exec $CON1 ip addr add $IP1/24 dev veth11 
sudo ip netns exec $CON2 ip addr add $IP2/24 dev veth21
sudo ip netns exec $CON3 ip addr add $IP31/24 dev veth10 
sudo ip netns exec $CON3 ip addr add $IP32/24 dev veth20  

echo "Enabling the interfaces inside the network namespaces"
sudo ip netns exec $CON1 ip link set dev veth11 up
sudo ip netns exec $CON2 ip link set dev veth21 up

echo "Creating the bridge"
sudo ip netns exec $CON3 ip link add name br0 type bridge

echo "Adding the network namespaces interfaces to the bridge"
sudo ip netns exec $CON3 ip link set dev veth10 master br0
sudo ip netns exec $CON3 ip link set dev veth20 master br0

echo "Assigning the IP address to the bridge"
sudo ip netns exec $CON3 ip addr add $BRIDGE_IP/24 dev br0

echo "Enabling the bridge"
sudo ip netns exec $CON3 ip link set dev br0 up

echo "Enabling the interfaces connected to the bridge"
sudo ip netns exec $CON3 ip link set dev veth10 up
sudo ip netns exec $CON3 ip link set dev veth20 up

echo "Setting the loopback interfaces in the network namespaces"
sudo ip netns exec $CON1 ip link set lo up
sudo ip netns exec $CON2 ip link set lo up
sudo ip netns exec $CON3 ip link set lo up

# The next three lines were commented because a default route was automaticlly added to the netns, 
# in addition there was an error when adding a route rule via the ip of the bridge!
echo "Setting the default route in the network namespaces"
sudo ip netns exec $CON1 ip route add default via $BRIDGE_IP/24 dev veth11
sudo ip netns exec $CON2 ip route add default via $BRIDGE_IP/24 dev veth21

