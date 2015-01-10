class HighestSentClimbCalculator
  def initialize(climbing_sessions)
    @climbing_sessions = climbing_sessions
  end

  def print_report
    highest_climb = get_highest_climb

    unless highest_climb.nil?
      puts "Highest sent climb: #{highest_climb.rating}"
    end
  end

  def get_highest_climb
    sent_climbs = []
    @climbing_sessions.each do |session|
      sent_climbs += session.climbs.select { |climb| climb.sent? }
    end

    sent_climbs.max
  end
end
