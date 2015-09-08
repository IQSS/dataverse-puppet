class iqss::rserve::install {

  package { # The lib* are (or may be) needed as dependencies for some of the r-packages
    $iqss::params::rserve_rstudio_libraries:
      ensure => installed,
  }

}