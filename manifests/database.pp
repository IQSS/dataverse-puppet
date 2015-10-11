# = Puppet module for dataverse.
# == Class: Iqss::Database
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# Install a PostgreSQL database and configure roles, access database.
#
# === Parameters
#
# [createdb=false|true]
#   The user can create database.
#
# [createrole=false|true]
#   The user can create roles.
#
# [dbname='dvndb']
#   Name of the database.
#
# [encoding='utf-8']
#   This will set the default encoding encoding for all databases created with this module. On certain operating systems
#   this will be used during the template1 initialization as well so it becomes a default outside of the module too.
#
# [hba_rule]
#   The access rules that determine who can connect to what database from where.
#
# [listen_address='*']
#   This value defaults to `*`, meaning the postgres server will accept connections accept connections from any remote
#   machine. Alternately, you can specify a comma-separated list of hostnames or IP addresses. (For more info, have a
#   look at the `postgresql.conf` file from your system's postgres package).
#
# [locale='en_US.UTF-8']
#   This will set the default database locale for all databases created with this module.
#
# [login=true|false]
#   The fact the user can login or not.
#
# [manage_package_repo=true|false]
#   Setup the official PostgreSQL repositories on your host.
#
# [password='dvnAppPass']
#   The password for the database user.
#
# [replication=false|true]
#   This role can replicate.
#
# [superuser=false|true]
#   This role is a superuser.
#
# [user='dvnApp']
#   The name of the database owner.
#
# [version='9.3']
#   The version of PostgreSQL.

class iqss::database (
  $createdb                = $iqss::params::database_createdb,
  $createrole              = $iqss::params::database_createrole,
  $dbname                  = $iqss::params::database_dbname,
  $encoding                = $iqss::params::database_encoding,
  $hba_rule                = $iqss::params::database_hba_rule,
  $listen_addresses        = $iqss::params::database_listen_addresses,
  $locale                  = $iqss::params::database_locale,
  $login                   = $iqss::params::database_login,
  $manage_package_repo     = $iqss::params::database_manage_package_repo,
  $password                = $iqss::params::database_password,
  $replication             = $iqss::params::database_replication,
  $superuser               = $iqss::params::database_superuser,
  $user                    = $iqss::params::database_user,
  $version                 = $iqss::params::database_version,
) inherits iqss::params {

  anchor { 'iqss::database::start': }->
  class { 'iqss::database::install': }->
  class { 'iqss::database::config': }->
  anchor { 'iqss::database::end': }

}