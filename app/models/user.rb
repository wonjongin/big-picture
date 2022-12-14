class User < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password validations: false
  validates :ouid, uniqueness: true, presence: true

  has_many :tokens, class_name: 'Token', dependent: :destroy
end
