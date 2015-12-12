# = Puppet module for dataverse.
# == Class: Dataverse::Tworavens::Install
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
class dataverse::tworavens::install {

  include 'apache::dev'
  if ! defined(Class['dataverse::apache2']) {
    class {
      'dataverse::apache2':
    }
  }

  if ! defined(Class['dataverse::rpackager']) {
    class {
      'dataverse::rpackager':
    }
  }

  file {
    '/opt/rapache.sh':
      ensure  => file,
      mode    => 744,
      content => template('dataverse/tworavens/rapache.sh.erb'),
  }


  exec {
    'Build the rapache R mod':
      require => [Class['apache::dev', 'dataverse::apache2', 'dataverse::rpackager'], File['/opt/rapache.sh']],
      command => '/opt/rapache.sh',
      creates => $dataverse::tworavens::mod_r_so_file;
  }

  apache::mod {
    'R':
  }

  file {
    [
      dirname($dataverse::tworavens::dataexplore_dir),
      $dataverse::tworavens::dataexplore_dir,
      "${ dataverse::tworavens::parent_dir }/custom",
      "${ dataverse::tworavens::parent_dir }/custom/pic_dir",
      "${ dataverse::tworavens::parent_dir }/custom/preprocess_dir" ,
      "${ dataverse::tworavens::parent_dir }/custom/log_dir",
    ]:
      require => Class['dataverse::apache2'],
      ensure  => directory,
      owner   => $::apache::user,
      group   => $::apache::user;
  }

  archive { 'tworavens':
    ensure           => present,
    url              => $dataverse::tworavens::package,
    target           => '/opt/tworavens',
    follow_redirects => true,
    extension        => 'zip',
    checksum         => false,
  }

  exec { 'copy TwoRavens master directory':
    require => [ Archive['tworavens'],  File[$dataverse::tworavens::dataexplore_dir]],
    command => "/usr/bin/rsync -av /opt/tworavens/TwoRavens-*/ $dataverse::tworavens::dataexplore_dir",
    creates => "${ dataverse::tworavens::dataexplore_dir }/LICENSE";
  }

}