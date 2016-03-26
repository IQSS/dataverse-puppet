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
  'dataverse::java':      # Java
}

class {
  'dataverse::solr':      # Solr
    require => Class['dataverse::java'],
}

class {
  'dataverse::database':  # Our database
}

class {
  'dataverse::rserve':    # RServe
}

class {
  'dataverse::dataverse': # Dataverse
    require => Class['dataverse::database', 'dataverse::java'],
}

class {
  'dataverse::tworavens': # TwoRavens add-on
}