# = Puppet module for dataverse.
# == Class: Iqss::Rpackager::Packages
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
# Install the R packages.
#
class iqss::rpackager::packages {

  $r_path       = '/usr/bin/R'


# r packages from the repo
  create_resources(iqss::rpackager::package, $iqss::rpackager::packages, {
    repo => $iqss::rpackager::repo,
    r_path  => $r_path,
    version => 'latest' }
  )

  archive { 'Zelig-master': # installing package Zelig (from local GitHub). This is 5.0.5 at the time of writing.
    ensure           => present,
    url              => $iqss::rpackager::packages_zelig,
    target           => '/opt/rpackager',
    follow_redirects => true,
    extension        => 'zip',
    checksum         => false,
  }

  exec { 'install Zelig-master':
    require => [Archive['Zelig-master'], Iqss::Rpackager::Package['devtools']], # devtools must be declared in $iqss::rpackager::packages_r
    command => "/usr/bin/rsync -av /opt/rpackager/Zelig-master /tmp/ && ${r_path} --vanilla --slave -e \"setwd('/tmp'); library(devtools); install('Zelig-master')\"",
    cwd     => '/tmp',
    unless  => "$r_path -q -e 'installed.packages()' | grep '\"Zelig\"' | grep '\"5.0.5\"'",
  }

}