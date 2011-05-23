require 'guardian-content'

class Headline
  def self.find_for_date(date)
    topstories_id = "theguardian/mainsection/topstories"
    options = {}
    options["from-date"] = date.to_s(:db)
    options["to-date"] = date.to_s(:db)
    options["show-fields"] = "newspaperPageNumber"
    options["show-editor-picks"] = "true"
    options["show-most-viewed"] = "true"
    articles = GuardianContent::Content.find_all_by_id(topstories_id, options)
  end

  def self.obtain_headline_data
    # start_date = Date.parse("2004-01-01")
    start_date = Date.parse("2005-09-15")
    end_date = Date.parse("2009-12-31")
    return (start_date..end_date).map do |date|
      begin
        main_article = find_for_date(date).first
      rescue NoMethodError
        main_article = nil
      end
      title = main_article.try(:title)
      url = main_article.try(:url)
      data = [date, title, url]
      puts data.join(" - ")
      data
    end
  end

  def self.find_missing_data
    start_date = Date.parse("2005-09-15")
    end_date = Date.parse("2009-12-31")
    new_headlines_found = 0
    hash = load_hash_from_json
    (start_date..end_date).each do |date|
      unless hash.has_key?(date)
        begin
          main_article = find_for_date(date).first
        rescue NoMethodError
          main_article = nil
        end
        title = main_article.try(:title)
        url = main_article.try(:url)
        puts [date, title, url].join(" - ")
        if url
          hash[date] = new("title" => title, "url" => url)
          new_headlines_found += 1
        end
      end
    end
    if new_headlines_found > 0
      puts "#{new_headlines_found} new headlines found: saving json"
      store_hash_as_json(hash)
    end
  end

  def self.headline_data_to_hash(data)
    hash = {}
    data.each do |d|
      if d[1]
        hash[d[0]] = new("title" => d[1], "url" => d[2])
      end
    end
    hash
  end

  def self.store_hash_as_json(hash)
    File.open(Rails.root.join("data", "guardian_headlines.json"), "w") do |f|
      f.puts hash.to_json
    end
  end

  def self.load_hash_from_json
    data = JSON.parse(File.read(Rails.root.join("data", "guardian_headlines.json")))
    hash = {}
    data.each do |key, value|
      hash[Date.parse(key)] = Headline.new(value)
    end
    hash
  end

  attr_reader :title, :url

  def initialize(attributes)
    @title = attributes["title"]
    @url = attributes["url"]
  end

  private

  def self.make_request(conditions)
  end
end
