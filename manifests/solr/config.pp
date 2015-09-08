# == Class: iqss::solr::config
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
#
# === Copyright
#
# GPL-3.0+
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
      source  => 'puppet:///modules/iqss/dataverse/conf/solr/4.6.0';
    "${iqss::solr::solr_home}/${iqss::solr::core}/conf/solrconfig.xml":
      ensure  => file,
      owner   => $iqss::solr::jetty_user,
      group   => $iqss::solr::jetty_user,
      source  => 'puppet:///modules/iqss/solr/solrconfig.xml';
    '/etc/default/solr':
      ensure  => file,
      content => template('iqss/solr/jetty.erb');
    '/etc/init.d/solr':
      ensure  => file,
      mode    => '0755',
      content => template('iqss/solr/jetty.sh.erb');
    '/var/log/jetty':
      ensure  => directory,
      owner   => $iqss::solr::jetty_user,
      group   => $iqss::solr::jetty_user;
    '/var/cache/jetty':
      ensure  => directory,
      owner   => $iqss::solr::jetty_user,
      group   => $iqss::solr::jetty_user;
    '/var/log/solr':
      ensure  => link,
      target  => "${iqss::solr::jetty_home}/logs";
  }->anchor { 'solr::config::end': }

}
