require "rails_helper"
RSpec.describe SyncService do
  it "is idempotent and preserves unacknowledged history" do
    e1={eventId:"a1", type:"habit.completed", payload:{}}
    r1=SyncService.push("dev1",[e1],nil)
    r2=SyncService.push("dev1",[e1],nil)
    expect(r1[:acknowledged]).to eq(["a1"])
    expect(r2[:acknowledged]).to eq([])
  end
end
