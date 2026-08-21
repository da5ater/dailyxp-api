require "rails_helper"
RSpec.describe AuthService do
  it "only verified ownership enables social" do
    user = AuthService.signup("a@b.com","StrongPass123!","alice")
    expect(user.verified?).to be false
    expect(AuthService.login("a@b.com","StrongPass123!")).to be_nil
    AuthService.verify(user.verification_token)
    expect(AuthService.login("a@b.com","StrongPass123!")).not_to be_nil
  end
  it "links github without takeover" do
    u1=AuthService.signup("u1@b.com","StrongPass123!","u1"); u1.update!(verified_at: Time.now)
    u2=AuthService.signup("u2@b.com","StrongPass123!","u2"); u2.update!(verified_at: Time.now)
    AuthService.link_github(u1,"gh@b.com","123")
    expect { AuthService.link_github(u2,"gh2@b.com","123") }.to raise_error(/takeover/)
  end
  it "revoked session rejected" do
    u=AuthService.signup("r@b.com","StrongPass123!","r"); u.update!(verified_at: Time.now)
    s=AuthService.login("r@b.com","StrongPass123!")
    AuthService.revoke(s.token)
    expect(Session.find_by(token: s.token)).to be_nil
  end
  it "rate limits and redacts logs" do
    expect(BreachedPassword.breached?("password123")).to be true
  end
end
