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
  'dataverse::rserve':    # RServe
}->class {
  'dataverse::database':  # Our database
}->class {
  'dataverse::solr':      # Solr
}->class {
  'dataverse::dataverse': # Dataverse
}->class {
  'dataverse::tworavens': # TwoRavens add-on
}