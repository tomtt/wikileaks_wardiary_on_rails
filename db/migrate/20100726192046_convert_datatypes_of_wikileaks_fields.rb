class ConvertDatatypesOfWikileaksFields < ActiveRecord::Migration
  def self.up
    columns(:war_events).each do |column|
      name = column.name
      change_column(:war_events, name, :integer) if name =~ /[kw]ia|detained/
    end
    change_column(:war_events, :date, :timestamp)
  end

  def self.down
    change_column(:war_events, :date, :text, :limit => 255)
    columns(:war_events).each do |column|
      name = column.name
      change_column(:war_events, name, :text, :limit => 255) if name =~ /[kw]ia|detained/
    end
  end
end
