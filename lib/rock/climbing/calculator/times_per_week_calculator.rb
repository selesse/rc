require_relative 'pass_plan_calculator'

class TimesPerWeekCalculator < PassPlanCalculator
  def times_per_week
    plan_start_mjd = Date.parse(@pass_plan.start_date.to_s).mjd
    right_now_mjd = Date.parse(Time.now.to_s).mjd

    weeks_difference = (right_now_mjd - plan_start_mjd) / 7.0

    climbs_covered / weeks_difference
  end

  def print_report
    puts "You've climbed #{times_per_week.round(2)} times per week since #{@pass_plan.start_date.strftime("%B %-d, %Y")}"
  end
end