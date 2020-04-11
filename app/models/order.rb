class Order < ApplicationRecord
  has_secure_password
  belongs_to :product

end
