class iqss::rserve::repo {

  case $::osfamily {
    'redhat': {
      package {
        'epel-release':
          ensure => present,
      }
    }
    'debian': {
      apt::source { 'rstudio':
        comment    => 'This is the Ubuntu Debian repository for RStudio',
        location   => 'http://cran.rstudio.com/bin/linux/ubuntu',
        repos      => "${::lsbdistcodename}/",
        release    => ' ', # The space prevents the default lsbdistcodename
        key        =>  'E298A3A825C0D65DFD57CBB651716619E084DAB9',
        key_server => 'keyserver.ubuntu.com',
      }
    }

  }

}