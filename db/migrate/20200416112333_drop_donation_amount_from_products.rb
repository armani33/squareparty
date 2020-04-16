class DropDonationAmountFromProducts < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :donation_amount
  end
end
