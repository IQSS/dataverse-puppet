# = Puppet module for dataverse.
# == Class: Dataverse::Tworavens::Packages
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
# Install the R packages. We make a special case for Zelig, because it is not in an R repo.

class dataverse::tworavens::packages {


# r packages from the repo
  create_resources(dataverse::rpackager::package, $dataverse::params::tworavens_packages)

  archive { 'Zelig-master': # installing package Zelig (from local GitHub). This is 5.0.6 at the time of writing.
    ensure           => present,
    url              =>  $dataverse::params::rpackager_packages_zelig,
    target           => '/opt/rpackager',
    follow_redirects => true,
    extension        => 'zip',
    checksum         => false,
  }

  exec { 'install Zelig-master':
    require => [Archive['Zelig-master'], Dataverse::Rpackager::Package['devtools']], # devtools must be declared in $dataverse::params::tworavens_packages
    command => "/usr/bin/rsync -av /opt/rpackager/Zelig-master /tmp/ && ${dataverse::rpackager::r_path} --vanilla --slave -e \"setwd('/tmp'); library(devtools); install('Zelig-master')\"",
    cwd     => '/tmp',
    unless  => "${dataverse::rpackager::r_path} -q -e 'installed.packages()' | grep '\"Zelig\"' | grep '\"5.0.6\"'",
  }

}