# About

This is the Del Rey Dental computing environment

# Goals

Our goal is to replace the aging computing environment with a robust, highly secure, instrumented, monitored, and virtualized environment
that is decoupled from the existing hardware.  This will provide a secure platform that will provide superior availability of the working 
environment, integrated monitoring for fault detection, automatic offsite backups.  

# Rationale

# Architecture

Router Hardening

Multi-Layer security model

Router Hardening

Firewall

Blacklisted DNS

1.1.1.1

What is 1.1.1.1?
1.1.1.1 is a fast and private way to browse the Internet. It is a public DNS resolver, but unlike most DNS resolvers, 1.1.1.1 is not selling user data to advertisers. The implementation of 1.1.1.1 makes it the fastest resolver out there.

What is DNS?
The Domain Name System (DNS) is the phonebook of the Internet. Humans access information online through domain names, like nytimes.com or espn.com. Web browsers interact through Internet Protocol (IP) addresses. DNS translates domain names to IP addresses so browsers can load Internet resources.

DNS
Each device connected to the Internet has a unique IP address which other machines use to find the device. DNS servers eliminate the need for humans to memorize IP addresses such as 192.168.1.1 (in IPv4), or more complex newer alphanumeric IP addresses such as 2400:cb00:2048:1::c629:d7a2 (in IPv6).

What is a DNS resolver?
When a user requests to visit a web application like facebook.com, the user’s computer needs to know what server to connect to so that it can load the application. Computers don’t initially have the necessary information to do this ''name to address'' translation, so they ask a specialized server to do it for them.

This specialized server is called a DNS recursive resolver. The resolver’s job is to find the address for a given name, like 2400:cb00:2048:1::c629:d7a2 for cloudflare.com, and return it to the computer that asked for it.

Computers are configured to talk to specific DNS resolvers, identified by IP address. Usually the configuration is managed by the user’s ISP (like Comcast or AT&T) on home or wireless connections, and by an network administrator on office connections. Users can also manually change which DNS resolver their computers talk to.

Why use 1.1.1.1 instead of an ISP’s resolver?
The main reasons to switch to a third-party DNS resolver are security and performance. ISPs do not always use strong encryption on their DNS or support DNSSEC, which makes their DNS queries vulnerable to data breaches and exposes users to threats like man-in-the-middle attacks. In addition, ISPs often use DNS records to track their users’ activity and behavior. These resolvers don’t always have great speeds and when they get overloaded by heavy usage they become even more sluggish. If there is enough traffic on the network, an ISP’s recursor could stop answering requests altogether. In some cases attackers deliberately overload an ISP’s recursors, resulting in a denial-of-service.

DNS Hijacing
These downsides and risks of ISP recursors can be mitigated with a secure recursive DNS service like 1.1.1.1. With security features like bleeding-edge encryption and the fastest resolution speeds, 1.1.1.1 provides a better overall user experience.

What makes 1.1.1.1 more secure than other public DNS services?
Some other recursive DNS services may claim that their services are secure because they support DNSSEC. While this is a good security practice, users of these services are ironically not protected from the DNS companies themselves. Many of these companies collect data from their DNS customers to use for commercial purposes. Alternatively, 1.1.1.1 does not mine any user data. Logs are kept for 24 hours for debugging purposes, then they are purged.

1.1.1.1 also offers some security features not available from many other public DNS services, such as query name minimization. Query name minimization diminishes privacy leakage by only sending minimal query names to authoritative DNS servers.

What makes 1.1.1.1 the fastest recursive DNS service?
The power of the Cloudflare network makes gives 1.1.1.1 a natural advantage in terms of delivering speedy DNS queries. Since it has been deployed on Cloudflare’s 1000+ servers worldwide, users anywhere in the world will get a quick response from 1.1.1.1; in addition to this, these servers have access to the over 7 million domains on the Cloudflare platform, making queries for those domains lightning-fast.

DNS Speed Comparison
The best part of 1.1.1.1 is that in addition to being the fastest and most consumer-centered DNS, it's free to use. See how you can setup 1.1.1.1 in 5 minutes.

Virus Scanning

Web proxy Scanning

Active Directory
	To control users and computers on the internal network

Intrusion Detection

Separate Guest Network

Monitoring

Ticket System

# Docker Containers

grIDS
git submodule add https://github.com/gradiuscypher/grIDS.git
https://medium.com/@0xgradius/containerizing-my-nsm-stack-docker-suricata-and-elk-5be84f17c684

Suricata
git submodule add https://github.com/shift/docker-suricata.git

Trisul NSM
git submodule add https://github.com/trisulnsm/docker.git

T-Pot
git submodule add https://github.com/dtag-dev-sec/tpotce.git
git submodule add https://github.com/dtag-dev-sec/tpotce_archive.git
git submodule add https://github.com/dtag-dev-sec/t-pot-autoinstall.git


ClamAV
git submodule add https://github.com/tiredofit/docker-clamav.git
git submodule add https://github.com/mko-x/docker-clamav.git

RequestTracker
docker pull tutems/request-tracker
git submodule add https://github.com/jfcanaveral/docker-rt.git
docker pull netsandbox/request-tracker

Cacti
https://idroot.net/linux/install-cacti-monitoring-ubuntu-18-04-lts/
git submodule add https://github.com/QuantumObject/docker-cacti.git
docker pull quantumobject/docker-cacti

NAGIOS
git submodule  add  https://github.com/ethnchao/docker-nagios.git

MediaWiki
docker pull linuxconfig/mediawiki
https://linuxconfig.org/mediawiki-easy-deployment-with-docker-container

Shinken:
https://registry.hub.docker.com/u/rohit01/shinken/
https://registry.hub.docker.com/u/rohit01/shinken_thruk/
https://registry.hub.docker.com/u/rohit01/shinken_thruk_graphite/


Prometheus:
git submodule add https://github.com/prometheus/prometheus.git
git submodule add https://github.com/akhan4u/compose-prometheus.git
git submodule add https://github.com/stefanprodan/dockprom.git
git submodule add https://github.com/danguita/prometheus-monitoring-stack.git

DRDBackup



Each management and monitoring subsystem is a self contained Docker instance.
This is done to maintain efficiency and minimize the impact of an individual 
container being compromized.


# External Libraries Used



# Installation

