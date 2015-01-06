require 'rock/climbing/climbing_session'
require 'rock/climbing/plans/pass_plan'
require 'rock/climbing/plans/allez_up/allez_up_plan'
require 'rock/climbing/plans/allez_up/monthly_plan'

describe PassPlan do
    it 'should correctly determine if a climb in its range' do
        start_date = Time.new(2014, 1, 1)

        pass_plan = MonthlyPlan.new(start_date)

        session_too_early =
            ClimbingSession.new(date: Time.new(2013, 12, 31))
        session_beginning =
            ClimbingSession.new(date: Time.new(2014, 1, 1))
        session_middle =
            ClimbingSession.new(date: Time.new(2014, 1, 15))
        session_end =
            ClimbingSession.new(date: Time.new(2014, 1, 31))
        session_too_late =
            ClimbingSession.new(date: Time.new(2014, 2, 1))

        expect(pass_plan.session_covered?(session_beginning)).to eq(true)
        expect(pass_plan.session_covered?(session_middle)).to eq(true)
        expect(pass_plan.session_covered?(session_end)).to eq(true)

        expect(pass_plan.session_covered?(session_too_early)).to eq(false)
        expect(pass_plan.session_covered?(session_too_late)).to eq(false)
    end
end
