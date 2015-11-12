class ClimbingSession
  attr_accessor :date, :climbs, :gym_name

  def initialize(args={})
    @climbs = args[:climbs] || []
    @date = args[:date]
    @gym_name = args[:gym_name]
  end

  def << (climb)
    @climbs << climb
  end
end
