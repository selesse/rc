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

      ratings << (get_numeric_rating(rating) * percentage) if times == 1
    end

    0 if ratings.empty?
    # Average of the array
    average_climb_number = ratings.inject{ |sum, el| sum + el }.to_f / ratings.size
    get_string_rating(average_climb_number)
  end

  def self.get_numeric_rating(climb_rating_string)
    # i.e. 5.6, 5.6+ or 5.6 +
    rating_regexp = /[0-9]\.([0-9]+ *([-+]?))/

    climbing_rating = climb_rating_string[rating_regexp, 1]
    postfix_rating = climb_rating_string[rating_regexp, 2]

    climbing_modifier = 0

    if postfix_rating.to_s == '+'
      climbing_modifier = 1
    elsif postfix_rating.to_s == '-'
      climbing_modifier = -1
    end

    raise "invalid rock climbing format for #{climb_rating_string}" if climbing_rating.nil?

    (climbing_rating.to_i * 3) + climbing_modifier
  end

  def self.get_string_rating(numeric_rating)
    # TODO: Obviously, only climbs that start with "5" are valid
    '%4.2f' % (5 + (numeric_rating / 3.0) / 10)
  end

end