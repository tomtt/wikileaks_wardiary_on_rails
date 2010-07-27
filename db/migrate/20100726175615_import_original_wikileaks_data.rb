require 'digest/sha1'

class ImportOriginalWikileaksData < ActiveRecord::Migration
  def self.import_7z_data(file)
    conf = ActiveRecord::Base.configurations[RAILS_ENV]
    dbconsole = Rails.root.join('script', 'dbconsole')
    cmd_line = "7za -so e #{file} 2> /dev/null | #{dbconsole}"
    puts cmd_line
    raise Exception, "Error executing " + cmd_line unless system(cmd_line)
  end

  def self.check_for_7za!
    system("7za > /dev/null") || raise(Exception, "The data is zipped with 7za, which is not installed on your system (please get it from http://www.7-zip.org/download.html)")
  end

  def self.up
    check_for_7za!
    data_file = Rails.root.join('data', 'afg-war-diary.sql.7z')
    raise "Invalid SHA1 for original data file" unless Digest::SHA1.hexdigest(File.read(data_file)) ==
      "9463f73ebbcd3f95899a138d6ba9817e1b6b800d"
    # Creating the war_diary table because the first line of the data will delete
    # it which will raise an error if it does not exist
    create_table :war_diary
    import_7z_data(data_file)
  end

  def self.down
    drop_table :war_diary
  end
end
