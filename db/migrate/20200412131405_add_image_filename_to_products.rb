class AddImageFilenameToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :image_filename_1, :string
    add_column :products, :image_filename_2, :string
    add_column :products, :image_filename_3, :string
    add_column :products, :description, :string
  end
end
