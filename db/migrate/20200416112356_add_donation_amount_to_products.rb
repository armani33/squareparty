class AddDonationAmountToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :donation_amount, :string
  end
end
