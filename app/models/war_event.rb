class WarEvent < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 30

  validates_uniqueness_of :report_key
  validates_length_of :report_key, :maximum => 255
  validates_presence_of :report_key

  def to_param
    report_key
  end
end
