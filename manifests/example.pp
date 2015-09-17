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
} ->class {
  'iqss::tworavens': # TwoRavens add-on
}