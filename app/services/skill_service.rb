class SkillService
  def self.normalize(path); path.downcase; end
  def self.primary_skill(tags); tags.first; end
end
