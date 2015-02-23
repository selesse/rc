class PassPlanCalculator
  def initialize(climbing_sessions, pass_plan)
    @climbing_sessions = climbing_sessions
    @pass_plan = pass_plan
  end

  def climbs_covered
    sessions_covered_by_plan = @climbing_sessions.select { |session|
      @pass_plan.session_covered?(session)
    }
    sessions_covered_by_plan.size
  end
end