#######
#
# This file will be run on every deploy, so make sure the changes here are non-destructive
#
#######

Rake::Task['wardiary:term_definitions:import'].invoke
# This task takes quite a long time (hours), which is why it is disabled by default
# Rake::Task['wardiary:term_definitions:tag_war_events'].invoke
