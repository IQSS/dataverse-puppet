# = Puppet module for dataverse.
# == Class: Iqss::Database::Config
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
#
class iqss::database::install {

# Add a pg user
  user {
    $iqss::globals::database_user:
      ensure     => present,
  }

# Install postgresql
  class { 'postgresql::globals':
    version                        => $iqss::database::version,
    manage_package_repo            => $iqss::database::manage_package_repo,
    encoding                       => $iqss::database::encoding,
    locale                         => $iqss::database::locale,
  }->class { 'postgresql::server':
    listen_addresses               => $iqss::database::listen_addresses,
  }

}