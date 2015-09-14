class {
# The global settings
  'iqss::globals':
    ensure  => present;
}

class {
  [
    'iqss::database',
    'iqss::rserve',
    'iqss::solr',
    'iqss::tworavens'
  ]:
    require => Class['iqss::globals'];
}

class {
  'iqss::dataverse':
    require => Class['iqss::database']; # We will make sure to install dataverse after the database installation.
}