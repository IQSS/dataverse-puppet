# Private class. Do not use directly.
#
class iqss::rpackager::install {

  package {
    $iqss::params::rpackager_rstudio_libraries:
      ensure => installed,
  }

}