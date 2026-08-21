require "rails_helper"
RSpec.describe LeagueService do
  it "ranks by seasonXp" do
    users=[{seasonXp:10},{seasonXp:20}]
    expect(LeagueService.standings(users).first[:user][:seasonXp]).to eq(20)
  end
end
