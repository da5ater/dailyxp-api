# Idempotent cursor-based sync: stable IDs, pending state, additive merge
class SyncService
  def self.push(device_id, events, cursor)
    # events: array of {eventId, type, payload}
    # cursor: last acknowledged eventId
    # Returns { acknowledged: [...eventIds], pending: [...] }
    acknowledged = []
    events.each do |e|
      next if Event.exists?(eventId: e[:eventId])
      Event.create!(eventId: e[:eventId], deviceId: device_id, type: e[:type], payload: e[:payload])
      acknowledged << e[:eventId]
    end
    { acknowledged: acknowledged, pending: Event.where(deviceId: device_id).where.not(eventId: acknowledged).pluck(:eventId) }
  end
  def self.preview_scope(user, scope)
    # scope: :all, :selected, :future_only ; Recovery separate consent
    case scope
    when :all then Event.where(userId: user.id)
    when :future_only then Event.where(userId: user.id).where("occurred_at > ?", Time.now)
    else Event.none
    end
  end
end
class Event < ApplicationRecord; end
