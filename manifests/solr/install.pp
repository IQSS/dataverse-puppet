# = Puppet module for dataverse.
# == Class: Iqss::Solr::Install
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
# Download the desired Solr package to the home directory.
#
class iqss::solr::install {

  $package_solr="solr-${iqss::solr::version}"
  $solr_url = "${iqss::solr::url}/${iqss::solr::version}/$package_solr.zip"

  anchor{ 'iqss::solr::install::begin': }

## create a solr user
  group {
    $iqss::solr::jetty_user:
      ensure => present,

  }
  user {
    $iqss::solr::jetty_user:
      ensure     => present,
      home       => $iqss::solr::parent_dir,
      managehome => true,
      groups     => $iqss::solr::jetty_user,
      require    => Anchor['iqss::solr::install::begin'],
  }

  notify {
    'parent dir':
      message => "Parent directory=${iqss::solr::parent_dir}" ;
  }->archive { 'apache-solr':
    ensure           => present,
    url              => $solr_url,
    target           => '/opt/solr', # Just a temporary place.
    follow_redirects => true,
    extension        => 'zip',
    checksum         => false,
    timeout          => 300,
    require          => User[$iqss::solr::jetty_user],
  }->exec { 'copy solr':
    command => "/usr/bin/rsync -av /opt/solr/$package_solr $iqss::solr::parent_dir",
    creates => $iqss::solr::solr_home;
  }

  anchor{ 'iqss::solr::install::end':
    require => Exec['copy solr'],
  }
}