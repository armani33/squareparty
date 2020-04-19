class AddMainImageToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :image_filename_main, :string
  end
end
