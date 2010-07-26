class RenameTypeFieldOfWikileaksData < ActiveRecord::Migration
  def self.up
    rename_column :war_events, :type, :type_of_event
  end

  def self.down
    rename_column :war_events, :type_of_event, :type
  end
end
