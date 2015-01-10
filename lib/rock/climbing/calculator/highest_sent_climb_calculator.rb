class HighestSentClimbCalculator
  def initialize(climbing_sessions)
    @climbing_sessions = climbing_sessions
  end

  def print_report
    sent_climbs = []
    @climbing_sessions.each do |session|
      sent_climbs += session.climbs.select { |climb| climb.sent? }
    end

    highest_climb = sent_climbs.max
    unless highest_climb.nil?
      puts "Highest sent climb: #{highest_climb.rating}"
    end
  end
end
