class User < ApplicationRecord
  include ActiveModel::SecurePassword
  has_secure_password validations: false
  validates :ouid, uniqueness: true, presence: true

  has_many :tokens, class_name: 'Token', dependent: :destroy
  has_and_belongs_to_many :communities
  has_and_belongs_to_many :events
end
