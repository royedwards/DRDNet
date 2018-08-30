# About

This describes the hardware, OS, software, and configuration requirements for the Base Linux Virtual Server.


# Hardware 

This system was designed to run under a bare metal server running Ubuntu 18.04LTS.

Any system with at least 16 cores, 128GB of RAM, 4 10Gb Fiber Ethernet ports, and at least 2TB of SSD will run the entire system at full speed.  You can use a smaller machine in an emergency scenerio but it will suffer performance impacts from the lesser hardware.  

The machine specified was a Supermicro Xeon with the following specs:

* 2 E5-2698 v3 CPUs (16 Cores)
* 128GB of RAM
* 256MB Solid State System Drive
* 2TB raw SSD Disk Array in Raid-5 Mode
* 4 10GbE fiber ports

If this machine were to fail, It could be rented and delivered within 2 hours from American Computers and Engineers for the current price of $540/month until the system can be replaced. 
 
https://www.aceca.com/workstations.html


# Software

The base Linux Virtual server is can quickly be installed by the following steps.

Install the base Ubuntu 18.04LTS system on the internal SSD.  

The image can be obtainted from here:

http://releases.ubuntu.com/18.04/


On a machine booted with Linux copy the Ubuntu ISO image to a USB stick:

You can find the device name for the USB stick by executing the following command and finding the last device of the size of the USB stick:

	# less /proc/partitions

Once you have the device name in the form of /dev/sdX, create a bootable USB image from the ISO you downloaded.

	# dd if=/path/to/ubuntu_18.04.iso of=/dev/sd<usbstick drive letter> bs=4M conv=sync status=progress

Configure the SSD array as a RAID-5 Volume (This process varies from controller to controller but is well documented)

Boot the Server machine with the Ubuntu 18.04 USB Install stick

Initial installation answer to questions

Make the hostname MiniM

Make the following network settings:

* Static Configuration
* IP address 192.168.88.x
* netmask 255.255.255.0
* gateway 192.168.88.1
* DNS 192.168.88.10. 1.1.1.1
* domain drdnet.local

Use the option for the default installation using the entire drive and everything in one partition.

Make the default user account "tech" and the "tech password" documented elsewhere

Perform the install and reboot.

# Customizing the installation

We need to add a few base packages to create the environment that we need.

Update the current system to the latest versions of software available.

	# sudo bash
	# apt-get update
	# apt-get upgrade

The system is now up to date, reboot so that you are using the latest kernel and software versions.

Now we will add specific software to create the environment that we want.

Install the Gnome Windowning environment and the gdm3 login manager.

	# apt-get -y install blah-blah-blah

Setup NTP so that all of our times are locked together across machines.

	# apt-get install ntpdate
	# ntpdate 0.pool.ntp.org

Install OpenSSH Server

	# apt-get -y install openssh-server 

Install foregin filesytem types

	# apt-get -y cifs-tools hfsprogs hfsutils hfsplus hfsutils-tcltk xfxprogs xfsdump smbclient smb4k ntfs-config ntfs-3g

Install Ubuntu Unity Gnome Desktop Environment

	# apt -y install tasksel
	# apt tasksel install ubuntu-desktop

Install utilities

	# apt-get -y install p7zip-full wireshark phpmyadmin

Install Remote Desktop Environment

	$ sudo apt install remmina	

Reboot to switch to the new virtualbox enabled kernel and modules

# Install the virtualbox Environment

Login as user "tech"

Step 1: Add VirtualBox Repository Key

To install VirtualBox repositories, you must first add the repository key… the key allows Ubuntu to authenticate and validate that all packages downloaded from the repository are trusted and signed with the repository key… this adds a layer of security

To add the repository key, run the commands below:

	$ wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
	$ wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

Step 2: Add VirtualBox Repository

Now that the repository key is added to Ubuntu system, run the commands below to add the Repository

	$ sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list.d/virtualbox.list'

After that, run the commands below to update Ubuntu repositories..

Step 3: Installing VirtualBox
At this point, the Ubuntu system should be ready to install the latest version of VirtualBox…

Run the commands below to install some requirement packages for VirtualBox

	$ sudo apt update
	$ sudo apt-get -y install gcc make linux-headers-$(uname -r) dkms

Finally, run the commands below to install the latest version of the software.

	$ sudo apt update
	$ sudo apt-get -y install virtualbox-5.2

You should have the latest version of VirtualBox installed after running the above commands… Now go to search for the package and launch it.


# Configurations

All base configurations should alredy be performed but there are a copy of all changed configuration files in a tree that starts from / in a directory called configfile_systemtree

