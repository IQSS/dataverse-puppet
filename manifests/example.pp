# = Puppet module for dataverse.
# == Manifest: example.pp
#
# === Copyright
#
# Puppet module for dataverse.
# GPLv3 - Copyright (C) 2015 International Institute of Social History <socialhistory.org>.
#
# === Description
#
# A manifest to combine the configuration plus data and apply it to a host.

class {
  'iqss::globals':   # The global settings
}->class {
  'iqss::rserve':    # RServe
}->class {
  'iqss::database':  # Our database
}->class {
  'iqss::solr':      # Solr
}->class {
  'iqss::dataverse': # Dataverse
}

class {
  'iqss::tworavens': # TwoRavens add-on
    require => Class['iqss::globals'];
}