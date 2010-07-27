class UseReportKeyAsIdentifier < ActiveRecord::Migration
  def self.up
    change_column :war_events, :report_key, :string, :null => false
    add_index :war_events, :report_key, :unique => true
  end

  def self.down
    remove_index :war_events, :report_key
  end
end
