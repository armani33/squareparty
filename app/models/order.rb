class Order < ApplicationRecord
  has_secure_password

  belongs_to :product

  belongs_to :referrer, class_name: 'Order', foreign_key: 'referrer_id', required: false
  has_many :referrals, class_name: 'Order', foreign_key: 'referrer_id'


  validates :product_id, presence: true

  validates :email, presence: true, uniqueness: true, format: {
   with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email format'}

  validates :password_digest, presence: true

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :zip_code, presence: true
  validates :city, presence: true
  validates :country, presence: true


  before_create :create_referral_code
  before_create :create_unique_code
  before_create :downcase_email

  before_create :shipment_pricing

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.forgot_password(self).deliver# This sends an e-mail with a link for the user to reset the password
  end
  # This generates a random password reset token for the user
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while Order.exists?(column => self[column])
  end

  private

  def create_referral_code
    self.referral_code = OrdersHelper.unused_referral_code
  end

  def create_unique_code
    self.unique_code = OrdersHelper.unused_unique_code
  end

  def downcase_email
    self.email.downcase!
  end

  def shipment_pricing
    case self.country
    when "Belgium"
      return 1000
    when "France"
      return 1000
    when "Germany"
      return 1000
    when "Netherlands"
      return 1000
    when "United Kingdom"
      return 1000
    end
  end

end
