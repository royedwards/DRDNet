# aug/28/2018 23:17:10 by RouterOS 6.42.3
# software id = T8QK-05HB
#
# model = CRS226-24G-2S+
# serial number = 61C8054F0C95
/caps-man channel
add band=2ghz-b/g/n control-channel-width=20mhz frequency=2412 name=channel1
add band=2ghz-b/g/n control-channel-width=20mhz frequency=2462 name=channel11
add band=2ghz-b/g/n control-channel-width=20mhz frequency=2442 name=channel6
add band=5ghz-onlyac control-channel-width=20mhz frequency=5170 name=\
    "5G channel 34"
add band=5ghz-onlyac control-channel-width=20mhz frequency=5180 name=\
    "5G channel 36"
add band=5ghz-onlyac control-channel-width=40mhz-turbo frequency=5190 name=\
    "5G Channel 38"
add band=5ghz-onlyac control-channel-width=20mhz frequency=5200 name=\
    "5G Channel 40"
add band=5ghz-onlyac control-channel-width=40mhz-turbo frequency=5210 name=\
    "5G Channel 42"
add band=5ghz-onlyac control-channel-width=20mhz frequency=5220 name=\
    "5G Channel 44"
add band=5ghz-onlyac control-channel-width=40mhz-turbo frequency=5230 name=\
    "5G Channel 46"
add band=5ghz-onlyac control-channel-width=20mhz frequency=5240 name=\
    "5G Channel 48"
/interface bridge
add admin-mac=E4:8D:8C:A8:34:25 ageing-time=5m arp=enabled arp-timeout=auto \
    auto-mac=no comment="created from master port" disabled=no fast-forward=\
    yes igmp-snooping=no mtu=auto name=bridge1 protocol-mode=none \
    vlan-filtering=no
