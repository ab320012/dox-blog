namespace :import do
  desc "loads article data from db/data"
  task articles: :environment do
    Articles::ImportFromCSV.new.call
  end
end
