class iqss::database::config {

# Set the configuration rules.
  create_resources(postgresql::server::pg_hba_rule, $iqss::database::hba_rule, { })


# Install a user role, database and make the role owner of a database.
  postgresql::server::role {
    $iqss::params::database_user:
      password_hash => postgresql_password($iqss::params::database_user, $iqss::params::database_password),
      login         => $iqss::database::login,
      superuser     => $iqss::database::superuser,
      replication   => $iqss::database::replication,
      createdb      => $iqss::database::createdb,
      createrole    => $iqss::database::createrole;
  }->postgresql::server::database {
    $iqss::params::database_name:
      owner    => $iqss::params::database_user,
  }

}