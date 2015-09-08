package {
  ['unzip']:
    ensure => installed,
}

class {
# The global settings
  'iqss::globals':
    require => Package['unzip'],
    ensure  => present;
}

class {
  [
    'iqss::database',
    'iqss::dataverse',
    'iqss::solr',
    'iqss::tworavens'
  ]:
    require => Class['iqss::globals'];
}