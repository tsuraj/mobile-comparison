class CreateMobiles < ActiveRecord::Migration[7.2]
  def change
    create_table :mobiles do |t|
      t.string :brand, null: false
      t.string :model, null: false
      t.date :release_date
      t.float :display_size
      t.string :resolution
      t.string :processor
      t.integer :ram
      t.integer :storage
      t.float :camera_main
      t.float :camera_front
      t.integer :battery
      t.string :os_version
      t.decimal :price
      t.string :image_url

      t.timestamps
    end
  end
end
