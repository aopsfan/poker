require_relative "../spec_helper.rb"

class DummyTwoPair < Hand
  def self.rank
    :two_pair
  end
end

class DummyFourOfAKind < Hand
  def self.rank
    :four_of_a_kind
  end
end

describe Hand do
  
  describe "#<=>" do
    let(:two_pair) {DummyTwoPair.new}
    let(:four_of_a_kind) {DummyFourOfAKind.new}
    
    describe "four of a kind" do
      it "should be greater than two pair" do
        expect(four_of_a_kind > two_pair).to be_true
      end
    end
    
    describe "two pair" do
      it "should be less than four of a kind" do
        expect(two_pair < four_of_a_kind).to be_true
      end
    end
  end
  
  describe "#compare_kickers" do
    let(:hand_1) do
      hand = Hand.new
      hand.kickers = [Card.new(:six, :diamonds), Card.new(:five, :spades), Card.new(:ten, :spades)]
      hand
    end

    let(:hand_2) do
      hand = Hand.new
      hand.kickers = [Card.new(:ace, :spades), Card.new(:two, :clubs), Card.new(:two, :spades)]
      hand
    end

    let(:hand_3) do
      hand = Hand.new
      hand.kickers = [Card.new(:six, :hearts), Card.new(:two, :diamonds), Card.new(:ten, :hearts)]
      hand
    end

    let(:hand_4) do
      hand = Hand.new
      hand.kickers = [Card.new(:two, :hearts), Card.new(:three, :spades), Card.new(:three, :diamonds)]
      hand
    end

    let(:hand_5) do
      hand = Hand.new
      hand.kickers = [Card.new(:six, :clubs), Card.new(:five, :clubs), Card.new(:ten, :diamonds)]
      hand
    end
    
    describe "hand_1" do
      subject {hand_1}
      
      it "should have lower value kickers than hand_2" do
        expect(subject.compare_kickers hand_2).to eq -1
      end
      
      it "should have higher value kickers than hand_3" do
        expect(subject.compare_kickers hand_3).to eq 1
      end
      
      it "should have higher value kickers than hand_4" do
        expect(subject.compare_kickers hand_4).to eq 1
      end
      
      it "should have equal value kickers to hand_5" do
        expect(subject.compare_kickers hand_5).to eq 0
      end
    end
  end
  
end