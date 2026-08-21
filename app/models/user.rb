class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :handle, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, if: -> { password.present? }
  validate :not_breached
  def not_breached
    return if password.nil?
    errors.add(:password, "is breached") if BreachedPassword.breached?(password)
  end
  def verified?; verified_at.present?; end
end
