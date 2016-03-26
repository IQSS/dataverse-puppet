# = Puppet module for dataverse.
# == Class: dataverse::rserve
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# Installs the RServe package with a Binary R server (a daemon) together with a range of R packages.
# Also see: https://rforge.net/Rserve/doc.html
#
# === Parameters
#
# [auth='required'|'disable']
#   If you need remote access use set auth 'required' and plaintext to 'disable'.
#
# [chroot=undef]
#   The path to the jail directory.
#
# [encoding='utf-8'|native|latin1]
#   This means that strings are converted to the given encoding before being sent to the client and also all strings
#   from the client are assumed to come from the given encoding.
#
# [eval=undef]
#   Preload packages with expressions that you would otherwise have to load from scripts.
#
# [fileio='enable'|'disable']
#   Allow clients to perform filesystem operations via the RServe deamon.
#
# [gid=97)
#   The group id of the 'rserve' user runnning the daemon.
#
# [interactive='yes'|'no']
#
# [maxinbuf=262144]
#   The maximum allowed buffer size in Kb send from the client per connection.
#
# [maxsendbuf=0]
#   The maximum allowed buffer size in Kb send from the server per connection.
#
# [password='rserve']
#   The password for connecting to the Binary R server daemon.
#
# [plaintext='disable'|'enable']
#   Allows for sending credentials as plaintext.
#
# [port=6311]
#   The TCP port the daemon listens too.
#
# [pwdfile='/etc/Rserve.pwd']
#   The password file containing the authentication credentials.
#
# [remote='enable'|'disable']
#   Allows remote connections when enabled.
#
# [socket=undef]
#
# [sockmod=undef]
#
# [source=undef]
#   Location to a file to preload packages that you would otherwise have to load from your scripts.
#
# [su=undef|now|server|client]
#   Undocumented.
#
# [uid=97]
#   The user id of the 'rserve' user running the daemon.
#
# [user='rserve']
#   The username for connecting to the Binary R server daemon.
#
# [umask=0]
#   Controls how file permissions are set for files.
#
# [workdir='/tmp/Rserv']
#   R working directory.
#
# === Examples
#
#   class { dataverse:rserve
#     pwdfile => '/tip/top/secret',
#   }
#

class dataverse::rserve (
  $auth              = $dataverse::params::rserve_auth,
  $chroot            = $dataverse::params::rserve_chroot,
  $encoding          = $dataverse::params::rserve_encoding,
  $eval              = $dataverse::params::rserve_eval,
  $fileio            = $dataverse::params::rserve_fileio,
  $gid               = $dataverse::params::rserve_gid,
  $interactive       = $dataverse::params::rserve_interactive,
  $maxinbuf          = $dataverse::params::rserve_maxinbuf,
  $maxsendbuf        = $dataverse::params::rserve_maxsendbuf,
  $plaintext         = $dataverse::params::rserve_plaintext,
  $port              = $dataverse::params::rserve_port,
  $password          = $dataverse::params::rserve_password,
  $pwdfile           = $dataverse::params::rserve_pwdfile,
  $remote            = $dataverse::params::rserve_remote,
  $socket            = $dataverse::params::rserve_socket,
  $sockmod           = $dataverse::params::rserve_sockmod,
  $source            = $dataverse::params::rserve_source,
  $su                = $dataverse::params::rserve_su,
  $uid               = $dataverse::params::rserve_uid,
  $user              = $dataverse::params::rserve_user,
  $umask             = $dataverse::params::rserve_umask,
  $workdir           = $dataverse::params::rserve_workdir,
) inherits dataverse::params {


# Install R if not done so before.
  if ! defined(Class['dataverse::rpackager']) {
    class {
      'dataverse::rpackager':
    }
  }

# Install RServe
  dataverse::rpackager::package {
    'Rserve':
      require => Class['dataverse::rpackager'],
      version => '1.7-2',
  }

  class { 'dataverse::rserve::service':
    require => [
      Class['dataverse::rpackager'],
      dataverse::rpackager::package['Rserve'],
    ];
  }

}