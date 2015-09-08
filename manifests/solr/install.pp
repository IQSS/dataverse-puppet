# == Class: solr::install
#
# Full description of class solr here.
#
# === Parameters
#
#
# === Variables
#
#
# === Examples
#
#  class { 'solr':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Copyright
#
# GPL-3.0+
#
class iqss::solr::install {

  anchor{ 'iqss::solr::install::begin': }

## create a solr user
  user { $iqss::solr::jetty_user:
    ensure     => present,
    home       => $iqss::solr::solr_parent_dir,
    managehome => false,
    shell      => '/bin/bash',
    require    => Anchor['iqss::solr::install::begin'],
  }

  $package_solr="solr-${iqss::solr::version}"
  $target_solr=dirname($iqss::solr::solr_parent_dir)

  $solr_url = "${iqss::solr::url}/${iqss::solr::version}/$package_solr.zip"
  archive { 'apache-solr':
    ensure           => present,
    url              => $solr_url,
    target           => '/opt/solr', # Just a temporary place.
    follow_redirects => true,
    extension        => 'zip',
    checksum         => false,
    timeout          => 300,
    require          => User[$iqss::solr::jetty_user],
  }->exec { 'copy solr':
    command => "/usr/bin/rsync -av /opt/solr/$package_solr $target_solr",
    creates => $iqss::solr::solr_home;
  }

  anchor{ 'iqss::solr::install::end':
    require => Exec['copy solr'],
  }
}