# = Puppet module for dataverse.
# == Class: Dataverse::Dataverse::War
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
# Download the war

class dataverse::dataverse::war {

# We only need maven for the development environment
  if $dataverse::dataverse::repository == 'git' {

    archive { 'maven3':
      ensure           => present,
      url              => 'ftp://mirror.reverse.net/pub/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.zip',
      target           => '/usr/src', # Just a temporary place.
      follow_redirects => true,
      extension        => 'zip',
      checksum         => false,
    }->exec { 'copy maven3':
      command => '/usr/bin/rsync -av /usr/src/apache-maven-3.3.3/ /usr/share/maven',
      creates => '/usr/share/maven';
    }

    file {
      '/usr/bin/mvn':
        ensure => link,
        target => '/usr/share/maven/bin/mvn';
      '/usr/bin/mvnDebug':
        ensure => link,
        target => '/usr/share/maven/bin/mvnDebug';
    }

    package {
      'git':
        ensure => present;
    }

    file {
      '/usr/src':
        ensure => directory ;
    }->exec {
      'clone the repository':
        command => '/usr/bin/git clone git@github.com:IQSS/dataverse.git',
        cwd     => '/usr/src' ;
    }->exec {
      'build the war': # We assume as we run 'local' this is the root of the code base in /dataverse
        command => "/usr/bin/mvn clean package && rsync -av /usr/src/dataverse/target/${dataverse::dataverse::_package}.war /usr/src/${dataverse::dataverse::_package}.war",
        cwd     => '/usr/src/dataverse' ;
    }

  } else {

    exec {
      'Download the file': # Note that if this download fails, the file is corrupt. Remove it then.
        command => "/usr/bin/wget --no-check-certificate -O /usr/src/${dataverse::dataverse::_package}.war ${dataverse::dataverse::repository}",
        unless  => "/usr/bin/test -f /usr/src/${dataverse::dataverse::_package}.war" ;
    }

  }


# For the console API command handling.
  include jq

  file {
    '/usr/bin/jq':
      ensure => link,
      target => '/usr/local/bin/jq',
  }

  file {
    '/opt/dataverse':
      ensure  => file,
      recurse => true,
      source  => "puppet:///modules/dataverse/${dataverse::dataverse::_package}";
  }

}