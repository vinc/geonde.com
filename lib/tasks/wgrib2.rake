namespace :wgrib2 do
  desc "Compile wgrib2"
  task compile: :environment do
    Dir.mktmpdir do |dir|
      Dir.chdir(dir) do
        begin
          sh "wget https://vinua.com/bin/wgrib2.gz"
          sh "gunzip wgrib2.gz"
          mv "wgrib2", Rails.root.join("bin")
        rescue
          sh "wget ftp://ftp.cpc.ncep.noaa.gov/wd51we/wgrib2/wgrib2.tgz"
          sh "tar -xvzf wgrib2.tgz"
          Dir.chdir("grib2") do
            sh "CC=gcc FC=gfortran make"
            mv "wgrib2/wgrib2", Rails.root.join("bin")
          end
        end
      end
    end
  end
end
