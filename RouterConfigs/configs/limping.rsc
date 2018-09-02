# aug/12/2018 18:10:54 by RouterOS 6.42.3
# software id = T8QK-05HB
#
# model = CRS226-24G-2S+
# serial number = 61C8054F0C95
/caps-man channel
add band=2ghz-b/g/n control-channel-width=20mhz frequency=2412 name=channel1
add band=2ghz-b/g/n control-channel-width=20mhz frequency=2472 name=channel11
add band=2ghz-b/g/n control-channel-width=20mhz frequency=2442 name=channel6
/interface bridge
add fast-forward=no name=CAPSTALK
add admin-mac=E4:8D:8C:A8:34:25 auto-mac=no comment=\
    "created from master port" name=bridge1 protocol-mode=none
/interface ethernet
set [ find default-name=ether1 ] name=ether1-master-local
set [ find default-name=ether2 ] name=ether2-master-local
set [ find default-name=ether3 ] name=ether3-slave-local
set [ find default-name=ether4 ] name=ether4-slave-local
set [ find default-name=ether5 ] name=ether5-slave-local
set [ find default-name=ether6 ] name=ether6-slave-local
set [ find default-name=ether7 ] name=ether7-slave-local
set [ find default-name=ether8 ] name=ether8-slave-local
set [ find default-name=ether9 ] name=ether9-slave-local
set [ find default-name=ether10 ] name=ether10-slave-local
set [ find default-name=ether11 ] name=ether11-slave-local
set [ find default-name=ether12 ] name=ether12-slave-local
set [ find default-name=ether13 ] name=ether13-slave-local
set [ find default-name=ether14 ] name=ether14-slave-local
set [ find default-name=ether15 ] name=ether15-slave-local
set [ find default-name=ether16 ] name=ether16-slave-local
set [ find default-name=ether17 ] name=ether17-slave-local
set [ find default-name=ether18 ] name=ether18-slave-local
set [ find default-name=ether19 ] name=ether19-slave-local
set [ find default-name=ether20 ] name=ether20-slave-local
set [ find default-name=ether21 ] name=ether21-slave-local
set [ find default-name=ether22 ] name=ether22-slave-local
set [ find default-name=ether23 ] name=ether23-slave-local
set [ find default-name=ether24 ] name=ether24-slave-local
set [ find default-name=sfp-sfpplus1 ] name=sfp-sfpplus1-slave-local
set [ find default-name=sfpplus2 ] name=sfpplus2-slave-local
/caps-man datapath
add bridge=CAPSTALK name=datapath1
/caps-man security
add authentication-types=wpa2-psk,wpa2-eap encryption="" name=\
    DRDNETSecurity01 passphrase=brightsmile88
/caps-man interface
add disabled=no mac-address=00:00:00:00:00:00 master-interface=none name=\
    DRDCAPSERVER radio-mac=00:00:00:00:00:00 security=DRDNETSecurity01
/interface list
add exclude=dynamic name=discover
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip ipsec proposal
set [ find default=yes ] enc-algorithms=aes-128-cbc
/ip pool
add name=dhcp ranges=192.168.88.100-192.168.88.200
add name=dhcp_pool1 ranges=192.168.88.2-192.168.88.254
/ip dhcp-server
add add-arp=yes address-pool=dhcp interface=bridge1 lease-time=2h name=\
    server1
/snmp community
set [ find default=yes ] addresses=0.0.0.0/0
/caps-man manager
set ca-certificate=CAPsMAN-CA-E48D8CA83424 certificate=\
    CAPsMAN-CA-E48D8CA83424 enabled=yes
