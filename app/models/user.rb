class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :remember_token
  before_create :create_remember_token
  before_save { self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensative: false}
  has_secure_password
  validates :password, length: { minimum: 6 }

  def User.new_remember_token #find out why User.
  	SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
  	Digest::SHA1.hexdigest(token.to_s)
  end


  private

	  def create_remember_token
	  	self.remember_token = User.encrypt(User.new_remember_token)
	  end

end
