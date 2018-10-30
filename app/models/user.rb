class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, 'valid_email_2/email': true
  validates :password, format: { with: /^(?=.*\d)(?=.*[a-zA-Z])[a-zA-Z0-9]{6,}$/, multiline: true }, confirmation: true
end
