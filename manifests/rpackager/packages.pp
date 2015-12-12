# = Puppet module for dataverse.
# == Class: Dataverse::Rpackager::Packages
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

class dataverse::rpackager::packages {


# r packages from the repo
  create_resources(dataverse::rpackager::package, $dataverse::rpackager::packages, {
    r_path  => $dataverse::rpackager::r_path,
    repo    => $dataverse::rpackager::repo,
    version => 'latest' }
  )

  archive { 'Zelig-master': # installing package Zelig (from local GitHub). This is 5.0.5 at the time of writing.
    ensure           => present,
    url              => $dataverse::rpackager::packages_zelig,
    target           => '/opt/rpackager',
    follow_redirects => true,
    extension        => 'zip',
    checksum         => false,
  }

  exec { 'install Zelig-master':
    require => [Archive['Zelig-master'], Dataverse::Rpackager::Package['devtools']], # devtools must be declared in $dataverse::rpackager::packages_r
    command => "/usr/bin/rsync -av /opt/rpackager/Zelig-master /tmp/ && ${dataverse::rpackager::r_path} --vanilla --slave -e \"setwd('/tmp'); library(devtools); install('Zelig-master')\"",
    cwd     => '/tmp',
    unless  => "${dataverse::rpackager::r_path} -q -e 'installed.packages()' | grep '\"Zelig\"' | grep '\"5.0.6\"'",
  }

}