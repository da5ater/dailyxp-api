class LeagueService
  def self.standings(users) # users with seasonXp
    users.sort_by { |u| -u[:seasonXp] }.each_with_index.map { |u,i| { user: u, rank: i+1 } }
  end
  def self.promote_relegate(divisions)
    # top 5 promote, bottom 5 relegate, ~30 per division
  end
end
