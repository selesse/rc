require 'rock/climbing/climb'

describe Climb do
    it 'should have sane defaults' do
        climb = Climb.new(5.7)

        expect(climb.rating).to eq('5.7')
        expect(climb.sent).to eq(false)
        expect(climb.percentage).to eq(1.0)
    end
end
