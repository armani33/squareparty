class AddImageToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :image_filename_4, :string
  end
end
