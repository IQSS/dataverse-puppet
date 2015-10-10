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
# [default_confd_files=false|true]
#   Generates default set of include-able Apache configuration files under  `${apache::confd_dir}` directory. These
#   configuration files correspond to what is usually installed with the Apache package on a given platform.
#
# [default_mods=false|true]
#   Installs default Apache modules based on what OS you are running.
#
# [default_ssl_vhost=false|true]
#   Sets up a default SSL virtual host.
#
# [default_vhost=false|true]
#   Sets a given `apache::vhost` as the default to serve requests that do not match any other `apache::vhost`
#   definitions.
#
# [purge_configs=false|true]
#   Removes all other Apache configs and vhosts. Setting this to 'false' is a stopgap measure to allow the apache module
#   to coexist with existing or otherwise-managed configuration.
#

class iqss::apache2 (
  $default_confd_files = $iqss::params::apache2_default_confd_files,
  $default_mods        = $iqss::params::apache2_default_mods,
  $default_ssl_vhost   = $iqss::params::apache2_default_ssl_vhost,
  $default_vhost       = $iqss::params::apache2_default_vhost,
  $purge_configs       = $iqss::params::apache2_purge_configs,
) inherits iqss::params {

  anchor { 'iqss::apache2::start': }->
  class { 'iqss::apache2::install': }->
  class { 'iqss::apache2::shibboleth': }->
  anchor { 'iqss::apache2::end': }

}