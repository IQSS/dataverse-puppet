define iqss::rserve::package (
  $r_path       = '/usr/bin/R',
  $repo         = $iqss::rserve::package_repo,
  $dependencies = true,
  $install_opts = '--no-test-load',
) {

  $_dependencies = $dependencies ? { true => 'T', default => 'F' }

  exec { "install_r_package_$name":
    command => "$r_path -e \"install.packages('${name}', INSTALL_opts=c('${install_opts}'), repos='${repo}', dependencies=${_dependencies})\"",
    unless  => "$r_path -q -e '\"$name\" %in% rownames(installed.packages())' | grep 'TRUE'",
    timeout => 0
  }

}
