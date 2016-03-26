# = Puppet module for dataverse.
# == Class: Dataverse::Java::Repo
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# Private class. Do not use directly.
#
# For Ubuntu we will fall back on the build from Oracle. We need not do so for more recent versions of
# Ubuntu, but rather than make an exeption for Ubuntu 12, we just use the Oracle installation utility to cover all
# of the Ubuntu releases.
#
# By installing the dataverse module on Ubuntu you implicitly agree to the Oracle Licence agreement.
#
# For other OS families we fall back on their repository.
#
# === Variables
#
# [java8_openjdk_package='java-1.8.0-openjdk-devel'|'oracle-java8-installer']
#  The java package.

class dataverse::java::repo {

# Set package names based on Operating System...
  case $::osfamily {
    'RedHat' : {
      $package = 'java-1.8.0-openjdk-devel'
      $java_alternative = 'java-1.8.0'
      $java_alternative_path = '/usr/lib/jvm/jre-1.8.0-openjdk.x86_64/bin/java'
    }
    'Debian' : {
      $package = 'oracle-java8-installer'
      $java_alternative = 'java-8-oracle'
      $java_alternative_path = '/usr/lib/jvm/java-8-oracle/bin/java'

      include ::apt
      apt::source { 'webupd8team':
        comment    => 'Oracle Java 8 installer',
        key        => 'EEA14886',
        key_server => 'hkp://keyserver.ubuntu.com:80',
        location   => 'http://ppa.launchpad.net/webupd8team/java/ubuntu',
        release    => $lsbdistcodename,
        repos      => 'main',
      }

      exec { 'accept-java-license':
        unless  => "update-alternatives --list java|grep java-8-oracle 2>/dev/null",
        command => 'echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections',
        require => Apt::Source['webupd8team'],
        path    => ['/usr/bin/','/bin/'],
      }

      notify {
        'accept-java-license':
          message => 'By installing the dataverse module on Ubuntu you implicitly agree with the terms in the Oracle Licence agreement.',
      }
    }
    default : {
      fail("${::osfamily} not supported by this module.")
    }
  }

}