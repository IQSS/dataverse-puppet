# = Puppet module for dataverse.
# == Class: dataverse::solr::config
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
# Setup the container Jetty service for Solr plus the configuration files.
#
class dataverse::solr::config {

  anchor{ 'dataverse::solr::config::begin': }->file{
    $dataverse::solr::jetty_home:
      ensure  => directory,
      owner   => $dataverse::solr::jetty_user,
      group   => $dataverse::solr::jetty_user,
      recurse => true;
    "${dataverse::solr::jetty_home}/etc/jetty-logging.xml":
      ensure  => file,
      owner   => $dataverse::solr::jetty_user,
      group   => $dataverse::solr::jetty_user,
      source  => 'puppet:///modules/dataverse/solr/jetty-logging.xml';
    "${dataverse::solr::solr_home}/${dataverse::solr::core}/conf":
      ensure  => file,
      recurse => true,
      owner   => $dataverse::solr::jetty_user,
      group   => $dataverse::solr::jetty_user,
      source  => "puppet:///modules/dataverse/${dataverse::solr::dataverse_package}/conf/solr/${dataverse::solr::version}";
    "/etc/default/${dataverse::solr::jetty_user}":
      ensure  => file,
      content => template('dataverse/solr/jetty.erb');
    "/etc/init.d/${dataverse::solr::jetty_user}":
      ensure  => file,
      mode    => '0755',
      source  => 'puppet:///modules/dataverse/solr/jetty.sh';
    "/var/log/${dataverse::solr::jetty_user}":
      ensure  => directory,
      owner   => $dataverse::solr::jetty_user,
      group   => $dataverse::solr::jetty_user;
    "/var/cache/${dataverse::solr::jetty_user}":
      ensure  => directory,
      owner   => $dataverse::solr::jetty_user,
      group   => $dataverse::solr::jetty_user;
  }->anchor { 'solr::config::end': }

}
