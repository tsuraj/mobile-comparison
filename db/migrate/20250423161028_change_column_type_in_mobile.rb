class ChangeColumnTypeInMobile < ActiveRecord::Migration[7.2]
  def change
    change_column :mobiles, :display_size, :string
    change_column :mobiles, :ram, :string
    change_column :mobiles, :storage, :string
    change_column :mobiles, :price, :string
    change_column :mobiles, :camera_main, :string
    change_column :mobiles, :camera_front, :string
    change_column :mobiles, :battery, :string

  end
end
