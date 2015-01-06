require 'rock/climbing/calculator/average_climb_calculator'
require 'rock/climbing/calculator/cost_per_climb_calculator'

class Reporter
    attr_reader :climbing_sessions, :pass_plan

    def initialize(climbing_sessions, pass_plan)
        @climbing_sessions = climbing_sessions
        @pass_plan = pass_plan
        @reporters = [
            CostPerClimbCalculator.new(climbing_sessions, pass_plan),
            AverageClimbCalculator.new(climbing_sessions)
        ]
    end

    def report
        @reporters.each do |reporter|
            puts reporter.class
            puts '-' * 80
            reporter.print_report
            puts '-' * 80
            puts
        end
    end
end
