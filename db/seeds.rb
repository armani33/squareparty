puts 'Creating 1000 discounts_code...'

1000.times do
  discount = Discount.new(
    discount_code: "FREE#{rand.to_s[2..6]}"
  )
  discount.save!
end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
