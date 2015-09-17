class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :name, null: false, index: true
      t.string :album_type, null: false
      t.integer :band_id, null: false

      t.timestamps null: false
    end

    add_index :albums, [:name, :band_id], unique: true
  end
end
