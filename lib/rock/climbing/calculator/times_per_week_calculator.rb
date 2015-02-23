class TimesPerWeekCalculator
  def initialize(climbing_sessions, pass_plan)
    @climbing_sessions = climbing_sessions
    @pass_plan = pass_plan
  end

  def times_per_week
    plan_start_mjd = Date.parse(@pass_plan.start_date.to_s).mjd
    right_now_mjd = Date.parse(Time.now.to_s).mjd

    weeks_difference = (right_now_mjd - plan_start_mjd) / 7.0

    @climbing_sessions.size / weeks_difference
  end

  def print_report
    puts "You've climbed #{times_per_week} times per week since #{@pass_plan.start_date.strftime("%B %-d, %Y")}"
  end
end