# = Puppet module for dataverse.
# == Class: Dataverse::Rpackager::Install
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
class dataverse::rpackager::install {

  package {
    $dataverse::rpackager::rpackager_rstudio_libraries:
      ensure => installed,
  }

}