# = Puppet module for dataverse.
# == Class: Iqss::Globals
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# Sets the shared settings for the iqss classes. Child classes can override these settings.
# Ensure the base packages that fascilitate the installation are available:
#  - unzip.
#
# === Parameters
#
# [apache2_purge_configs=false|true]
#   Removes all other Apache configs and vhosts. Setting this to 'false' is a stopgap measure to allow the apache module
#   to coexist with existing or otherwise-managed configuration.
#
# [dataverse_fqdn='localhost']
#   If the Dataverse server has multiple DNS names, this option specifies the one to be used as the "official" hostname.
#   For example, you may want to have dataverse.foobar.edu, and not the less appealing server-123.socsci.foobar.edu to
#   appear exclusively in all the registered global identifiers, Data Deposit API records, etc.
#
# [dataverse_port=443]
#   The public port of the Dataverse web application.
#
# [database_host='localhost']
#   The domain of the database.
#
# [database_dbname='dvndb']
#   The name of the database.
#
# [database_password='dvnAppPass']
#   The password for the database user.
#
# [database_port=5432]
#   The port of the database.
#
# [database_user='dvnApp']
#   The name of the database owner.


class iqss::globals (
  $apache2_purge_configs       = true,
  $dataverse_fqdn              = 'localhost',
  $dataverse_port              = 443,
  $database_dbname             = 'dvndb',
  $database_host               = 'localhost',
  $database_password           = 'dvnAppPass',
  $database_port               = 5432,
  $database_user               = 'dvnApp',
  $rserve_pwd                  = 'rserve'
) {
  package {
    ['unzip']:
      ensure => installed,
  }
}