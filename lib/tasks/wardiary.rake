require 'pp'

namespace :wardiary do
  namespace :data do
    desc "Import original wikileaks data"
    task :import => :environment do
      conf = ActiveRecord::Base.configurations[RAILS_ENV]
      pp conf
      sql_file = Rails.root.join('data', 'afg_std.sql')
      cmd_line = "mysql -h "+conf["host"]+" -D "+conf["database"]+ " --user="+conf["username"]+" --password="+conf["password"]+" < "+sql_file
      puts cmd_line
    end
  end
end
