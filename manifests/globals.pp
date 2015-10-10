# Puppet module for dataverse
# Copyright (C) 2015
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# == Class: iqss::globals
#
# Install the shared settings for the iqss classes.
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
# [database_name='dvndb']
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
  $database_host               = 'localhost',
  $database_name               = 'dvndb',
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