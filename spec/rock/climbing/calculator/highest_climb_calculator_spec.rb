require 'rock/climbing/calculator/highest_climb_calculator'
require 'rock/climbing/climbing_session'

describe HighestClimbCalculator do
  it 'should find the highest difficulty among a single session' do
    climbing_sessions = [ClimbingSession.new(date: Time.now,
                                             climbs: [Climb.new('5.5', sent: false),
                                                      Climb.new('5.10+', sent: true),
                                                      Climb.new('5.10', sent: false),
                                                      Climb.new('5.4', sent: true)])]
    expect(HighestClimbCalculator.new(climbing_sessions).get_highest_climb.rating).to eq('5.10+')
  end

  it 'should take multiple climbing sessions into consideration' do
    climbing_sessions = [ClimbingSession.new(date: Time.now,
                                             climbs: [Climb.new('5.5', sent: false),
                                                      Climb.new('5.6', sent: true),
                                                      Climb.new('5.8', sent: false),
                                                      Climb.new('5.4', sent: true)]),
                         ClimbingSession.new(date: Time.now,
                                             climbs: [Climb.new('5.5', sent: false),
                                                      Climb.new('5.7+', sent: true),
                                                      Climb.new('5.10', sent: false),
                                                      Climb.new('5.4', sent: true)]),
    ]
    expect(HighestClimbCalculator.new(climbing_sessions).get_highest_climb.rating).to eq('5.10')
  end
end
