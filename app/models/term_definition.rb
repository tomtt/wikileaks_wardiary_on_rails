class TermDefinition < ActiveRecord::Base
  validates_presence_of :term
  validates_presence_of :definition
  validates_length_of :term, :maximum => 255
  validates_uniqueness_of :term
end
