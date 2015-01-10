require 'rock/climbing/calculator/highest_sent_climb_calculator'
require 'rock/climbing/climbing_session'

describe HighestSentClimbCalculator do
  it 'should not consider un-sent climbs as the highest' do
    climbing_sessions = ClimbingSession.new(date: Time.now,
                                             climbs: [Climb.new('5.5', sent: false),
                                                      Climb.new('5.6', sent: true),
                                                      Climb.new('5.10', sent: false),
                                                      Climb.new('5.4', sent: true)])
    expect(HighestSentClimbCalculator.new([climbing_sessions]).get_highest_climb.rating).to eq('5.6')
  end
end
