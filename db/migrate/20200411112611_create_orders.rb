class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :email
      t.string :password_digest

      t.string :first_name
      t.string :last_name

      t.string :address
      t.string :zip_code
      t.string :city
      t.string :country

      t.string :unique_code
      t.string :status

      t.string :referral_code
      t.integer :referrer_id

      t.timestamps
    end
    add_index :orders, :email, unique: true
  end
end
