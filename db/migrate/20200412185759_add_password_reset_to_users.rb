class AddPasswordResetToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :password_reset_token, :string
    add_column :orders, :password_reset_sent_at, :datetime
  end
end
