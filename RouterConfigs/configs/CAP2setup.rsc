# aug/13/2018 00:22:20 by RouterOS 6.42.3
# software id = WSTM-7KIY
#
# model = RouterBOARD cAP Gi-5acD2nD
# serial number = 81CF08659D7E
/interface bridge
add fast-forward=no name="CAP2 Bridge" protocol-mode=none
/interface wireless
# managed by CAPsMAN
# channel: 2462/20-eC/gn(28dBm), SSID: DRDNET, CAPsMAN forwarding
set [ find default-name=wlan1 ] mode=ap-bridge ssid=MikroTik
# managed by CAPsMAN
# channel: 5240/20-eeeC/ac(28dBm), SSID: DRDNET, CAPsMAN forwarding
set [ find default-name=wlan2 ] mode=ap-bridge ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge="CAP2 Bridge" interface=ether1
add bridge="CAP2 Bridge" interface=ether2
/interface wireless cap
# 
set discovery-interfaces=ether1 enabled=yes interfaces=wlan1,wlan2
/ip dhcp-client
add dhcp-options=hostname,clientid disabled=no interface="CAP2 Bridge"
/system clock
set time-zone-name=America/Los_Angeles
/system identity
set name="CAP2 Panx"
/system routerboard settings
set silent-boot=no
