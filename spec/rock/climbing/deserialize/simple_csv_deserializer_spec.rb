require 'rock/climbing/climb'
require 'rock/climbing/climbing_session'
require 'rock/climbing/deserialize/simple_csv_deserializer'

describe SimpleCsvDeserializer do
  context 'with a CSV that contains one row' do
    before do
      @csv_contents = <<EOS
Gym Name,Date,Climbs,,,,,,,
Allez Up,2014-11-04,5.5,5.7,5.8,5.8-,5.10a (F))
EOS
    end

    it 'should parse the right amount of climbing sessions' do
      climbing_sessions = SimpleCsvDeserializer::deserialize(@csv_contents)

      expect(climbing_sessions.size).to eq(1)
    end

    it 'should parse the gym name, date and climbs based' do
      climbing_sessions = SimpleCsvDeserializer::deserialize(@csv_contents)

      climbing_session = climbing_sessions[0]
      expect(climbing_session.gym_name).to eq('Allez Up')
      expect(climbing_session.date).to eq(Time.new(2014, 11, 4))

      climbs = climbing_session.climbs
      expect(climbs.size).to eq(5)
      expect(climbs.first.rating).to eq('5.5')
      expect(climbs.first.failed).to be_falsey
      expect(climbs.last.rating).to eq('5.10a')
      expect(climbs.last.failed).to be_truthy
    end
  end

  context 'with a CSV that contains multiple rows' do
    before do
      @csv_contents = <<EOS
Gym Name,Date,Climbs,,,,,,,
Allez Up,2014-11-04,5.5,5.7,5.8,5.8-,5.8 (F),,,,,
Zero Gravity,2015-01-09,5.5+ x 4,5.2- x 8 ,5.8+ (30%),,,
EOS
    end

    it 'can correctly resolve the climbs' do
      climbing_sessions = SimpleCsvDeserializer::deserialize(@csv_contents)

      allez_up_session = climbing_sessions[0]
      expect(allez_up_session.gym_name).to eq('Allez Up')
      expect(allez_up_session.date).to eq(Time.new(2014, 11, 4))

      climbs = allez_up_session.climbs
      expect(climbs.size).to eq(5)
      expect(climbs.first.rating).to eq('5.5')
      expect(climbs.first.failed).to be_falsey
      expect(climbs.last.rating).to eq('5.8')
      expect(climbs.last.failed).to be_truthy

      zero_gravity_session = climbing_sessions[1]
      expect(zero_gravity_session.gym_name).to eq('Zero Gravity')
      expect(zero_gravity_session.date).to eq(Time.new(2015, 1, 9))

      climbs = zero_gravity_session.climbs
      expect(climbs.size).to eq(3)
      expect(climbs.first.rating).to eq('5.5+')
      expect(climbs.first.failed).to be_falsey
      expect(climbs.first.times).to eq(4)
      expect(climbs.last.rating).to eq('5.8+')
      expect(climbs.last.failed).to be_truthy
      expect(climbs.last.percentage).to eq(0.3)
    end
  end
end
