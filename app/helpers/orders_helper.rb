module OrdersHelper

  def self.unused_referral_code
    referral_code = SecureRandom.hex(4)
    collision = Order.find_by_referral_code(referral_code)

    until collision.nil?
      referral_code = SecureRandom.hex(4)
      collision = Order.find_by_referral_code(referral_code)
    end
    referral_code
  end


  def self.unused_unique_code
    unique_code = SecureRandom.hex(4)
    collision = Order.find_by_unique_code(unique_code)

    until collision.nil?
      unique_code = SecureRandom.hex(4)
      collision = Order.find_by_unique_code(unique_code)
    end
    unique_code
  end

end
