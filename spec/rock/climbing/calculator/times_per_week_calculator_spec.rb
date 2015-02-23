require 'rock/climbing/calculator/times_per_week_calculator'
require 'fixtures/climbing_session_fixture'
require 'fixtures/pass_plan_fixture'

describe TimesPerWeekCalculator do
  context 'when a yearly plan was started one week ago' do
    before do
      one_week_ago = (DateTime.now - 7).to_time
      @yearly_plan = PassPlanFixture.get_yearly_plan(one_week_ago)
    end

    it 'should report one climb per week if there has been one session in one week' do
      climbing_sessions = ClimbingSessionFixture.get(Time.now)

      times_per_week_calculator = TimesPerWeekCalculator.new(climbing_sessions, @yearly_plan)
      expect(times_per_week_calculator.times_per_week).to eq(1.0)
    end

    it 'should report two climbs per week if there has been two sessions in one week' do
      climbing_sessions = ClimbingSessionFixture.get(Time.now)
      climbing_sessions << ClimbingSessionFixture.get((DateTime.now - 6).to_time)

      times_per_week_calculator = TimesPerWeekCalculator.new(climbing_sessions, @yearly_plan)
      expect(times_per_week_calculator.times_per_week).to eq(2.0)
    end
  end
end
