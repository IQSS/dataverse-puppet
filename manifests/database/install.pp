class iqss::database::install {

# Add a pg user
  user {
    $iqss::globals::database_user:
      ensure     => present,
  }

# Install postgresql
  class { 'postgresql::globals':
    version                        => $iqss::database::version,
    manage_package_repo            => $iqss::database::manage_package_repo,
    encoding                       => $iqss::database::encoding,
    locale                         => $iqss::database::locale,
  }->class { 'postgresql::server':
    listen_addresses               => $iqss::database::listen_addresses,
  }

}