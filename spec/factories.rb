# This file contains the factory definitions for factory_girl

require 'factory_girl'

Factory.sequence( :report_key ) {|n| "report-key-from-factory-#{n}" }

Factory.define :war_event do |c|
  c.report_key { Factory.next :report_key }
  c.date Time.now
end

Factory.sequence( :term ) {|n| "term-from-factory-#{n}" }

Factory.define :term_definition do |c|
  c.term { Factory.next :term }
  c.definition "Definition from factory"
end
