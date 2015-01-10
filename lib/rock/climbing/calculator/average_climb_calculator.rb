class AverageClimbCalculator
  def initialize(climbing_sessions)
    @climbing_sessions = climbing_sessions
  end

  def print_report
    @climbing_sessions.each do |session|
      climbs = session.climbs
      climbs_human = climbs.map do |climb|
        rating = climb.rating
        percentage = climb.percentage
        times = climb.times

        climb_human = (100 * percentage).to_s + '% of ' + rating
        if times > 1
          climb_human += ' x ' + times.to_s
        end
        climb_human
      end
      climb_average = AverageClimbCalculator.get_climb_average(climbs)
      puts "Average for climb on #{session.date.strftime('%Y/%m/%d')}: #{climb_average} -- #{climbs_human.join(', ')}"
    end
  end

  def self.get_climb_average(climbs)
    ratings = []

    climbs.each do |climb|
      rating = climb.rating
      percentage = climb.percentage
      times = climb.times

      ratings << (Climb::get_numeric_rating(rating) * percentage) if times == 1
    end

    0 if ratings.empty?
    # Average of the array
    average_climb_number = ratings.inject{ |sum, el| sum + el }.to_f / ratings.size
    Climb::get_string_rating(average_climb_number)
  end

end