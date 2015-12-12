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
# Create the database, role ( user \ owner ) and access rules.

class dataverse::database::config {

# Set the configuration rules.
  create_resources(postgresql::server::pg_hba_rule, $dataverse::database::hba_rule, { })


# Install a user role, database and make the role owner of a database.
  postgresql::server::role {
    $dataverse::database::user:
      password_hash => postgresql_password($dataverse::database::user, $dataverse::database::password),
      login         => $dataverse::database::login,
      superuser     => $dataverse::database::superuser,
      replication   => $dataverse::database::replication,
      createdb      => $dataverse::database::createdb,
      createrole    => $dataverse::database::createrole;
  }->postgresql::server::database {
    $dataverse::database::dbname:
      owner => $dataverse::database::user,
  }

}