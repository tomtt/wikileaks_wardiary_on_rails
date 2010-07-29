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

  def self.find_all_by_search_pattern!(pattern)
    # This query is MySQL specific and not checking for sql injection.
    sql = "select * from war_events where concat(summary, ' ', title, ' ', ccir, ' ', category) regexp '[[:<:]](#{pattern})[[:>:]]'"
    find_by_sql(sql)
  end

  def self.tag_all_with_all_terms!
    # puts "Clearing all current tags"

    war_event_term_taggings = compute_taggings_for_all_war_events
    export_war_event_term_taggings_as_json(war_event_term_taggings)
    sql_filename = export_war_event_term_taggings_as_sql(war_event_term_taggings)

    clear_all_term_tags!
    `#{Rails.root.join("db", "console")} < #{sql_filename}`
  end

  def self.export_war_event_term_taggings_as_json(war_event_taggings, show_info = true)
    puts "Mapping internal ids to report keys" if show_info
    dup_wet = war_event_taggings.dup

    internal_id_to_report_key_mapping = {}
    WarEvent.all.each do |war_event|
      internal_id_to_report_key_mapping[war_event.id] = war_event.report_key
    end

    dup_wet.keys.each do |internal_id|
      dup_wet[internal_id_to_report_key_mapping[internal_id.to_i]] = dup_wet.delete(internal_id)
    end
    filename = Rails.root.join("data", "war_event_term_taggings.json")
    puts "Storing war event term taggings in #{filename}" if show_info
    File.open(filename, "w") do |file|
      file.puts dup_wet.to_json
    end
    filename
  end

  def self.export_war_event_term_taggings_as_sql(war_event_taggings)
    TermDefinition.all.each do |term_definition|
      ActsAsTaggableOn::Tag.find_or_create_by_name(term_definition.term)
    end
    tag_to_id_mappings = {}

    ActsAsTaggableOn::Tag.all.each do |tag|
      tag_to_id_mappings[tag.name] = tag.id
    end

    filename = Rails.root.join("data", "war_event_term_taggings.sql")
    File.open(filename, "w") do |sql_file|
      war_event_taggings.each do |war_event_id, terms|
        terms.each do |term|
          sql_file << "INSERT INTO taggings (tag_id, taggable_id, taggable_type, context, created_at) VALUES (%d, %d, 'WarEvent', 'terms', NOW());\n" %
            [tag_to_id_mappings[term], war_event_id]
        end
      end
      nil
    end
    filename
  end

  def self.clear_all_term_tags!
    sql = "DELETE FROM taggings WHERE context = 'terms' AND taggable_type = 'WarEvent'"
    WarEvent.connection.execute(sql)
  end

  def self.compute_taggings_for_all_war_events
    puts "Building initial structure for storing taggings"
    war_event_taggings = {}
    WarEvent.all.each do |war_event|
      war_event_taggings[war_event.id] = []
    end

    puts "Tagging for each term definition (x#{TermDefinition.count}):"
    TermDefinition.all.each do |term_definition|
      STDOUT.sync = true
      print "#{term_definition.term} (#{term_definition.pattern}) "
      if term_definition.pattern =~ /\?\!/
        puts "Skipping this term definition due to obscure syntax that MySQL can not handle"
        next
      end
      WarEvent.find_all_by_search_pattern!(term_definition.pattern).each do |matching_war_event|
        war_event_taggings[matching_war_event.id] << term_definition.term
      end
    end

    war_event_taggings
  end

  private

  def searchable_text
    [title, summary, ccir, category].join(' ')
  end
end
