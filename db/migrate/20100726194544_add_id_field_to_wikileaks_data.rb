class AddIdFieldToWikileaksData < ActiveRecord::Migration
  def self.up
    add_column :war_events, :id, :primary_key
  end

  def self.down
    remove_column :war_events, :id
  end
end
