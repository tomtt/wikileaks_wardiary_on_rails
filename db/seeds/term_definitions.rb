#######
#
# This file will be run on every deploy, so make sure the changes here are non-destructive
#
#######

Rake::Task['wardiary:term_definitions:import'].invoke
