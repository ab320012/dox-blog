require 'csv'
module Articles
  class ImportFromCSV
    attr_accessor :csv
    def initialize
      @csv = CSV.foreach("#{Rails.root}/db/data/articles.csv", headers: true)
    end
    def call
      @csv.each do |row|
        data=  row.to_hash
        a= ::Article.find_or_initialize_by(
          title: data['title'],
          body: JSON.parse(data['body']).join('. '),
          author: Author.find_or_create_by(name: data['author name']),
          hero_image_name: data['hero image name']
        )
        puts a.errors unless a.save
      end
    end
  end
end
