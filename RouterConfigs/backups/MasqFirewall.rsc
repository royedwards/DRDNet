# Generate by ISP Supplies | LearnMikroTik.com's Firewall tool
# Available at http://mikrotikconfig.com
#
/ip firewall filter
add action=drop chain=forward comment="Drop invalid connections through router" connection-state=invalid
add action=drop chain=forward comment="Drop all traffic to-from addresses on \\\"CountryIPBlocks\\\" address list" \
   dst-address-list=CountryIPBlocks
add chain=forward comment="Allow established connections through router" connection-state=established
add chain=forward comment="Allow related connections through router" connection-state=related
add chain=forward comment="Allow new connections through router coming in LAN interface" connection-state=new \
   in-interface=ether2-LAN
add action=drop chain=forward comment="Drop all other connections through the router"
add action=drop chain=input comment="Drop all traffic from addresses on \"CountryIPBlocks\" address list" \
   src-address-list=CountryIPBlocks
add chain=input comment="Allow everything from the LAN interface to the router" in-interface=ether2-LAN
add chain=input comment=\
   "Allow established  connections to the router, these are OK because we aren't allowing new connections" \
   connection-state=established
add chain=input comment=\
   "Allow related connections to the router, these are OK because we aren't allowing new connections" \
   connection-state=related
add action=drop chain=input comment="Drop everything else to the router" disabled=yes
