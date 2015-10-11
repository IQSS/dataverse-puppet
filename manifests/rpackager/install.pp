# = Puppet module for dataverse.
# == Class: Iqss::Rpackager::Install
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
# Install all the desired libraries needed to build R packages.
#
class iqss::rpackager::install {

  package {
    $iqss::rpackager::rpackager_rstudio_libraries:
      ensure => installed,
  }

}