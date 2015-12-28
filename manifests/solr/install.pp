# = Puppet module for dataverse.
# == Class: Dataverse::Solr::Install
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
class dataverse::solr::install {

  $package_solr="solr-${dataverse::solr::version}"
  $solr_url = "${dataverse::solr::url}/${dataverse::solr::version}/${package_solr}.zip"

  anchor{ 'dataverse::solr::install::begin': }

## create a solr user
  group {
    $dataverse::solr::jetty_user:
      ensure => present,

  }
  user {
    $dataverse::solr::jetty_user:
      ensure     => present,
      home       => $dataverse::solr::parent_dir,
      managehome => true,
      groups     => $dataverse::solr::jetty_user,
      require    => Anchor['dataverse::solr::install::begin'],
  }

  notify {
    'parent dir':
      message => "Parent directory=${dataverse::solr::parent_dir}" ;
  }->archive { 'apache-solr':
    ensure           => present,
    url              => $solr_url,
    target           => '/opt/solr', # Just a temporary place.
    follow_redirects => true,
    extension        => 'zip',
    checksum         => false,
    timeout          => 300,
    require          => User[$dataverse::solr::jetty_user],
  }->exec { 'copy solr':
    command => "/usr/bin/rsync -av /opt/solr/${package_solr} ${dataverse::solr::parent_dir}",
    creates => $dataverse::solr::solr_home;
  }

  anchor{ 'dataverse::solr::install::end':
    require => Exec['copy solr'],
  }
}