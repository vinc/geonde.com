class CreateGeonamesData < ActiveRecord::Migration[7.0]
  def change
    create_table :geonames_data do |t|
      t.string :name
      t.string :country, limit: 2
      t.string :admin1, limit: 20
      t.string :admin2, limit: 80
      t.string :admin3, limit: 20
      t.string :admin4, limit: 20
      t.float :latitude
      t.float :longitude
      t.integer :population

      t.timestamps
    end
    add_index :geonames_data, :name
    add_index :geonames_data, :population
  end
end
