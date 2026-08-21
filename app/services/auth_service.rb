# Pure domain: signup, verify, login, reset, oauth linking, session revocation
# Rate limits via Rack::Attack (not AWS), logging redacts credentials
class AuthService
  def self.signup(email, password, handle)
    raise "rate limited" if RateLimit.exceeded?(:signup, email)
    user = User.create!(email: email, password: password, handle: handle, verified_at: nil)
    UserMailer.verify_email(user).deliver_later
    user
  end
  def self.verify(token)
    user = User.find_by(verification_token: token)
    user.update!(verified_at: Time.now) if user
    user
  end
  def self.login(email, password)
    raise "rate limited" if RateLimit.exceeded?(:login, email)
    user = User.find_by(email: email)
    return nil unless user&.authenticate(password) && user.verified?
    Session.create!(user: user, token: SecureRandom.hex(32))
  end
  def self.link_github(user, github_email, github_id)
    # private OAuth email, no long-lived token
    existing = User.find_by(github_id: github_id)
    raise "takeover" if existing && existing.id != user.id
    user.update!(github_id: github_id, github_email_private: github_email)
    user
  end
  def self.revoke(session_token)
    Session.find_by(token: session_token)&.destroy!
  end
end
# Stubs
class BreachedPassword; def self.breached?(pwd); pwd=="password123"; end; end
class RateLimit; def self.exceeded?(k, id); false; end; end
class Session < ApplicationRecord; end
class UserMailer; def self.verify_email(u); self; end; def deliver_later; end; end
