# Puppet module for dataverse
# Copyright (C) 2015 {name of author}
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
# == Class: iqss::solr
#
# Installs Solr together with the dataverse schema.
# Also see: http://lucene.apache.org/solr
#
# === Parameters
# [parameter='default'[|alternatives]]
#   Description
#
# [core='collection1']
#   The handle of the Solr core.
#
# [jetty_home='/home/solr-4.6.0/example']
#   The Jetty home directory which contains start.jar.
#
# [jetty_host='0.0.0.0']
#   The IP to listen to.
#
# [jetty_java_options='-Xmx512m']
#   JVM options for the Jetty container.
#
# [jetty_port=8983]
#    The port Jetty will listen to.
#
# [jetty_user='solr']
#   The user running the Jetty Solr instance.
#
# [parent_dir='/home/solr-${solr_version}']
#
# === Examples
#
#   class { iqss:solr
#     parent_dir => '/usr/share',
#   }
#
class iqss::solr (
  $core               = $iqss::params::solr_core,
  $jetty_home         = $iqss::params::solr_jetty_home,
  $jetty_host         = $iqss::params::solr_jetty_host,
  $jetty_java_options = $iqss::params::solr_jetty_java_options,
  $jetty_port         = $iqss::params::solr_jetty_port,
  $jetty_user         = $iqss::params::solr_jetty_user,
  $parent_dir         = $iqss::params::solr_solr_parent_dir,
  $solr_home          = $iqss::params::solr_solr_home,
  $url                = $iqss::params::solr_url,
  $version            = $iqss::params::solr_version,
) inherits iqss::params {

## === Variables === ##
  anchor{ 'iqss::solr::begin': }

  class{ 'iqss::solr::install':
    require => Anchor['iqss::solr::begin'],
  }

  class{ 'iqss::solr::config':
    require => Class['iqss::solr::install'],
  }

  class{ 'iqss::solr::service':
    subscribe => Class['iqss::solr::config'],
  }

  anchor{ 'iqss::solr::end':
    require => Class['iqss::solr::service'],
  }
}