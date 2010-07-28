class CreateTermDefinitions < ActiveRecord::Migration
  def self.up
    create_table :term_definitions do |t|
      t.string :term, :null => false
      t.string :pattern
      t.text :definition, :null => false
      t.timestamps
    end

    add_index :term_definitions, :term, :unique => true
  end

  def self.down
    remove_index :term_definitions, :term
    drop_table :term_definitions
  end
end
