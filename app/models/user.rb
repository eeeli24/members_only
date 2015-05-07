class User < ActiveRecord::Base
  has_many :posts
  before_create :generate_token

  validates :name, presence: true,
                   length: { minimum: 3, maximum: 20 }
  validates :email, presence: true
  has_secure_password
  validates :password, presence: true

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def self.digest(token)
    Digest::SHA1.hexdigest(token)
  end

  private

    def generate_token
      self.remember_token = User.digest(User.new_token)
    end
end
