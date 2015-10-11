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
# Create the database, role ( user \ owner ) and access rules.
#
class iqss::database::config {

# Set the configuration rules.
  create_resources(postgresql::server::pg_hba_rule, $iqss::database::hba_rule, { })


# Install a user role, database and make the role owner of a database.
  postgresql::server::role {
    $iqss::database::user:
      password_hash => postgresql_password($iqss::database::user, $iqss::database::password),
      login         => $iqss::database::login,
      superuser     => $iqss::database::superuser,
      replication   => $iqss::database::replication,
      createdb      => $iqss::database::createdb,
      createrole    => $iqss::database::createrole;
  }->postgresql::server::database {
    $iqss::database::dbname:
      owner => $iqss::database::user,
  }

}