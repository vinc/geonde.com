namespace :geonames do
  desc "Import geonames"
  task import: :environment do
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        sh "wget http://download.geonames.org/export/dump/cities500.zip"
        sh "unzip cities500.zip"
        puts "Deleting old cities"
        GeonamesData.delete_all
        puts "Importing new cities"
        CSV.foreach("cities500.txt", col_sep: "\t", liberal_parsing: true) do |row|
          GeonamesData.create(
            name: row[1],
            latitude: row[4].to_f,
            longitude: row[5].to_f,
            country: row[8],
            admin1: row[10],
            admin2: row[11],
            admin3: row[12],
            admin4: row[13],
            population: row[14].to_i,
          )
        end
      end
    end
  end
end
