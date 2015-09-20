Apply the dataverse module with a masterless agent
==================================================

You can install the applications on host on the internet or on your laptop or PC. In this setup we will install 
dataverse with a masterless puppet agent. That is: all the configuration, settings ( passwords too ) and the module
live on the target host.

###Prerequisites

The module is tested on Centos 6 and Ubuntu 12 and 14, so make sure that is installed on your host machine.

###Install the setup file

Download the setup file from the dataverse-puppet repository with curl or wget:

    $ wget https://github.com/IQSS/dataverse-puppet/blob/4.0.1/setup.sh
    
Then start it up:

    $ chmod 744 setup
    $ ./setup.sh [your operating system] masterless
    
Valid os values are 'centos-6', 'ubuntu-12' and 'ubuntu-14'.

###Post installation
 
The installation is finished when you see lots of blue lines. Typically, it may take another two minutes for dataverse to
startup before you can use it.


### Trouble shooting

####1. When installing you get a 'Timeout...' or  'Connection failed [IP: .......' error.

Or downloads seem to timeout. Suggestion: check if you are not blocked by a firewall. Or sometimes the internet is just busy. If so, try again, this time direectly with:

    $ sudo puppet apply /etc/puppet/modules/iqss/manifests/example.pp --debug

####2. Centos: Execution of '/usr/bin/yum -d 0 -e 0 -y install ...' returned 1 

On Centos you may get the Error: Execution of '/usr/bin/yum -d 0 -e 0 -y install ...' returned 1: Error: Nothing to do

Here yum reports an error when the package is in fact installed. Should this happen then repeat the provisioning once:

    $ sudo puppet apply /etc/puppet/modules/iqss/manifests/example.pp --debug

