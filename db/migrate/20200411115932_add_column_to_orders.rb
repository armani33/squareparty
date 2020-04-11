class AddColumnToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :stripe_token, :string
    add_column :orders, :product_id, :integer
  end
end
