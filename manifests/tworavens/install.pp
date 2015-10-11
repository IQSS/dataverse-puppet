# = Puppet module for dataverse.
# == Class: Iqss::Tworavens::Install
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
# Download and build the RApache module.
# Download and install TwoRavens..
#
class iqss::tworavens::install {

  include 'apache::dev'
  if ! defined(Class['iqss::apache2']) {
    class {
      'iqss::apache2':
    }
  }

  if ! defined(Class['iqss::rpackager']) {
    class {
      'iqss::rpackager':
    }
  }

  file {
    '/opt/rapache.sh':
      ensure  => file,
      mode    => 744,
      content => template('iqss/tworavens/rapache.sh.erb'),
  }


  exec {
    'Build the rapache R mod':
      require => [Class['apache::dev', 'iqss::apache2', 'iqss::rpackager'], File['/opt/rapache.sh']],
      command => '/opt/rapache.sh',
      creates => $iqss::tworavens::mod_r_so_file;
  }

  apache::mod {
    'R':
  }

  file {
    [
      dirname($iqss::tworavens::dataexplore_dir),
      $iqss::tworavens::dataexplore_dir,
      "${ iqss::tworavens::parent_dir }/custom",
      "${ iqss::tworavens::parent_dir }/custom/pic_dir",
      "${ iqss::tworavens::parent_dir }/custom/preprocess_dir" ,
      "${ iqss::tworavens::parent_dir }/custom/log_dir",
    ]:
      require => Class['iqss::apache2'],
      ensure  => directory,
      owner   => $::apache::user,
      group   => $::apache::user;
  }

  archive { 'tworavens':
    ensure           => present,
    url              => $iqss::tworavens::package,
    target           => '/opt/tworavens',
    follow_redirects => true,
    extension        => 'zip',
    checksum         => false,
  }

  exec { 'copy TwoRavens master directory':
    require => [ Archive['tworavens'],  File[$iqss::tworavens::dataexplore_dir]],
    command => "/usr/bin/rsync -av /opt/tworavens/TwoRavens-*/ $iqss::tworavens::dataexplore_dir",
    creates => "${ iqss::tworavens::dataexplore_dir }/LICENSE";
  }

}