# aug/13/2018 00:23:28 by RouterOS 6.42.3
# software id = 0E2B-BCRK
#
# model = RouterBOARD cAP Gi-5acD2nD
# serial number = 81CF08B56E88
/interface bridge
add admin-mac=CC:2D:E0:95:75:23 auto-mac=no comment=defconf name=bridgeLocal
/interface wireless
# managed by CAPsMAN
# channel: 2412/20-Ce/gn(28dBm), SSID: DENTALGUEST, CAPsMAN forwarding
set [ find default-name=wlan1 ] ssid=MikroTik
# managed by CAPsMAN
# channel: 5190/20-Ce/ac(28dBm), SSID: DRDNET, CAPsMAN forwarding
set [ find default-name=wlan2 ] ssid=MikroTik
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/interface bridge port
add bridge=bridgeLocal comment=defconf interface=ether1
add bridge=bridgeLocal comment=defconf interface=ether2
/interface wireless cap
# 
set bridge=bridgeLocal discovery-interfaces=bridgeLocal enabled=yes \
    interfaces=wlan2,wlan1
/ip dhcp-client
add comment=defconf dhcp-options=hostname,clientid disabled=no interface=\
    bridgeLocal
#error exporting /ip ssh
#interrupted