/interface ethernet
set [ find default-name=ether1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:24 mtu=1500 name=ether1-master-local orig-mac-address=\
    E4:8D:8C:A8:34:24 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether2 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:25 mtu=1500 name=ether2-master-local orig-mac-address=\
    E4:8D:8C:A8:34:25 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether3 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:26 mtu=1500 name=ether3-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:26 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether4 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:27 mtu=1500 name=ether4-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:27 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether5 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:28 mtu=1500 name=ether5-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:28 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether6 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:29 mtu=1500 name=ether6-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:29 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether7 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:2A mtu=1500 name=ether7-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:2A rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether8 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:2B mtu=1500 name=ether8-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:2B rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether9 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:2C mtu=1500 name=ether9-CAP1 orig-mac-address=\
    E4:8D:8C:A8:34:2C rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether10 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:2D mtu=1500 name=ether10-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:2D rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether11 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:2E mtu=1500 name=ether11-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:2E rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether12 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:2F mtu=1500 name=ether12-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:2F rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether13 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:30 mtu=1500 name=ether13-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:30 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether14 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:31 mtu=1500 name=ether14-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:31 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether15 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:32 mtu=1500 name=ether15-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:32 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether16 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:33 mtu=1500 name=ether16-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:33 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether17 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:34 mtu=1500 name=ether17-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:34 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether18 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:35 mtu=1500 name=ether18-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:35 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether19 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:36 mtu=1500 name=ether19-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:36 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether20 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:37 mtu=1500 name=ether20-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:37 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether21 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:38 mtu=1500 name=ether21-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:38 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether22 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:39 mtu=1500 name=ether22-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:39 rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether23 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:3A mtu=1500 name=ether23-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:3A rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=ether24 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:3B mtu=1500 name=ether24-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:3B rx-flow-control=off speed=100Mbps tx-flow-control=off
set [ find default-name=sfp-sfpplus1 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:3C mtu=1500 name=sfp-sfpplus1-slave-local \
    orig-mac-address=E4:8D:8C:A8:34:3C rx-flow-control=off speed=10Gbps \
    tx-flow-control=off
set [ find default-name=sfpplus2 ] advertise=\
    10M-half,10M-full,100M-half,100M-full,1000M-half,1000M-full arp=enabled \
    arp-timeout=auto auto-negotiation=yes bandwidth=unlimited/unlimited \
    disabled=no full-duplex=yes l2mtu=1588 loop-protect=default \
    loop-protect-disable-time=5m loop-protect-send-interval=5s mac-address=\
    E4:8D:8C:A8:34:3D mtu=1500 name=sfpplus2-slave-local orig-mac-address=\
    E4:8D:8C:A8:34:3D rx-flow-control=off speed=10Gbps tx-flow-control=off
/queue interface
set bridge1 queue=no-queue
/caps-man datapath
add bridge=bridge1 name=datapath1
/caps-man security
add authentication-types=wpa2-psk encryption=aes-ccm name=DRDNETSecurity \
    passphrase=Dixiebell55
add authentication-types=wpa2-psk encryption=aes-ccm name="DRDGUEST Security" \
    passphrase=2thfairy
/caps-man configuration
add channel.band=2ghz-b/g/n country="united states3" datapath=datapath1 \
    datapath.bridge=bridge1 name="Internal Network" security=DRDNETSecurity \
    security.authentication-types=wpa2-psk security.encryption=aes-ccm \
    security.passphrase=dixiebell55 ssid=DRD-DEV
add channel.band=2ghz-b/g/n country="united states3" datapath=datapath1 \
    datapath.bridge=bridge1 name="Guest Network" security="DRDGUEST Security" \
    security.authentication-types=wpa2-psk security.encryption=aes-ccm \
    security.passphrase=2thfairy ssid=DENTALGUEST
add channel.band=5ghz-a/n/ac country="united states3" datapath=datapath1 \
    datapath.bridge=bridge1 name="Internal 5G" security=DRDNETSecurity ssid=\
    DRDNET
/caps-man interface
add arp-timeout=auto channel=channel1 configuration="Guest Network" disabled=\
    no l2mtu=1600 mac-address=CC:2D:E0:95:75:25 master-interface=none name=\
    "CAP1 Reception" radio-mac=CC:2D:E0:95:75:25 security="DRDGUEST Security"
add arp-timeout=auto channel="5G Channel 38" channel.control-channel-width=\
    20mhz channel.frequency=5190 configuration="Internal 5G" disabled=no \
    l2mtu=1600 mac-address=CC:2D:E0:95:75:26 master-interface=none name=\
    "CAP1 Reception 5G" radio-mac=CC:2D:E0:95:75:26 security=DRDNETSecurity
add arp-timeout=auto channel=channel11 configuration="Internal Network" \
    configuration.country="united states3" disabled=no l2mtu=1600 \
    mac-address=CC:2D:E0:95:53:F2 master-interface=none name="CAP2 Panx" \
    radio-mac=CC:2D:E0:95:53:F2 security=DRDNETSecurity
add arp-timeout=auto channel="5G Channel 46" channel.control-channel-width=\
    20mhz channel.frequency=5230 configuration="Internal 5G" disabled=no \
    l2mtu=1600 mac-address=CC:2D:E0:95:53:F3 master-interface=none name=\
    "CAP2 Panx 5G" radio-mac=CC:2D:E0:95:53:F3 security=DRDNETSecurity
add arp-timeout=auto channel=channel1 configuration="Internal Network" \
    disabled=yes mac-address=00:00:00:00:00:00 master-interface=none name=\
    "Channel 1 Master" radio-mac=00:00:00:00:00:00
add arp-timeout=auto channel=channel11 configuration="Internal Network" \
    disabled=yes mac-address=00:00:00:00:00:00 master-interface=none name=\
    "Channel 11 Master" radio-mac=00:00:00:00:00:02
/queue interface
set "CAP1 Reception" queue=no-queue
set "CAP1 Reception 5G" queue=no-queue
set "CAP2 Panx" queue=no-queue
set "CAP2 Panx 5G" queue=no-queue
set "Channel 1 Master" queue=no-queue
set "Channel 11 Master" queue=no-queue
/interface list
set [ find name=all ] comment="contains all interfaces" exclude="" include="" \
    name=all
set [ find name=none ] comment="contains no interfaces" exclude="" include="" \
    name=none
set [ find name=dynamic ] comment="contains dynamic interfaces" exclude="" \
    include="" name=dynamic
add exclude=dynamic include="" name=discover
/interface lte apn
set [ find default=yes ] add-default-route=yes apn=internet \
    default-route-distance=2 name=default use-peer-dns=yes
/interface wireless security-profiles
set [ find default=yes ] authentication-types="" eap-methods=passthrough \
    group-ciphers=aes-ccm group-key-update=5m interim-update=0s \
    management-protection=disabled management-protection-key="" mode=none \
    mschapv2-password="" mschapv2-username="" name=default \
    radius-eap-accounting=no radius-mac-accounting=no \
    radius-mac-authentication=no radius-mac-caching=disabled \
    radius-mac-format=XX:XX:XX:XX:XX:XX radius-mac-mode=as-username \
    static-algo-0=none static-algo-1=none static-algo-2=none static-algo-3=\
    none static-key-0="" static-key-1="" static-key-2="" static-key-3="" \
    static-sta-private-algo=none static-sta-private-key="" \
    static-transmit-key=key-0 supplicant-identity=MikroTik tls-certificate=\
    none tls-mode=no-certificates unicast-ciphers=aes-ccm wpa-pre-shared-key=\
    "" wpa2-pre-shared-key=""
/ip dhcp-client option
set clientid_duid code=61 name=clientid_duid value="0xff\$(CLIENT_DUID)"
set clientid code=61 name=clientid value="0x01\$(CLIENT_MAC)"
set hostname code=12 name=hostname value="\$(HOSTNAME)"
/ip hotspot profile
set [ find default=yes ] dns-name="" hotspot-address=0.0.0.0 html-directory=\
    hotspot html-directory-override="" http-cookie-lifetime=3d http-proxy=\
    0.0.0.0:0 login-by=cookie,http-chap name=default rate-limit="" \
    smtp-server=0.0.0.0 split-user-domain=no use-radius=no
/ip hotspot user profile
set [ find default=yes ] add-mac-cookie=yes address-list="" idle-timeout=none \
    !insert-queue-before keepalive-timeout=2m mac-cookie-timeout=3d name=\
    default !parent-queue !queue-type shared-users=1 status-autorefresh=1m \
    transparent-proxy=no
/ip ipsec mode-config
set [ find default=yes ] name=request-only
/ip ipsec policy group
set [ find default=yes ] name=default
/ip ipsec proposal
set [ find default=yes ] auth-algorithms=sha1 disabled=no enc-algorithms=\
    aes-128-cbc lifetime=30m name=default pfs-group=modp1024
/ip pool
add name=dhcp ranges=192.168.88.100-192.168.88.200
add name=dhcp_pool1 ranges=192.168.88.2-192.168.88.254
/ip dhcp-server
add add-arp=yes address-pool=dhcp authoritative=yes bootp-support=static \
    disabled=yes interface=bridge1 lease-script="" lease-time=2h name=server1 \
    use-radius=no
/port
set 0 baud-rate=auto data-bits=8 flow-control=none name=serial0 parity=none \
    stop-bits=1
/ppp profile
set *0 address-list="" !bridge !bridge-horizon !bridge-path-cost \
    !bridge-port-priority change-tcp-mss=yes !dns-server !idle-timeout \
    !incoming-filter !insert-queue-before !interface-list !local-address \
    name=default on-down="" on-up="" only-one=default !outgoing-filter \
    !parent-queue !queue-type !rate-limit !remote-address !session-timeout \
    use-compression=default use-encryption=default use-mpls=default use-upnp=\
    default !wins-server
set *FFFFFFFE address-list="" !bridge !bridge-horizon !bridge-path-cost \
    !bridge-port-priority change-tcp-mss=yes !dns-server !idle-timeout \
    !incoming-filter !insert-queue-before !interface-list !local-address \
    name=default-encryption on-down="" on-up="" only-one=default \
    !outgoing-filter !parent-queue !queue-type !rate-limit !remote-address \
    !session-timeout use-compression=default use-encryption=yes use-mpls=\
    default use-upnp=default !wins-server
/queue type
set 0 kind=pfifo name=default pfifo-limit=50
set 1 kind=pfifo name=ethernet-default pfifo-limit=50
set 2 kind=sfq name=wireless-default sfq-allot=1514 sfq-perturb=5
set 3 kind=red name=synchronous-default red-avg-packet=1000 red-burst=20 \
    red-limit=60 red-max-threshold=50 red-min-threshold=10
set 4 kind=sfq name=hotspot-default sfq-allot=1514 sfq-perturb=5
set 5 kind=pcq name=pcq-upload-default pcq-burst-rate=0 pcq-burst-threshold=0 \
    pcq-burst-time=10s pcq-classifier=src-address pcq-dst-address-mask=32 \
    pcq-dst-address6-mask=128 pcq-limit=50KiB pcq-rate=0 \
    pcq-src-address-mask=32 pcq-src-address6-mask=128 pcq-total-limit=2000KiB
set 6 kind=pcq name=pcq-download-default pcq-burst-rate=0 \
    pcq-burst-threshold=0 pcq-burst-time=10s pcq-classifier=dst-address \
    pcq-dst-address-mask=32 pcq-dst-address6-mask=128 pcq-limit=50KiB \
    pcq-rate=0 pcq-src-address-mask=32 pcq-src-address6-mask=128 \
    pcq-total-limit=2000KiB
set 7 kind=none name=only-hardware-queue
set 8 kind=mq-pfifo mq-pfifo-limit=50 name=multi-queue-ethernet-default
set 9 kind=pfifo name=default-small pfifo-limit=10
/queue interface
set ether1-master-local queue=only-hardware-queue
set ether2-master-local queue=only-hardware-queue
set ether3-slave-local queue=only-hardware-queue
set ether4-slave-local queue=only-hardware-queue
set ether5-slave-local queue=only-hardware-queue
set ether6-slave-local queue=only-hardware-queue
set ether7-slave-local queue=only-hardware-queue
set ether8-slave-local queue=only-hardware-queue
set ether9-CAP1 queue=only-hardware-queue
set ether10-slave-local queue=only-hardware-queue
set ether11-slave-local queue=only-hardware-queue
set ether12-slave-local queue=only-hardware-queue
set ether13-slave-local queue=only-hardware-queue
set ether14-slave-local queue=only-hardware-queue
set ether15-slave-local queue=only-hardware-queue
set ether16-slave-local queue=only-hardware-queue
set ether17-slave-local queue=only-hardware-queue
set ether18-slave-local queue=only-hardware-queue
set ether19-slave-local queue=only-hardware-queue
set ether20-slave-local queue=only-hardware-queue
set ether21-slave-local queue=only-hardware-queue
set ether22-slave-local queue=only-hardware-queue
set ether23-slave-local queue=only-hardware-queue
set ether24-slave-local queue=only-hardware-queue
set sfp-sfpplus1-slave-local queue=only-hardware-queue
set sfpplus2-slave-local queue=only-hardware-queue
/routing bgp instance
set default as=65530 client-to-client-reflection=yes !cluster-id \
    !confederation disabled=no ignore-as-path-len=no name=default out-filter=\
    "" redistribute-connected=no redistribute-ospf=no redistribute-other-bgp=\
    no redistribute-rip=no redistribute-static=no router-id=0.0.0.0 \
    routing-table=""
/routing ospf instance
set [ find default=yes ] disabled=no distribute-default=never !domain-id \
    !domain-tag in-filter=ospf-in metric-bgp=auto metric-connected=20 \
    metric-default=1 metric-other-ospf=auto metric-rip=20 metric-static=20 \
    !mpls-te-area !mpls-te-router-id name=default out-filter=ospf-out \
    redistribute-bgp=no redistribute-connected=no redistribute-other-ospf=no \
    redistribute-rip=no redistribute-static=no router-id=0.0.0.0 \
    !routing-table !use-dn
/routing ospf area
set [ find default=yes ] area-id=0.0.0.0 disabled=no instance=default name=\
    backbone type=default
/snmp community
set [ find default=yes ] addresses=0.0.0.0/0 authentication-password="" \
    authentication-protocol=MD5 encryption-password="" encryption-protocol=\
    DES name=public read-access=yes security=none write-access=no
/system logging action
set 0 memory-lines=1000 memory-stop-on-full=no name=memory target=memory
set 1 disk-file-count=2 disk-file-name=log disk-lines-per-file=1000 \
    disk-stop-on-full=no name=disk target=disk
set 2 name=echo remember=yes target=echo
set 3 bsd-syslog=no name=remote remote=0.0.0.0 remote-port=514 src-address=\
    0.0.0.0 syslog-facility=daemon syslog-severity=auto syslog-time-format=\
    bsd-syslog target=remote
/user group
set read name=read policy="local,telnet,ssh,reboot,read,test,winbox,password,w\
    eb,sniff,sensitive,api,romon,tikapp,!ftp,!write,!policy,!dude" skin=\
    default
set write name=write policy="local,telnet,ssh,reboot,read,write,test,winbox,pa\
    ssword,web,sniff,sensitive,api,romon,tikapp,!ftp,!policy,!dude" skin=\
    default
set full name=full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,\
    winbox,password,web,sniff,sensitive,api,romon,dude,tikapp" skin=default
/caps-man aaa
set interim-update=disabled mac-caching=disabled mac-format="" mac-mode=\
    as-username
/caps-man access-list
add action=accept allow-signal-out-of-range=10s disabled=yes interface=any \
    mac-address=CC:2D:E0:95:53:F2 ssid-regexp=""
add action=accept allow-signal-out-of-range=10s disabled=yes interface=any \
    mac-address=CC:2D:E0:95:53:F3 ssid-regexp=""
add action=accept allow-signal-out-of-range=10s disabled=yes interface=any \
    mac-address=CC:2D:E0:95:75:25 ssid-regexp=""
add action=accept allow-signal-out-of-range=10s disabled=yes interface=any \
    mac-address=CC:2D:E0:95:75:26 ssid-regexp=""
/caps-man manager
set ca-certificate=none certificate=none enabled=yes package-path="" \
    require-peer-certificate=no upgrade-policy=none
/caps-man manager interface
set [ find default=yes ] disabled=no forbid=no interface=all
add disabled=no forbid=no interface=bridge1
/caps-man provisioning
add action=create-enabled common-name-regexp="" disabled=no \
    hw-supported-modes=an,b,g,gn identity-regexp="" ip-address-ranges=\
    192.168.88.0/24 master-configuration="Internal Network" name-format=\
    identity name-prefix="" radio-mac=CC:2D:E0:95:53:F2 slave-configurations=\
    ""
add action=create-enabled common-name-regexp="" disabled=no \
    hw-supported-modes=ac identity-regexp="" ip-address-ranges="" \
    master-configuration="Internal 5G" name-format=identity name-prefix="" \
    radio-mac=CC:2D:E0:95:53:F3 slave-configurations=""
add action=create-enabled common-name-regexp="" disabled=no \
    hw-supported-modes="" identity-regexp="" ip-address-ranges="" \
    master-configuration="Guest Network" name-format=identity name-prefix="" \
    radio-mac=CC:2D:E0:95:75:25 slave-configurations=""
add action=create-enabled common-name-regexp="" disabled=no \
    hw-supported-modes="" identity-regexp="" ip-address-ranges="" \
    master-configuration="Internal 5G" name-format=identity name-prefix="" \
    radio-mac=CC:2D:E0:95:75:26 slave-configurations=""
/certificate settings
set crl-download=yes crl-store=system crl-use=yes
/interface bridge port
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether3-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether4-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether5-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether6-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether7-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether8-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether9-CAP1 internal-path-cost=10 learn=auto path-cost=10 point-to-point=\
    auto priority=0x80 pvid=1 restricted-role=no restricted-tcn=no \
    unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether10-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether11-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether12-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether13-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether14-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether15-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether16-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether17-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether18-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether19-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether20-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether21-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether22-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether23-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether24-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    sfp-sfpplus1-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    sfpplus2-slave-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge=bridge1 broadcast-flood=yes disabled=no edge=auto \
    frame-types=admit-all horizon=none hw=yes ingress-filtering=no interface=\
    ether2-master-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
add auto-isolate=no bridge="CAP2 Panx" broadcast-flood=yes disabled=no edge=\
    auto frame-types=admit-all horizon=none ingress-filtering=no interface=\
    ether1-master-local internal-path-cost=10 learn=auto path-cost=10 \
    point-to-point=auto priority=0x80 pvid=1 restricted-role=no \
    restricted-tcn=no unknown-multicast-flood=yes unknown-unicast-flood=yes
/interface bridge settings
set allow-fast-path=yes use-ip-firewall=no use-ip-firewall-for-pppoe=no \
    use-ip-firewall-for-vlan=no
/ip firewall connection tracking
set enabled=auto generic-timeout=10m icmp-timeout=10s tcp-close-timeout=10s \
    tcp-close-wait-timeout=10s tcp-established-timeout=1d \
    tcp-fin-wait-timeout=10s tcp-last-ack-timeout=10s \
    tcp-max-retrans-timeout=5m tcp-syn-received-timeout=5s \
    tcp-syn-sent-timeout=5s tcp-time-wait-timeout=10s tcp-unacked-timeout=5m \
    udp-stream-timeout=3m udp-timeout=10s
/ip neighbor discovery-settings
set discover-interface-list=discover
/ip settings
set accept-redirects=no accept-source-route=no allow-fast-path=yes \
    arp-timeout=30s icmp-rate-limit=10 icmp-rate-mask=0x1818 ip-forward=yes \
    max-neighbor-entries=8192 route-cache=yes rp-filter=no secure-redirects=\
    yes send-redirects=yes tcp-syncookies=no
/interface detect-internet
set detect-interface-list=none internet-interface-list=none \
    lan-interface-list=none wan-interface-list=none
/interface ethernet switch
set bridge-type=customer-vid-used-as-lookup-vid \
    bypass-ingress-port-policing-for="" bypass-l2-security-check-filter-for=\
    "" bypass-vlan-ingress-filter-for="" \
    drop-if-invalid-or-src-port-not-member-of-vlan-on-ports="" \
    drop-if-no-vlan-assignment-on-ports="" egress-mirror-ratio=1/1 \
    egress-mirror0=switch1-cpu,modified egress-mirror1=switch1-cpu,modified \
    fdb-uses=mirror0 forward-unknown-vlan=yes ingress-mirror-ratio=1/1 \
    ingress-mirror0=switch1-cpu,unmodified ingress-mirror1=\
    switch1-cpu,unmodified mac-level-isolation=yes \
    mirror-egress-if-ingress-mirrored=no mirror-tx-on-mirror-port=no \
    mirrored-packet-drop-precedence=green mirrored-packet-qos-priority=0 \
    multicast-lookup-mode=dst-ip-and-vid-for-ipv4 name=switch1 \
    override-existing-when-ufdb-full=no unicast-fdb-timeout=5m \
    unknown-vlan-lookup-mode=svl use-cvid-in-one2one-vlan-lookup=yes \
    use-svid-in-one2one-vlan-lookup=no vlan-uses=mirror0
/interface ethernet switch dscp-qos-map
set 0 dei=0 drop-precedence=green pcp=0 priority=1
set 1 dei=0 drop-precedence=green pcp=0 priority=0
set 2 dei=0 drop-precedence=green pcp=0 priority=0
set 3 dei=0 drop-precedence=green pcp=0 priority=0
set 4 dei=0 drop-precedence=green pcp=0 priority=0
set 5 dei=0 drop-precedence=green pcp=0 priority=0
set 6 dei=0 drop-precedence=green pcp=0 priority=0
set 7 dei=0 drop-precedence=green pcp=0 priority=0
set 8 dei=0 drop-precedence=green pcp=0 priority=1
set 9 dei=0 drop-precedence=green pcp=0 priority=0
set 10 dei=0 drop-precedence=green pcp=0 priority=0
set 11 dei=0 drop-precedence=green pcp=0 priority=0
set 12 dei=0 drop-precedence=yellow pcp=0 priority=0
set 13 dei=0 drop-precedence=green pcp=0 priority=0
set 14 dei=0 drop-precedence=red pcp=0 priority=0
set 15 dei=0 drop-precedence=green pcp=0 priority=0
set 16 dei=0 drop-precedence=green pcp=0 priority=2
set 17 dei=0 drop-precedence=green pcp=0 priority=0
set 18 dei=0 drop-precedence=green pcp=0 priority=2
set 19 dei=0 drop-precedence=green pcp=0 priority=0
set 20 dei=0 drop-precedence=yellow pcp=0 priority=2
set 21 dei=0 drop-precedence=green pcp=0 priority=0
set 22 dei=0 drop-precedence=red pcp=0 priority=2
set 23 dei=0 drop-precedence=green pcp=0 priority=0
set 24 dei=0 drop-precedence=green pcp=0 priority=2
set 25 dei=0 drop-precedence=green pcp=0 priority=0
set 26 dei=0 drop-precedence=green pcp=0 priority=2
set 27 dei=0 drop-precedence=green pcp=0 priority=0
set 28 dei=0 drop-precedence=yellow pcp=0 priority=2
set 29 dei=0 drop-precedence=green pcp=0 priority=0
set 30 dei=0 drop-precedence=red pcp=0 priority=2
set 31 dei=0 drop-precedence=green pcp=0 priority=0
set 32 dei=0 drop-precedence=green pcp=0 priority=2
set 33 dei=0 drop-precedence=green pcp=0 priority=0
set 34 dei=0 drop-precedence=green pcp=0 priority=2
set 35 dei=0 drop-precedence=green pcp=0 priority=0
set 36 dei=0 drop-precedence=yellow pcp=0 priority=2
set 37 dei=0 drop-precedence=green pcp=0 priority=0
set 38 dei=0 drop-precedence=red pcp=0 priority=2
set 39 dei=0 drop-precedence=green pcp=0 priority=0
set 40 dei=0 drop-precedence=green pcp=0 priority=2
set 41 dei=0 drop-precedence=green pcp=0 priority=0
set 42 dei=0 drop-precedence=green pcp=0 priority=0
set 43 dei=0 drop-precedence=green pcp=0 priority=0
set 44 dei=0 drop-precedence=green pcp=0 priority=0
set 45 dei=0 drop-precedence=green pcp=0 priority=0
set 46 dei=0 drop-precedence=green pcp=0 priority=3
set 47 dei=0 drop-precedence=green pcp=0 priority=0
set 48 dei=0 drop-precedence=green pcp=0 priority=2
set 49 dei=0 drop-precedence=green pcp=0 priority=0
set 50 dei=0 drop-precedence=green pcp=0 priority=0
set 51 dei=0 drop-precedence=green pcp=0 priority=0
set 52 dei=0 drop-precedence=green pcp=0 priority=0
set 53 dei=0 drop-precedence=green pcp=0 priority=0
set 54 dei=0 drop-precedence=green pcp=0 priority=0
set 55 dei=0 drop-precedence=green pcp=0 priority=0
set 56 dei=0 drop-precedence=green pcp=0 priority=2
set 57 dei=0 drop-precedence=green pcp=0 priority=0
set 58 dei=0 drop-precedence=green pcp=0 priority=0
set 59 dei=0 drop-precedence=green pcp=0 priority=0
set 60 dei=0 drop-precedence=green pcp=0 priority=0
set 61 dei=0 drop-precedence=green pcp=0 priority=0
set 62 dei=0 drop-precedence=green pcp=0 priority=0
set 63 dei=0 drop-precedence=green pcp=0 priority=0
/interface ethernet switch policer-qos-map
set 0 dei-for-red=0 dei-for-yellow=0 dscp-for-red=0 dscp-for-yellow=0 \
    pcp-for-red=0 pcp-for-yellow=0
set 1 dei-for-red=0 dei-for-yellow=0 dscp-for-red=0 dscp-for-yellow=0 \
    pcp-for-red=0 pcp-for-yellow=0
set 2 dei-for-red=0 dei-for-yellow=0 dscp-for-red=0 dscp-for-yellow=0 \
    pcp-for-red=0 pcp-for-yellow=0
set 3 dei-for-red=0 dei-for-yellow=0 dscp-for-red=0 dscp-for-yellow=0 \
    pcp-for-red=0 pcp-for-yellow=0
set 4 dei-for-red=0 dei-for-yellow=0 dscp-for-red=0 dscp-for-yellow=0 \
    pcp-for-red=0 pcp-for-yellow=0
set 5 dei-for-red=0 dei-for-yellow=0 dscp-for-red=0 dscp-for-yellow=0 \
    pcp-for-red=0 pcp-for-yellow=0
set 6 dei-for-red=0 dei-for-yellow=0 dscp-for-red=0 dscp-for-yellow=0 \
    pcp-for-red=0 pcp-for-yellow=0
set 7 dei-for-red=0 dei-for-yellow=0 dscp-for-red=0 dscp-for-yellow=0 \
    pcp-for-red=0 pcp-for-yellow=0
/interface ethernet switch port
set 0 action-on-static-station-move=forward allow-fdb-based-vlan-translate=no \
    allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 1 action-on-static-station-move=forward allow-fdb-based-vlan-translate=no \
    allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 2 action-on-static-station-move=forward allow-fdb-based-vlan-translate=no \
    allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 3 action-on-static-station-move=forward allow-fdb-based-vlan-translate=no \
    allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 4 action-on-static-station-move=forward allow-fdb-based-vlan-translate=no \
    allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 5 action-on-static-station-move=forward allow-fdb-based-vlan-translate=no \
    allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 6 action-on-static-station-move=forward allow-fdb-based-vlan-translate=no \
    allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 7 action-on-static-station-move=forward allow-fdb-based-vlan-translate=no \
    allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 8 action-on-static-station-move=forward allow-fdb-based-vlan-translate=no \
    allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 9 action-on-static-station-move=forward allow-fdb-based-vlan-translate=no \
    allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 10 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 11 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 12 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 13 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 14 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 15 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 16 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 17 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 18 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 19 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 20 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 21 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 22 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 23 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 24 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 25 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
set 26 action-on-static-station-move=forward allow-fdb-based-vlan-translate=\
    no allow-mac-based-customer-vlan-assignment-for=all \
    allow-mac-based-service-vlan-assignment-for=all allow-multicast-loopback=\
    no allow-unicast-loopback=no custom-drop-counter-includes="" \
    default-customer-pcp=0 default-service-pcp=0 drop-dynamic-mac-move=no \
    drop-secure-static-mac-move=no drop-when-ufdb-entry-src-drop=yes \
    dscp-based-qos-dscp-to-dscp-mapping=yes !egress-customer-tpid-override \
    egress-mirror-to=none egress-pcp-propagation=no \
    !egress-service-tpid-override egress-vlan-mode=unmodified \
    egress-vlan-tag-table-lookup-key=egress-vid filter-priority-tagged-frame=\
    no filter-tagged-frame=no filter-untagged-frame=no \
    !ingress-customer-tpid-override ingress-mirror-to=none \
    ingress-mirroring-according-to-vlan=no !ingress-service-tpid-override \
    !isolation-leakage-profile-override !learn-limit \
    pcp-based-qos-dei-mapping=0-15:0 pcp-based-qos-drop-precedence-mapping=\
    0-15:green pcp-based-qos-dscp-mapping=0-15:0 pcp-based-qos-pcp-mapping=\
    0-15:0 pcp-based-qos-priority-mapping=0-15:0 \
    pcp-or-dscp-based-qos-change-dei=no pcp-or-dscp-based-qos-change-dscp=no \
    pcp-or-dscp-based-qos-change-pcp=no pcp-propagation-for-initial-pcp=no \
    per-queue-scheduling="wrr-group0:1,wrr-group0:2,wrr-group0:4,wrr-group0:8,\
    wrr-group0:16,wrr-group0:32,wrr-group0:64,wrr-group0:128" \
    policy-drop-counter-includes="" priority-to-queue=0-15:0,1:1,2:2,3:3 \
    qos-scheme-precedence="ingress-acl-based,sa-based,da-based,dscp-based,prot\
    ocol-based,vlan-based,pcp-based" queue-custom-drop-counter0-includes="" \
    queue-custom-drop-counter1-includes="" vlan-type=network-port
/interface l2tp-server server
set allow-fast-path=no authentication=pap,chap,mschap1,mschap2 \
    caller-id-type=ip-address default-profile=default-encryption enabled=no \
    ipsec-secret="" keepalive-timeout=30 max-mru=1450 max-mtu=1450 \
    max-sessions=unlimited mrru=disabled one-session-per-host=no use-ipsec=no
/interface list member
add disabled=no interface=bridge1 list=discover
add disabled=no interface=ether3-slave-local list=discover
add disabled=no interface=ether4-slave-local list=discover
add disabled=no interface=ether5-slave-local list=discover
add disabled=no interface=ether6-slave-local list=discover
add disabled=no interface=ether7-slave-local list=discover
add disabled=no interface=ether8-slave-local list=discover
add disabled=no interface=ether9-CAP1 list=discover
add disabled=no interface=ether10-slave-local list=discover
add disabled=no interface=ether11-slave-local list=discover
add disabled=no interface=ether12-slave-local list=discover
add disabled=no interface=ether13-slave-local list=discover
add disabled=no interface=ether14-slave-local list=discover
add disabled=no interface=ether15-slave-local list=discover
add disabled=no interface=ether16-slave-local list=discover
add disabled=no interface=ether17-slave-local list=discover
add disabled=no interface=ether18-slave-local list=discover
add disabled=no interface=ether19-slave-local list=discover
add disabled=no interface=ether20-slave-local list=discover
add disabled=no interface=ether21-slave-local list=discover
add disabled=no interface=ether22-slave-local list=discover
add disabled=no interface=ether23-slave-local list=discover
add disabled=no interface=ether24-slave-local list=discover
add disabled=no interface=sfp-sfpplus1-slave-local list=discover
add disabled=no interface=sfpplus2-slave-local list=discover
/interface ovpn-server server
set auth=sha1,md5 cipher=blowfish128,aes128 default-profile=default enabled=\
    no keepalive-timeout=60 mac-address=FE:C5:2D:CB:F1:AC max-mtu=1500 mode=\
    ip netmask=24 port=1194 require-client-certificate=no
/interface pptp-server server
set authentication=mschap1,mschap2 default-profile=default-encryption \
    enabled=no keepalive-timeout=30 max-mru=1450 max-mtu=1450 mrru=disabled
/interface sstp-server server
set authentication=pap,chap,mschap1,mschap2 certificate=none default-profile=\
    default enabled=no force-aes=no keepalive-timeout=60 max-mru=1500 \
    max-mtu=1500 mrru=disabled pfs=no port=443 tls-version=any \
    verify-client-certificate=no
/interface wireless align
set active-mode=yes audio-max=-20 audio-min=-100 audio-monitor=\
    00:00:00:00:00:00 filter-mac=00:00:00:00:00:00 frame-size=300 \
    frames-per-second=25 receive-all=no ssid-all=no
/interface wireless cap
set bridge=none caps-man-addresses="" caps-man-certificate-common-names="" \
    caps-man-names="" certificate=none discovery-interfaces="" enabled=no \
    interfaces="" lock-to-caps-man=no static-virtual=no
/interface wireless sniffer
set channel-time=200ms file-limit=10 file-name="" memory-limit=10 \
    multiple-channels=no only-headers=no receive-errors=no streaming-enabled=\
    no streaming-max-rate=0 streaming-server=0.0.0.0
/interface wireless snooper
set channel-time=200ms multiple-channels=yes receive-errors=no
/ip accounting
set account-local-traffic=no enabled=no threshold=256
/ip accounting web-access
set accessible-via-web=no address=0.0.0.0/0
/ip address
add address=192.168.88.1/24 comment="default configuration" disabled=no \
    interface=bridge1 network=192.168.88.0
add address=76.79.200.86/30 disabled=no interface=ether1-master-local \
    network=76.79.200.84
/ip cloud
set ddns-enabled=no update-time=yes
/ip cloud advanced
set use-local-address=no
/ip dhcp-server config
set store-leases-disk=5m
/ip dhcp-server network
add address=192.168.88.0/24 caps-manager="" dhcp-option="" dns-server=\
    192.168.88.1,8.8.8.8,8.8.4.4 domain=delrey.local gateway=192.168.88.1 \
    netmask=24 ntp-server="" wins-server=""
/ip dns
set allow-remote-requests=no cache-max-ttl=1w cache-size=2048KiB \
    max-concurrent-queries=100 max-concurrent-tcp-sessions=20 \
    max-udp-packet-size=4096 query-server-timeout=2s query-total-timeout=10s \
    servers=192.168.88.10,8.8.8.8
/ip firewall nat
add action=masquerade chain=srcnat !connection-bytes !connection-limit \
    !connection-mark !connection-rate !connection-type !content disabled=no \
    !dscp !dst-address !dst-address-list !dst-address-type !dst-limit \
    !dst-port !fragment !hotspot !icmp-options !in-bridge-port !in-interface \
    !ingress-priority !ipv4-options !layer7-protocol !limit log=no \
    log-prefix="" !nth !out-bridge-port out-interface=ether1-master-local \
    !packet-mark !packet-size !per-connection-classifier !port !priority \
    !protocol !psd !random !routing-mark !routing-table !src-address \
    !src-address-list !src-address-type !src-mac-address !src-port !tcp-mss \
    !time !to-addresses !to-ports !ttl
/ip firewall service-port
set ftp disabled=no ports=21
set tftp disabled=no ports=69
set irc disabled=no ports=6667
set h323 disabled=no
set sip disabled=no ports=5060,5061 sip-direct-media=yes sip-timeout=1h
set pptp disabled=no
set udplite disabled=no
set dccp disabled=no
set sctp disabled=no
/ip hotspot service-port
set ftp disabled=no ports=21
/ip hotspot user
set [ find default=yes ] comment="counters and limits for trial users" \
    disabled=no name=default-trial
/ip ipsec policy
set 0 disabled=no dst-address=::/0 group=default proposal=default protocol=\
    all src-address=::/0 template=yes
/ip ipsec user settings
set xauth-use-radius=no
/ip proxy
set always-from-cache=no anonymous=no cache-administrator=webmaster \
    cache-hit-dscp=4 cache-on-disk=no cache-path=web-proxy enabled=no \
    max-cache-object-size=2048KiB max-cache-size=unlimited \
    max-client-connections=600 max-fresh-time=3d max-server-connections=600 \
    parent-proxy=:: parent-proxy-port=0 port=8080 serialize-connections=no \
    src-address=::
/ip route
add !bgp-as-path !bgp-atomic-aggregate !bgp-communities !bgp-local-pref \
    !bgp-med !bgp-origin !bgp-prepend !check-gateway disabled=no distance=1 \
    dst-address=0.0.0.0/0 gateway=76.79.200.85 !route-tag !routing-mark \
    scope=30 target-scope=10
/ip service
set telnet address="" disabled=yes port=23
set ftp address="" disabled=yes port=21
set www address="" disabled=yes port=80
set ssh address=192.168.88.0/24 disabled=no port=22
set www-ssl address="" certificate=none disabled=yes port=443
set api address="" disabled=yes port=8728
set winbox address=192.168.88.0/24 disabled=no port=8291
set api-ssl address="" certificate=none disabled=yes port=8729
/ip smb
set allow-guests=yes comment=MikrotikSMB domain=MSHOME enabled=no interfaces=\
    all
/ip smb shares
set [ find default=yes ] comment="default share" directory=/pub disabled=no \
    max-sessions=10 name=pub
/ip smb users
set [ find default=yes ] disabled=no name=guest password="" read-only=yes
/ip socks
set connection-idle-timeout=2m enabled=no max-connections=200 port=1080
/ip ssh
set always-allow-password-login=no forwarding-enabled=no host-key-size=2048 \
    strong-crypto=no
/ip traffic-flow
set active-flow-timeout=30m cache-entries=16k enabled=no \
    inactive-flow-timeout=15s interfaces=all
/ip traffic-flow ipfix
set bytes=yes dst-address=yes dst-address-mask=yes dst-mac-address=yes \
    dst-port=yes first-forwarded=yes gateway=yes icmp-code=yes icmp-type=yes \
    igmp-type=yes in-interface=yes ip-header-length=yes ip-total-length=yes \
    ipv6-flow-label=yes is-multicast=yes last-forwarded=yes nat-dst-address=\
    yes nat-dst-port=yes nat-src-address=yes nat-src-port=yes out-interface=\
    yes packets=yes protocol=yes src-address=yes src-address-mask=yes \
    src-mac-address=yes src-port=yes tcp-ack-num=yes tcp-flags=yes \
    tcp-seq-num=yes tcp-window-size=yes tos=yes ttl=yes udp-length=yes
/ip upnp
set allow-disable-external-interface=no enabled=no show-dummy-rule=yes
/lcd
set backlight-timeout=30m color-scheme=dark default-screen=main-menu enabled=\
    yes flip-screen=no read-only-mode=no time-interval=min touch-screen=\
    enabled
/lcd pin
set hide-pin-number=no pin-number=1234
/lcd interface
set ether1-master-local disabled=no max-speed=auto timeout=10s
add disabled=no interface=bridge1 max-speed=auto timeout=10s
set ether3-slave-local disabled=no max-speed=auto timeout=10s
set ether4-slave-local disabled=no max-speed=auto timeout=10s
set ether5-slave-local disabled=no max-speed=auto timeout=10s
set ether6-slave-local disabled=no max-speed=auto timeout=10s
set ether7-slave-local disabled=no max-speed=auto timeout=10s
set ether8-slave-local disabled=no max-speed=auto timeout=10s
set ether9-CAP1 disabled=no max-speed=auto timeout=10s
set ether10-slave-local disabled=no max-speed=auto timeout=10s
set ether11-slave-local disabled=no max-speed=auto timeout=10s
set ether12-slave-local disabled=no max-speed=auto timeout=10s
set ether13-slave-local disabled=no max-speed=auto timeout=10s
set ether14-slave-local disabled=no max-speed=auto timeout=10s
set ether15-slave-local disabled=no max-speed=auto timeout=10s
set ether16-slave-local disabled=no max-speed=auto timeout=10s
set ether17-slave-local disabled=no max-speed=auto timeout=10s
set ether18-slave-local disabled=no max-speed=auto timeout=10s
set ether19-slave-local disabled=no max-speed=auto timeout=10s
set ether20-slave-local disabled=no max-speed=auto timeout=10s
set ether21-slave-local disabled=no max-speed=auto timeout=10s
set ether22-slave-local disabled=no max-speed=auto timeout=10s
set ether23-slave-local disabled=no max-speed=auto timeout=10s
set ether24-slave-local disabled=no max-speed=auto timeout=10s
set sfp-sfpplus1-slave-local disabled=no max-speed=auto timeout=10s
set sfpplus2-slave-local disabled=no max-speed=auto timeout=10s
set ether2-master-local disabled=no max-speed=auto timeout=10s
/lcd interface pages
set 0 interfaces="ether1-master-local,bridge1,ether3-slave-local,ether4-slave-\
    local,ether5-slave-local,ether6-slave-local,ether7-slave-local,ether8-slav\
    e-local,ether9-CAP1,ether10-slave-local,ether11-slave-local,ether12-slave-\
    local"
set 1 interfaces="ether13-slave-local,ether14-slave-local,ether15-slave-local,\
    ether16-slave-local,ether17-slave-local,ether18-slave-local"
/lcd screen
set 0 disabled=no timeout=10s
set 1 disabled=no timeout=10s
set 2 disabled=no timeout=10s
set 3 disabled=no timeout=10s
set 4 disabled=no timeout=10s
set 5 disabled=no timeout=10s
/mpls
set dynamic-label-range=16-1048575 propagate-ttl=yes
/mpls interface
set [ find default=yes ] disabled=no interface=all mpls-mtu=1508
/mpls ldp
set distribute-for-default-route=no enabled=no hop-limit=255 loop-detect=no \
    lsr-id=0.0.0.0 path-vector-limit=255 transport-address=0.0.0.0 \
    use-explicit-null=no
/port firmware
set directory=firmware ignore-directip-modem=no
/ppp aaa
set accounting=yes interim-update=0s use-circuit-id-in-nas-port-id=no \
    use-radius=no
/radius incoming
set accept=no port=3799
/routing bfd interface
set [ find default=yes ] disabled=no interface=all interval=0.2s min-rx=0.2s \
    multiplier=5
/routing mme
set bidirectional-timeout=2 gateway-class=none gateway-keepalive=1m \
    gateway-selection=no-gateway origination-interval=5s preferred-gateway=\
    0.0.0.0 timeout=1m ttl=50
/routing rip
set distribute-default=never garbage-timer=2m metric-bgp=1 metric-connected=1 \
    metric-default=1 metric-ospf=1 metric-static=1 redistribute-bgp=no \
    redistribute-connected=no redistribute-ospf=no redistribute-static=no \
    routing-table=main timeout-timer=3m update-timer=30s
/snmp
set contact="" enabled=no engine-id="" location="" trap-community=public \
    trap-generators="" trap-target="" trap-version=1
/system clock
set time-zone-autodetect=yes time-zone-name=America/Los_Angeles
/system clock manual
set dst-delta=+00:00 dst-end="jan/01/1970 00:00:00" dst-start=\
    "jan/01/1970 00:00:00" time-zone=+00:00
/system console
set [ find port=serial0 ] channel=0 disabled=no port=serial0 term=vt102
/system health
set fan-on-threshold=40C fan-switch=on
/system identity
set name=DaHub
/system leds
set 0 disabled=no interface=sfp-sfpplus1-slave-local leds=sfp-sfpplus1-led1 \
    type=interface-activity
set 1 disabled=no interface=sfp-sfpplus1-slave-local leds=sfp-sfpplus1-led2 \
    type=interface-speed
set 2 disabled=no interface=sfpplus2-slave-local leds=sfpplus2-led1 type=\
    interface-activity
set 3 disabled=no interface=sfpplus2-slave-local leds=sfpplus2-led2 type=\
    interface-speed
/system leds settings
set all-leds-off=never
/system logging
set 0 action=memory disabled=no prefix="" topics=info
set 1 action=memory disabled=no prefix="" topics=error
set 2 action=memory disabled=no prefix="" topics=warning
set 3 action=echo disabled=no prefix="" topics=critical
/system note
set note="HoneyPot Industries Networks, STIG V-3013 - Authorized Admins only. \
    Access attempts monitored and parsed." show-at-login=yes
/system ntp client
set enabled=yes primary-ntp=0.0.0.0 secondary-ntp=0.0.0.0 server-dns-names=\
    1.north-america.pool.ntp.org,0.north-america.pool.ntp.org
/system resource irq
set 0 cpu=auto
set 1 cpu=auto
set 2 cpu=auto
set 3 cpu=auto
/system routerboard settings
set auto-upgrade=no baud-rate=115200 boot-delay=2s boot-device=\
    nand-if-fail-then-ethernet boot-protocol=bootp enable-jumper-reset=yes \
    enter-setup-on=any-key force-backup-booter=no protected-routerboot=\
    disabled reformat-hold-button=20s reformat-hold-button-max=10m \
    silent-boot=no
/system upgrade mirror
set check-interval=1d enabled=no primary-server=0.0.0.0 secondary-server=\
    0.0.0.0 user=""
/system watchdog
set auto-send-supout=no automatic-supout=yes no-ping-delay=5m watch-address=\
    none watchdog-timer=yes
/tool bandwidth-server
set allocate-udp-ports-from=2000 authenticate=yes enabled=yes max-sessions=\
    100
/tool e-mail
set address=0.0.0.0 from=<> password="" port=25 start-tls=no user=""
/tool graphing
set page-refresh=300 store-every=5min
/tool graphing interface
add allow-address=0.0.0.0/0 disabled=no interface=all store-on-disk=yes
/tool mac-server
set allowed-interface-list=all
/tool mac-server mac-winbox
set allowed-interface-list=all
/tool mac-server ping
set enabled=yes
/tool romon
set enabled=no id=00:00:00:00:00:00 secrets=""
/tool romon port
set [ find default=yes ] cost=100 disabled=no forbid=no interface=all \
    secrets=""
add cost=100 disabled=yes forbid=no interface=all secrets=""
/tool sms
set allowed-number="" channel=0 keep-max-sms=0 port=none receive-enabled=no \
    secret="" sim-pin=""
/tool sniffer
set file-limit=1000KiB file-name="" filter-cpu="" filter-direction=any \
    filter-interface="" filter-ip-address="" filter-ip-protocol="" \
    filter-ipv6-address="" filter-mac-address="" filter-mac-protocol="" \
    filter-operator-between-entries=or filter-port="" filter-stream=no \
    memory-limit=100KiB memory-scroll=yes only-headers=no streaming-enabled=\
    no streaming-server=0.0.0.0
/tool traffic-generator
set latency-distribution-max=100us measure-out-of-order=yes \
    stats-samples-to-keep=100 test-id=0
/user aaa
set accounting=yes default-group=read exclude-groups="" interim-update=0s \
    use-radius=no
