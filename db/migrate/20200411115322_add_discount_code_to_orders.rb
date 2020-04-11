class AddDiscountCodeToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :discount_code, :string
  end
end
