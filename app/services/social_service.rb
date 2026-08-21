# SOCIAL-001: consented profile, CloudFront geography, block
class SocialService
  def self.visible_fields(viewer, profile)
    # field-level visibility: private, circles, groups, public
    profile.fields.select { |f, v| v[:visibility] == "public" || viewer.can_view?(profile, f) }
  end
  def self.block(a,b); a.blocked << b.id; b.blocked << a.id; end
  def self.geography(request_headers); request_headers["CloudFront-Viewer-Country"] || "unknown"; end
end
