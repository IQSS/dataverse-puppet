class iqss::rserve::packages {

  $r_path       = '/usr/bin/R'


# r packages from the repo
  iqss::rserve::package { $iqss::rserve::packages_r:
    r_path=>$r_path,
  }

# installing package Zelig (from local GitHub):"
  archive { 'zelig':
    require          => Iqss::Rserve::Package['devtools'],
    ensure           => present,
    url              => $iqss::rserve::packages_zelig,
    target           => '/opt/rserve',
    follow_redirects => true,
    extension        => 'zip',
    checksum         => false,
  }->exec { 'copy zelig':
    command => "/usr/bin/rsync -av /opt/rserve/Zelig-master /tmp/ && ${r_path} -e \"setwd('/tmp'); library(devtools); install('Zelig-master')\"",
    cwd     => '/tmp',
    #unless  => "$r_path -q -e '\"Zelig\" %in% rownames(installed.packages())' | grep 'TRUE'",
  }

}