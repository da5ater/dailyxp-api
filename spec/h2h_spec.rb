require "rails_helper"
RSpec.describe H2hService do; it "awards 3/1/0" do; expect(H2hService.fixture_result({seasonXp:10},{seasonXp:5})).to eq(3); end; end
