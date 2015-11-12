class Climb
    include Comparable
    attr_reader :rating, :percentage, :sent, :times, :failed

    # TODO: nil stuff for initialization
    def initialize(rating, args={})
        @rating = rating.to_s
        @percentage = args[:percentage] || 1.0
        @times = args[:times] || 1
        @sent = args[:sent] || false
        @failed = args[:failed] || @percentage < 1.0
    end

    def sent?
      @sent == true
    end

    def <=>(another_climb)
      Climb::get_numeric_rating(rating) - Climb::get_numeric_rating(another_climb.rating)
    end

    def to_s
      string="#{rating}"
      if percentage != 1.0
        string += " (#{'%2.0f' % (percentage * 100)}%)"
      elsif failed
        string += ' (failed)'
      elsif sent?
        string += ' (sent)'
      end
      if times > 1
        string += " x #{times}"
      end

      string
    end

    def self.get_numeric_rating(climb_rating_string)
      # i.e. 5.6, 5.6+ or 5.6 +
      rating_regexp = /[0-9]\.([0-9]+ *([-+abcd]?))/

      climbing_rating = climb_rating_string[rating_regexp, 1]
      postfix_rating = climb_rating_string[rating_regexp, 2]

      climbing_modifier = 0

      high_level_climb = climbing_rating.to_i >= 10

      if postfix_rating.to_s == 'a'
          climbing_modifier = -3
      elsif postfix_rating.to_s == '-'
          climbing_modifier = -2
      elsif postfix_rating.to_s == 'b'
          climbing_modifier = -1
      elsif postfix_rating.to_s == 'c'
          climbing_modifier = 1
      elsif postfix_rating.to_s == '+'
          climbing_modifier = 2
      elsif postfix_rating.to_s == 'd'
          climbing_modifier = 3
      end

      climbing_modifier = climbing_modifier / 2 unless high_level_climb

      raise "invalid rock climbing format for #{climb_rating_string}" if climbing_rating.nil?

      if high_level_climb
        return ((climbing_rating.to_i * 7) + climbing_modifier).to_i
      else
        return ((climbing_rating.to_i * 4) + climbing_modifier).to_i
      end
    end

    def self.get_string_rating(numeric_rating)
      # TODO: Obviously, only climbs that start with "5" are valid
      '%4.2f' % (5 + (numeric_rating / 4.0) / 10)
    end

end
