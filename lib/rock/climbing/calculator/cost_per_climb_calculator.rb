require_relative 'pass_plan_calculator'

class CostPerClimbCalculator < PassPlanCalculator
  def cost_per_climb
    @pass_plan.price / climbs_covered
  end

  def print_report
    puts "Your plan cost $#{@pass_plan.price}"
    puts "You have climbed #{@climbing_sessions.size} different times, #{climbs_covered} of which were covered by your plan"
    climbs_not_covered = @climbing_sessions.size - climbs_covered
    puts "With your plan, it has cost you $#{get_formatted_price(cost_per_climb)} per climb"
    if climbs_not_covered > 0
      puts "You've paid $#{get_formatted_price(@pass_plan.individual_rate * climbs_not_covered)} for your non-covered sessions"
      puts "You've spent $#{get_formatted_price((@pass_plan.individual_rate * climbs_not_covered) + @pass_plan.price)} total"
    end
  end

  def get_formatted_price(price)
    format("%.2f", price.round(2))
  end
end
