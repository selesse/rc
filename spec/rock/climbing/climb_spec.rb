require 'rock/climbing/climb'

describe Climb do
  it 'should have sane defaults' do
    climb = Climb.new(5.7)

    expect(climb.rating).to eq('5.7')
    expect(climb.sent).to eq(false)
    expect(climb.percentage).to eq(1.0)
  end

  describe 'when rating difficulties' do
    it 'should have an equal rating between a 5.x- and a 5.x+' do
      five_nine_minus_rating = Climb.get_numeric_rating("5.9-")
      five_nine_rating = Climb.get_numeric_rating("5.9")
      five_nine_plus_rating = Climb.get_numeric_rating("5.9+")

      expect(five_nine_rating - five_nine_minus_rating).to \
                be (five_nine_plus_rating - five_nine_rating)
    end

    it 'should rate 5.9+ as less than 5.10a' do
      five_nine_plus_rating = Climb.get_numeric_rating('5.9+')
      five_ten_a_rating = Climb.get_numeric_rating('5.10a')
      expect(five_nine_plus_rating).to be <= five_ten_a_rating
    end

    it 'should have a numeric difference of 1 between 5.10d and 5.11a' do
      five_ten_d_rating = Climb.get_numeric_rating('5.10d')
      five_eleven_a_rating = Climb.get_numeric_rating('5.11a')
      expect(five_ten_d_rating).to be five_eleven_a_rating - 1
    end

    it 'should rate 5.10[abcd] climbs as fractions of 5.10[-+]' do
      smallest_rating = Climb.get_numeric_rating('5.10a')

      # Essentially, the numeric values are irrelevant, as long as the
      # distribution is normalized.
      expect(Climb.get_numeric_rating("5.10a")).to be smallest_rating
      expect(Climb.get_numeric_rating("5.10-")).to be smallest_rating + 1
      expect(Climb.get_numeric_rating("5.10b")).to be smallest_rating + 2
      expect(Climb.get_numeric_rating("5.10")).to be smallest_rating + 3
      expect(Climb.get_numeric_rating("5.10c")).to be smallest_rating + 4
      expect(Climb.get_numeric_rating("5.10+")).to be smallest_rating + 5
      expect(Climb.get_numeric_rating("5.10d")).to be smallest_rating + 6
    end
  end

end
