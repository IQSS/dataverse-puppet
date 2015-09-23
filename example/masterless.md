Apply the dataverse module with a masterless agent
==================================================
In this setup we will install 
dataverse with a masterless puppet agent. That is: all the configuration, settings ( passwords too ) and the module
live on the target host which resides somewhere on the internet or your intranet so a group of people can take a look at it.

###Prerequisites

* The module is tested on Centos 6.5 and Ubuntu 12 and 14 with Puppet agent 3.x. Installations on other platforms may fail.
* It is preferable the machine you are targeting is 'clean': no other software is installed on it. If there is, it probably does not matter,
but there may be conflicts if you already have R, Java, Glassfish, PostgreSQL or Solr installed.
* Check out the known issues in the [main readme file](../README.md#known-issues).

###Install the setup file

Download the setup file from the dataverse-puppet repository with curl or wget and give it executable persmissions:

    $ wget https://raw.githubusercontent.com/IQSS/dataverse-puppet/4.0.1/conf/setup.sh
    $ sudo chmod 744 setup.sh
    
Then start it up:

    $ sudo ./setup.sh [your operating system] masterless
    
Valid os values are 'centos-6', 'ubuntu-12' and 'ubuntu-14'.

###Explanation: where do the settings come from ?

Default settings like passwords and file locations are hard wired in the puppet module code.

You can override those settings when declaring a class in the example: /etc/puppet/modules/iqss/manifests/example.pp

Another way to try out settings is the hieradata. As you specified the environment parameter as 'masterless', the configuration in

    /etc/puppet/modules/iqss/conf/hieradata/masterless.json
    {
        "iqss::globals::dataverse_fqdn": "%{::fqdn}",
        "iqss::dataverse::site_url": "https://%{::fqdn}",
        "iqss::tworavens::dataverse_fqdn": "%{::fqdn}",
        "iqss::tworavens::domain":"%{::fqdn}"
    }

    will replacing the default `localhost` with that of your machine.

###Post installation
 
The installation is finished when you see lots of blue lines and the console prompt. Typically, it may take another two minutes for dataverse to
startup before you can use it.

### Trouble shooting

####1. When installing you get a 'Timeout...' or  'Connection failed [IP: .......' error.

Or downloads seem to timeout. Suggestion: check if you are not blocked by a firewall. Or sometimes the internet is just busy. If so, try again, this time direectly with:

    $ sudo puppet apply /etc/puppet/modules/iqss/manifests/example.pp --debug

####2. Centos: Execution of '/usr/bin/yum -d 0 -e 0 -y install ...' returned 1 

On Centos you may get the Error: Execution of '/usr/bin/yum -d 0 -e 0 -y install ...' returned 1: Error: Nothing to do

Here yum reports an error when the package is in fact installed. Should this happen then repeat the provisioning once:

    $ sudo puppet apply /etc/puppet/modules/iqss/manifests/example.pp --debug

