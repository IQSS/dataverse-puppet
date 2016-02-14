#!/bin/bash
#
# Puppet module for dataverse
# Copyright (C) 2015
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# setup.sh
#
# Usage: ./setup [operating system] [environment=development|[what you would like]] [vagrant=0|1]
#
#
# Ensure that the packager manager's latest repository settings are up to date.
# Install the required puppet modules to provision the dataverse components.
# Maybe we will use Puppet library for that later on.
#
#
# Example: ./setup centos-6 masterless
#          Will install dataverse by pulling the dataverse module from github and run it in the masterless environment.
#
#
# This script will set an empty file '/opt/firstrun'
# Once there, future vagrant provisioning skip the update steps.
# Remove the file '/opt/firstrun' to repeat the update.

OPERATING_SYSTEM=$1
if [ -z "$OPERATING_SYSTEM" ] ; then
    echo "Operating system not specified"
    exit 1
fi

ENVIRONMENT=$2
if [ -z "$ENVIRONMENT" ] ; then
    ENVIRONMENT="development"
    echo "Environment not specified. Assuming ${ENVIRONMENT}"
fi


# Are we running with vagrant ? 0=no
VAGRANT=$3
if [ -z "$VAGRANT" ] ; then
    VAGRANT=0
fi
case $VAGRANT in
    0)
    ;;
    1)
    ;;
    *)
    echo "Invalid VAGRANT parameter. Must be 0 or 1."
        exit 1
    ;;
esac


# Tell:
echo "OPERATING_SYSTEM=${OPERATING_SYSTEM}"
echo "ENVIRONMENT=${ENVIRONMENT}"
echo "VAGRANT=${VAGRANT}"


# Working directory
WD=/opt


# puppet_config
# Set the puppet config to avoid warnings about deprecated templates.
function puppet_config {

    echo "[main]
    environment=${ENVIRONMENT}
    logdir=/var/log/puppet
    vardir=/var/lib/puppet
    ssldir=/var/lib/puppet/ssl
    rundir=/var/run/puppet
    factpath=/lib/facter

    [master]
    # This is a masterless puppet agent'," > /etc/puppet/puppet.conf
}


# install_module
# Pull a module from git and install it. If it is already there we will not do anything.
function install_module {
    name=$1
    package=$2
    repo=$3

    m=/etc/puppet/modules/$name
    if [ -d $m ] ; then
        echo "There is already a module in ${m}... skipping. If you want to reinstall, remove this module first manually"
    else
        wget -O /tmp/$package $repo
        puppet module install /tmp/$package
        rm -f /tmp/$package
    fi
}

function main {


    if [ ! -d $WD ] ; then
      mkdir -p $WD
    fi
    cd $WD


    # We will only update and install in the first provisioning step.
    # If ever you need to update again
    FIRSTRUN=$WD/firstrun
    if [ ! -f $FIRSTRUN ] ; then

        # Before we continue let us ensure we have puppet and run the latests packages at the first run.
        case $OPERATING_SYSTEM in
            centos-6)
                rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
                yum -y update
                yum -y install puppet
            ;;
            ubuntu-12|precise)
                wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
                dpkg -i puppetlabs-release-precise.deb
                apt-get -y update
                apt-get -y install puppet
            ;;
            ubuntu-14|trusty)
                wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
                dpkg -i puppetlabs-release-trusty.deb
                apt-get -y update
                apt-get -y install puppet
            ;;
            ubuntu-15|vivid)
                wget https://apt.puppetlabs.com/puppetlabs-release-vivid.deb
                dpkg -i puppetlabs-release-vivid.deb
                apt-get -y update
                apt-get -y install puppet
            ;;
            *)
                echo "Operating system ${OPERATING_SYSTEM} not supported."
                exit 1
            ;;
        esac


        puppet resource package puppet ensure=latest

        puppet_config

        # Install the non forged modules we need. These are declared in metadata.json.
        puppet module install camptocamp-archive --version 0.7.4
        puppet module install fatmcgav-glassfish --version 0.6.0
        puppet module install puppetlabs-java --version 1.4.3
        puppet module install jefferyb-shibboleth --version 0.3.1
        puppet module install puppetlabs-apache --version 1.5.0
        puppet module install puppetlabs-postgresql --version 4.3.0
        puppet module install rfletcher-jq --version 0.0.2

        # When we provision with vagrant, it will set a mount point to the iqss puppet module from the host.
        if [[ $VAGRANT -eq 0 ]] ; then
            # Then again, if not we install the module from the repository.
            install_module dataverse "lwo-dataverse-master.tar.gz" "https://github.com/IQSS/dataverse-puppet/archive/master.tar.gz"
        fi

        touch $FIRSTRUN
    else
        echo "Repositories are already updated and puppet modules are installed. To update and reinstall, remove the file ${FIRSTRUN}"
    fi

    # When we provision with vagrant, it will use it's puppet provisioner to apply the module.
    if [[ $VAGRANT -eq 0 ]] ; then
        # Then again if not then we will apply it manually here on the host.
        echo "Running puppet agent"
        if [ ! -e /etc/puppet/hiera.yaml ] ; then
            ln -s /etc/puppet/modules/dataverse/conf/hiera.yaml /etc/puppet/hiera.yaml
        fi
        puppet apply /etc/puppet/modules/dataverse/manifests/example.pp --debug
    fi
}

main

exit 0
