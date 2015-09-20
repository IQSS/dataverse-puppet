Apply the dataverse module with vagrant
=======================================

You can install the applications in a local virtual host on your laptop or PC using vagrant. In this setup vagrant will use puppet to
install the required software. This is usually something for developers and those who want to explore an out-of-the-box application and see what it does.

###Prerequisites

Download and install

* [Virtual box](https://www.virtualbox.org/)
* [Vagrant v2](https://docs.vagrantup.com/)

And clone [This puppet module](https://github.com/IQSS/dataverse-puppet) from github.

###Select your operating system

The module is tested on Centos 6.5 and Ubuntu 12 and 14. To select the operating system, set your environmental variable:

    $ export OPERATING_SYSTEM=centos-6:default|ubuntu-12|ubuntu-14

'centos-6' will target Centos 6.5

'ubuntu-12' will target Ubuntu 12.04 lts (precise)

'ubuntu-14' will target Ubuntu 14.04 lts (trusty)

###Run vagrant

Start vagrant from within the dataverse-puppet folder with:

    $ vagrant up
    
To begin the setup procedure.

###Post installation
 
The installation is finished when you see lots of blue lines. Typically, it may take another two minutes for dataverse to
startup before you can use it.

In the vagrant setup, the ports are forwarded thus:

https://localhost:9999 will direct your browser or API client to the clients apache on port 443.

You can ssh to the vagrant machine from the dataverse-puppet folder with:

    $ vagrant ssh

### Trouble shooting

####1. Error: 'A host only network interface... via DHCP....'

[See issue github.com/mitchellh/vagrant/3341](https://github.com/mitchellh/vagrant/issues/3083)

If you get this error it means you have a conflict between two DHCP providers: your host machine and virtualbox which
runs the virtual box. Suggestion: disable the virtualbox DHCP provider on your host:

    $ VBoxManage dhcpserver remove --netname HostInterfaceNetworking-vboxnet0

####2. On Ubuntu the error: 'Failed to mount folders in Linux guest...'

[See issue github.com/mitchellh/vagrant/3341](https://github.com/mitchellh/vagrant/issues/3341)

The virtual box cannot mount with /vagrant to your host filesystem. Suggestion #1: add a symbolic link in the client and reload the VM. On your VM:

    $ sudo ln -s /opt/VBoxGuestAdditions-4.3.10/lib/VBoxGuestAdditions /usr/lib/VBoxGuestAdditions

On your host:

    $ vagrant reload
    $ vagrant provision

If that does not work, try [suggestion #2](https://www.virtualbox.org/manual/ch04.html):

Install the guest additions on your VM:

    $ sudo apt-get update
    $ sudo apt-get install virtualbox-guest-dkms

And on your host

    $ vagrant reload
    $ vagrant provision


####3. Out of memory when installing R packages.

Suggestion: increase the 'v.customize ["modifyvm", :id, "--memory", "2048"]' setting in the Vagrantfile.

####4. When installing you get a 'Timeout...' or  'Connection failed [IP: .......' error.

Or downloads seem to timeout. Suggestion: check if you are not blocked by a firewall. Or sometimes the internet is just busy. If so, try again:

    $ vagrant provision

####5. Centos: Execution of '/usr/bin/yum -d 0 -e 0 -y install ...' returned 1 

On Centos you may get the Error: Execution of '/usr/bin/yum -d 0 -e 0 -y install ...' returned 1: Error: Nothing to do

Here yum reports an error when the package is in fact installed. Should this happen then repeat the provisioning once:

    $ vagrant provision

