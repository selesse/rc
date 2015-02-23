require 'rock/climbing/plans/pass_plan'
require 'rock/climbing/plans/allez_up/allez_up_plan'
require 'rock/climbing/plans/allez_up/yearly_plan'

class PassPlanFixture
  def self.get_yearly_plan(date)
    YearlyPlan.new(date)
  end
end