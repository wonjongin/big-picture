class User < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password validations: false
  validates :ouid, uniqueness: true, presence: true
end