/interface bridge port
add bridge=bridge1 interface=ether3-slave-local
add bridge=bridge1 interface=ether4-slave-local
add bridge=bridge1 interface=ether5-slave-local
add bridge=bridge1 interface=ether6-slave-local
add bridge=bridge1 interface=ether7-slave-local
add bridge=bridge1 interface=ether8-slave-local
add bridge=bridge1 interface=ether9-slave-local
add bridge=bridge1 interface=ether10-slave-local
add bridge=bridge1 interface=ether11-slave-local
add bridge=bridge1 interface=ether12-slave-local
add bridge=bridge1 interface=ether13-slave-local
add bridge=bridge1 interface=ether14-slave-local
add bridge=bridge1 interface=ether15-slave-local
add bridge=bridge1 interface=ether16-slave-local
add bridge=bridge1 interface=ether17-slave-local
add bridge=bridge1 interface=ether18-slave-local
add bridge=bridge1 interface=ether19-slave-local
add bridge=bridge1 interface=ether20-slave-local
add bridge=bridge1 interface=ether21-slave-local
add bridge=bridge1 interface=ether22-slave-local
add bridge=bridge1 interface=ether23-slave-local
add bridge=bridge1 interface=ether24-slave-local
add bridge=bridge1 interface=sfp-sfpplus1-slave-local
add bridge=bridge1 interface=sfpplus2-slave-local
add bridge=bridge1 interface=ether2-master-local
add interface=ether1-master-local
/ip neighbor discovery-settings
set discover-interface-list=discover
/interface list member
add interface=bridge1 list=discover
add interface=ether3-slave-local list=discover
add interface=ether4-slave-local list=discover
add interface=ether5-slave-local list=discover
add interface=ether6-slave-local list=discover
add interface=ether7-slave-local list=discover
add interface=ether8-slave-local list=discover
add interface=ether9-slave-local list=discover
add interface=ether10-slave-local list=discover
add interface=ether11-slave-local list=discover
add interface=ether12-slave-local list=discover
add interface=ether13-slave-local list=discover
add interface=ether14-slave-local list=discover
add interface=ether15-slave-local list=discover
add interface=ether16-slave-local list=discover
add interface=ether17-slave-local list=discover
add interface=ether18-slave-local list=discover
add interface=ether19-slave-local list=discover
add interface=ether20-slave-local list=discover
add interface=ether21-slave-local list=discover
add interface=ether22-slave-local list=discover
add interface=ether23-slave-local list=discover
add interface=ether24-slave-local list=discover
add interface=sfp-sfpplus1-slave-local list=discover
add interface=sfpplus2-slave-local list=discover
/ip address
add address=192.168.88.1/24 comment="default configuration" interface=bridge1 \
    network=192.168.88.0
add address=76.79.200.86/30 interface=ether1-master-local network=\
    76.79.200.84
/ip dhcp-server network
add address=192.168.88.0/24 dns-server=192.168.88.1,8.8.8.8,8.8.4.4 domain=\
    delrey.local gateway=192.168.88.1 netmask=24
/ip dns
set servers=192.168.88.10,8.8.8.8
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1-master-local
/ip route
add distance=1 gateway=76.79.200.85
/ip service
set telnet disabled=yes
set ftp disabled=yes
set www disabled=yes
set ssh address=192.168.88.0/24
set api disabled=yes
set winbox address=192.168.88.0/24
set api-ssl disabled=yes
/lcd interface
add interface=bridge1
/lcd interface pages
set 1 interfaces="ether13-slave-local,ether14-slave-local,ether15-slave-local,\
    ether16-slave-local,ether17-slave-local,ether18-slave-local"
/system clock
set time-zone-name=America/Los_Angeles
/system identity
set name=DaHub
/system leds
set 0 interface=sfp-sfpplus1-slave-local
set 1 interface=sfp-sfpplus1-slave-local
set 2 interface=sfpplus2-slave-local
set 3 interface=sfpplus2-slave-local
/system note
set note="HoneyPot Industries Networks, STIG V-3013 - Authorized Admins only. \
    Access attempts monitored and parsed."
/system ntp client
set enabled=yes server-dns-names=\
    1.north-america.pool.ntp.org,0.north-america.pool.ntp.org
/system routerboard settings
set silent-boot=no
/tool graphing interface
add
/tool romon port
add
