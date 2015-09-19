# Download the R package from the latest or archived repo.
# Then check to see if we find the package.
define iqss::rpackager::package (
  $dependencies = true,
  $install_opts = '--no-test-load',
  $r_path       = '/usr/bin/R',
  $repo         = $iqss::rpackager::repo,
  $version      = 'latest',
) {

  $_dependencies = $dependencies ? { true => 'T', default => 'F' }

  exec { "install R package $name":
    command => "$r_path --vanilla --slave -e \"install.packages('${name}', lib='${iqss::params::r_site_library}', INSTALL_opts=c('${install_opts}'), repos='${repo}', dependencies=${_dependencies})\" ;
    /usr/bin/test -d \"${iqss::params::r_site_library}/${name}\"", # Use this test, as a R -e "[command]" never returns a non zero exit status.
    unless  => "$r_path -q -e 'installed.packages()' | grep '\"${name}\"' | grep '\"${version}\"'",
    timeout => 0 ;
  }

}

