require "rails_helper"
RSpec.describe SocialService do
  it "only authorized fields returned and block is mutual" do
    expect(SocialService.geography({"CloudFront-Viewer-Country"=>"DE"})).to eq("DE")
  end
end
