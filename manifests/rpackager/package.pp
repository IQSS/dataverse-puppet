# = Puppet module for dataverse.
# == Type: Dataverse::Dataverse::Package
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# Download the R package from the latest or archived repo.
# Then check to see if we find the package.
#
# Installing a specific R package is quite a challenge. You cannot specify a version.
# We could directly download the intended package, however the R installation does not download the required
# dependencies when installing the main package from the local file system.
#
# So here we will just install the latest available package and hope it is backwards compatible.
#
# Note that if the specific version fails to install, we let the procedure to go on anyway and hope the latest version
# does not break things.

define dataverse::rpackager::package (
  $contriburl   = $dataverse::rpackager::contriburl,
  $dependencies = true,
  $install_opts = '--no-test-load',
  $req          = [],
  $r_path       = $dataverse::rpackager::r_path,
  $r_repos      = $dataverse::rpackager::r_repos,
  $version      = 'latest',
) {

  $_dependencies = $dependencies ? { true => 'T', default => 'F' }

  $_contriburl_repos = $contriburl ? {
    undef => "repos='${r_repos}'",
    default => "contriburl='${contriburl}'"
  }

  exec {
    "R-package-${name}":
      command => "/bin/rm -rf ${dataverse::rpackager::r_site_library}/00LOCK-* ; ${r_path} --vanilla --slave -e \"install.packages('${name}', ${_contriburl_repos}, dependencies=${_dependencies}, INSTALL_opts=c('${install_opts}'), lib='${dataverse::rpackager::r_site_library}')\" ; /usr/bin/test -d \"${dataverse::rpackager::r_site_library}/${name}\"", # Use this test, as a R -e "[command]" never returns a non zero exit status.",
      require => Dataverse::Rpackager::Package[$req],
      unless  => "/usr/bin/test -d \"${dataverse::rpackager::r_site_library}/${name}\"",
      timeout => 600 ;
  }

}

