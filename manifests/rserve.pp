# Installation for the Rserve daemon
class iqss::rserve (
  $auth              = $iqss::params::rserve_auth,
  $chroot            = $iqss::params::rserve_chroot,
  $encoding          = $iqss::params::rserve_encoding,
  $eval              = $iqss::params::rserve_eval,
  $fileio            = $iqss::params::rserve_fileio,
  $gid               = $iqss::params::rserve_gid,
  $interactive       = $iqss::params::rserve_interactive,
  $maxinbuf          = $iqss::params::rserve_maxinbuf,
  $maxsendbuf        = $iqss::params::rserve_maxsendbuf,
  $plaintext         = $iqss::params::rserve_plaintext,
  $port              = $iqss::params::rserve_port,
  $pwd               = $iqss::params::rserve_pwd,
  $pwdfile           = $iqss::params::rserve_pwdfile,
  $remote            = $iqss::params::rserve_remote,
  $socket            = $iqss::params::rserve_socket,
  $sockmod           = $iqss::params::rserve_sockmod,
  $source            = $iqss::params::rserve_source,
  $su                = $iqss::params::rserve_su,
  $uid               = $iqss::params::rserve_uid,
  $umask             = $iqss::params::rserve_umask,
  $workdir           = $iqss::params::rserve_workdir,
) inherits iqss::params {


  if ! defined(Class['iqss::rpackager']) {
    class {
      'iqss::rpackager':
    }
  }

  class { 'iqss::rserve::service':
    require => Class['iqss::rpackager'];
  }

}