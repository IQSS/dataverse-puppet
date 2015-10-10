# Private class. Do not use directly.
#
# Download the R package from the latest or archived repo.
# Then check to see if we find the package.
#
# Installing a specific R package is quite a challenge. You cannot specify a version.
# We could directly download the intended package, however the R installation does not download the required
# dependencies when installing the main package from the local file system.
#
# So here we will try:
# - first... install the latest package. We then have all the dependencies. Lets hope these are backwards compatible.
# - Then reinstall the specified older version ( if different from the latest ) from the archive.
#
# Note that if the specific version fails to install, we let the procedure to go on anyway and hope the latest version
# does not break things.
define iqss::rpackager::package (
  $dependencies = true,
  $install_opts = '--no-test-load',
  $r_path       = '/usr/bin/R',
  $repo         = $iqss::rpackager::repo,
  $version      = 'latest',
) {

  $_dependencies = $dependencies ? { true => 'T', default => 'F' }
  $archive = "${repo}/src/contrib/00Archive" # Is this a convention ? Stable ?
  $package = "${name}_${version}.tar.gz"

  exec {
    "install the latest R package ${name}":
      command => "$r_path --vanilla --slave -e \"install.packages('${name}', lib='${iqss::params::r_site_library}', INSTALL_opts=c('${install_opts}'), repos='${repo}', dependencies=${_dependencies})\" ;
    /usr/bin/test -d \"${iqss::params::r_site_library}/${name}\"", # Use this test, as a R -e "[command]" never returns a non zero exit status.
      unless  => "$r_path -q -e 'installed.packages()' | grep '\"${name}\"' | grep '\"${version}\"'",
      timeout => 0 ;
    "install R package ${package}":
      require => Exec["install the latest R package ${name}"],
      command => "/usr/bin/wget -O /tmp/${package} ${archive}/${name}/${package} && $r_path --vanilla --slave -e \"install.packages('/tmp/${package}', lib='${iqss::params::r_site_library}', INSTALL_opts=c('${install_opts}'), repos=NULL)\"",
      unless  => ["$r_path -q -e 'installed.packages()' | grep '\"${name}\"' | grep '\"${version}\"'"],
      onlyif  => "/usr/bin/wget --spider ${archive}/${name}/${package}",
      timeout => 0 ;
  }

}

