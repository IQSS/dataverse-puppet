# = Puppet module for dataverse.
# == Class: Dataverse::Database::Config
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
# Install PostgreSQL.

class dataverse::database::install {

# Add a pg user
  user {
    $dataverse::database::database_user:
      ensure     => present,
  }

# Install postgresql
  class { 'postgresql::globals':
    version                        => $dataverse::database::version,
    manage_package_repo            => $dataverse::database::manage_package_repo,
    encoding                       => $dataverse::database::encoding,
    locale                         => $dataverse::database::locale,
  }->class { 'postgresql::server':
    listen_addresses               => $dataverse::database::listen_addresses,
  }

}