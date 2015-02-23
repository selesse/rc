require_relative 'climbs_fixture'

class ClimbingSessionFixture
  def self.get(date)
    [ClimbingSession.new(date: date, climbs: ClimbsFixture.get, gym_name: 'Allez Up')]
  end
end