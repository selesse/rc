class Climb
    attr_reader :rating, :percentage, :sent, :times

    # TODO: nil stuff for initialization
    def initialize(rating, args={})
        @rating = rating.to_s
        @percentage = args[:percentage] || 1.0
        @times = args[:times] || 1
        @sent = args[:sent] || false
    end
end
