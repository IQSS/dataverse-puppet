#!/bin/bash
#
# setup.sh
#
# Usage: ./setup [operating system] [environment]
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
    echo "Environment not specified. Assumping ${ENVIRONMENT}"
fi


# Are we running with vagrant ?
VAGRANT="0$(facter vagrant)"


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
        sudo wget -O /tmp/$package $repo
        sudo puppet module install /tmp/$package
        sudo rm -f /tmp/$package
    fi
}

function main {


    if [ ! -d $WD ] ; then
      sudo mkdir -p $WD
    fi
    cd $WD


    # We will only update and install in the first provisioning step.
    # If ever you need to update again
    FIRSTRUN=$WD/firstrun
    if [ ! -f $FIRSTRUN ] ; then

        # Before we continue let us ensure we have puppet and run the latests packages at the first run.
        case $OPERATING_SYSTEM in
            centos*)
                sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
                sudo yum -y update
            ;;
            ubuntu-12|precise)
                sudo wget https://apt.puppetlabs.com/puppetlabs-release-precise.deb
                sudo dpkg -i puppetlabs-release-precise.deb
                sudo apt-get -y update
            ;;
            ubuntu-14|trusty)
                sudo wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
                sudo dpkg -i puppetlabs-release-trusty.deb
                sudo apt-get -y update
            ;;
            ubuntu-15|vivid)
                sudo wget https://apt.puppetlabs.com/puppetlabs-release-vivid.deb
                sudo dpkg -i puppetlabs-release-vivid.deb
                sudo apt-get -y update
            ;;
            *)
                echo "Operating system ${OPERATING_SYSTEM} not supported."
                exit 1
            ;;
        esac


        sudo puppet resource package puppet ensure=latest

        puppet_config

        # Install the non forged modules we need. We should use puppet library for this.
        install_module glassfish "fatmcgav-glassfish-0.6.0.tar.gz" "https://github.com/IISH/fatmcgav-glassfish/archive/dataverse.tar.gz"
        sudo puppet module install puppetlabs-postgresql --version 4.3.0
        sudo puppet module install puppetlabs-apache --version 1.5.0
        sudo puppet module install rfletcher-jq --version 0.0.2
        sudo puppet module install camptocamp-archive --version 0.7.4
        sudo puppet module install jefferyb-shibboleth --version 0.3.1

        # When we provision with vagrant, it will set a mount point to the iqss puppet module from the host.
        # If not then we install the module from the repository.
        if [ $VAGRANT -eq 0 ] ; then
            install_module iqss "iqss-iqss-4.0.1.tar.gz" "https://github.com/IQSS/dataverse-puppet/archive/4.0.1.tar.gz"
        fi

        sudo touch $FIRSTRUN
    else
        echo "Repositories are already updated and puppet modules are installed. To update and reinstall, remove the file ${FIRSTRUN}"
    fi

    # When we provision with vagrant, it will use puppet to apply the module.
    # If not then we will apply it manually here.
    if [ $VAGRANT -eq 0 ] ; then
        echo "Running puppet agent"
        if [ ! -e /etc/puppet/hiera.yaml ] ; then
            ln -s /etc/puppet/modules/iqss/conf/hiera.yaml /etc/puppet/hiera.yaml
        fi
        sudo puppet apply /etc/puppet/modules/iqss/manifests/example.pp --debug
    fi
}

main

exit 0
