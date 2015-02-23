class ClimbsFixture
  def self.get
    [
        Climb.new('5.5', sent: false),
        Climb.new('5.6', sent: true),
        Climb.new('5.10', sent: false),
        Climb.new('5.8', sent: true),
    ]
  end
end