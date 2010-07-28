class WarEvent < ActiveRecord::Base
  cattr_reader :per_page
  @@per_page = 30

  validates_uniqueness_of :id
  validates_uniqueness_of :report_key
  validates_length_of :report_key, :maximum => 255
  validates_presence_of :report_key

  acts_as_taggable_on :terms

  def to_param
    report_key
  end

  def tag_with_available_terms
    TermDefinition.all.each do |term_definition|
      term = term_definition.term
      regexp = /\b(#{term_definition.pattern})\b/
      does_match = searchable_text =~ regexp

      if does_match
        unless term_list.include?(term)
          term_list << term
        end
      else
        if term_list.include?(term)
          term_list.remove(term)
        end
      end
    end
    save
  end

  private

  def searchable_text
    [title, summary, ccir, category].join(' ')
  end
end
