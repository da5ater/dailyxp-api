class H2hService
  def self.fixture_result(a,b); a[:seasonXp] > b[:seasonXp] ? 3 : a[:seasonXp]==b[:seasonXp] ? 1 : 0; end
end
