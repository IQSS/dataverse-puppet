# = Puppet module for dataverse.
# == Class: Dataverse::Rserve::Install
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
# Installs the RServe package.
#
class dataverse::rserve::install {

  dataverse::rpackager::package {
    'Rserve':
      r_path       => $dataverse::rpackager::r_path,
      r_contriburl => $dataverse::rpackager::r_contriburl,
      version      => 'latest'
  }

}