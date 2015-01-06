class ClimbingSession
    attr_accessor :date, :climbs

    def initialize(args={})
        @climbs = args[:climbs] || []
        @date = args[:date]
    end

    def << (climb)
        @climbs << climb
    end
end
