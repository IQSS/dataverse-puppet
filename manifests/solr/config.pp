# = Puppet module for dataverse.
# == Class: iqss::solr::config
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
class iqss::solr::config {

  anchor{ 'iqss::solr::config::begin': }->file{
    $iqss::solr::jetty_home:
      ensure  => directory,
      owner   => $iqss::solr::jetty_user,
      group   => $iqss::solr::jetty_user,
      recurse => true;
    "${iqss::solr::jetty_home}/etc/jetty-logging.xml":
      ensure  => file,
      owner   => $iqss::solr::jetty_user,
      group   => $iqss::solr::jetty_user,
      source  => 'puppet:///modules/iqss/solr/jetty-logging.xml';
    "${iqss::solr::solr_home}/${iqss::solr::core}/conf":
      ensure  => file,
      recurse => true,
      owner   => $iqss::solr::jetty_user,
      group   => $iqss::solr::jetty_user,
      source  => "puppet:///modules/iqss/${iqss::solr::dataverse_package}/conf/solr/${iqss::solr::version}";
    "/etc/default/${iqss::solr::jetty_user}":
      ensure  => file,
      content => template('iqss/solr/jetty.erb');
    "/etc/init.d/${iqss::solr::jetty_user}":
      ensure  => file,
      mode    => '0755',
      source  => 'puppet:///modules/iqss/solr/jetty.sh';
    "/var/log/${iqss::solr::jetty_user}":
      ensure  => directory,
      owner   => $iqss::solr::jetty_user,
      group   => $iqss::solr::jetty_user;
    "/var/cache/${iqss::solr::jetty_user}":
      ensure  => directory,
      owner   => $iqss::solr::jetty_user,
      group   => $iqss::solr::jetty_user;
  }->anchor { 'solr::config::end': }

}
