require "rails_helper"
RSpec.describe "Health", type: :request do
  it "returns ok without AWS" do
    get "/health"
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)["version"]).to eq("1")
  end
  it "returns protocol version" do
    get "/api/v1/protocol"
    expect(JSON.parse(response.body)["version"]).to eq(1)
  end
end
