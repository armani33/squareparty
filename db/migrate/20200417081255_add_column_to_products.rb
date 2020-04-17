class AddColumnToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :delivery, :json, default: {}
    add_column :products, :size, :json, default: {}
  end
end
