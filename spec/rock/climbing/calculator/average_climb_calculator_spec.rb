require 'rock/climbing/calculator/average_climb_calculator'

describe AverageClimbCalculator do
  it 'should calculate an average with integer-based climbs' do
    climbs = [ Climb.new('5.6'), Climb.new('5.7'), Climb.new('5.8') ]

    expect(AverageClimbCalculator.get_climb_average(climbs)).to eq('5.70')
  end

  it 'should calculate an average with plus or minus climbs' do
    climbs = [ Climb.new('5.6+'), Climb.new('5.7-'), Climb.new('5.7') ]

    expect(AverageClimbCalculator.get_climb_average(climbs)).to eq('5.67')
  end

  it 'should ignore consecutive climbs in an average rating' do
    climbs = [ Climb.new('5.6'), Climb.new('5.800', times: 2) ]

    expect(AverageClimbCalculator.get_climb_average(climbs)).to eq('5.60')
  end

  it 'should take into consideration percentage when weighing average' do
    climbs = [ Climb.new('5.5'), Climb.new('5.10', percentage: 0.5) ]

    expect(AverageClimbCalculator.get_climb_average(climbs)).to eq('5.69')
  end
end