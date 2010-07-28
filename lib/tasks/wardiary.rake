require 'pp'
require 'ruby-debug'

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

  namespace :term_definitions do
    desc "Import the term definitions from data/term_definitions.json"
    task :import => :environment do
      json = File.read(Rails.root.join("data", "term_definitions.json"))
      terms = JSON.parse(json)
      terms.each do |term|
        term_definition = TermDefinition.find_or_create_by_term(term["key"])
        term_definition.update_attributes(:definition => term["value"], :pattern => term["pattern"])
      end
    end
  end
end
