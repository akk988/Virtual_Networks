# Virtual_Networks
In virtual networking there are different interdaces, such as bridges, virtual LAN, virtual extensible LAN and netdevsim. We'll create an exmple of each one to explore their behaviour
There are many other interdaces for virtual networking, such as MACVLAN, IPVLAN, MACVTAP, Media Access Control Security, virtual Ethernet, Virtual CAN, Virtual CAN tunnel, IP-over-InfiniBand, NetLink MONitor, Dummy interface, Intermediate Function Block and netdevsim. We'll create an exmple of each one to explore their behaviour in simple examples.

# VETH
The first network interface to be used in this repository is the virtual ethernet. It allows two network namespaces to communicate in the same L2 network over a bridge. We'll need a host, two network namespaces and a bridge.
