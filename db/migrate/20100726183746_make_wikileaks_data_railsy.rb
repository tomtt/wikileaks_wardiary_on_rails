class MakeWikileaksDataRailsy < ActiveRecord::Migration
  def self.railsify_column_name(column)
    from_name = column.name
    to_name = from_name.underscore
    rename_column :war_events, from_name, to_name
  end

  def self.unrailsify_column_name(column)
    # Some capitalization subtleties got lost in the raisifying process,
    # make sure we can put the original names back as they were.
    from_name = column.name
    to_name = from_name.dup
    strings_to_upcase = %w{wia kia ccir mgrs}
    strings_to_upcase.each do |string_to_upcase|
      to_name.sub!(string_to_upcase, string_to_upcase.upcase)
    end
    to_name = to_name.camelize
    rename_column :war_events, from_name, to_name
  end

  def self.up
    rename_table("war_diary", "war_events")
    columns("war_events").each { |column| railsify_column_name(column) }
  end

  def self.down
    columns("war_events").each { |column| unrailsify_column_name(column) }
    rename_table("war_events", "war_diary")
  end
end
