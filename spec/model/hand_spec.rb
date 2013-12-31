require_relative "../spec_helper.rb"

class DummyTwoPair < Hand
  def self.rank
    :two_pair
  end
  
  def compare_same_rank(hand)
    0
  end
end

class DummyFourOfAKind < Hand
  def self.rank
    :four_of_a_kind
  end
  
  def compare_same_rank(hand)
    0
  end
end

describe Hand do
  
  describe "#<=>" do
    let(:two_pair) {DummyTwoPair.new}
    let(:four_of_a_kind) {DummyFourOfAKind.new}
    
    context "when comparing hands of different ranks" do
      describe "four of a kind" do
        it "is always greater than two pair" do
          expect(four_of_a_kind > two_pair).to be_true
        end
      end

      describe "two pair" do
        it "is always less than four of a kind" do
          expect(two_pair < four_of_a_kind).to be_true
        end
      end
    end
    
    let(:hand_1) do
      hand = DummyTwoPair.new
      hand.kickers = [Card.new(:six, :diamonds), Card.new(:five, :spades), Card.new(:ten, :spades)]
      hand
    end

    let(:hand_2) do
      hand = DummyTwoPair.new
      hand.kickers = [Card.new(:ace, :spades), Card.new(:two, :clubs), Card.new(:two, :spades)]
      hand
    end

    let(:hand_3) do
      hand = DummyTwoPair.new
      hand.kickers = [Card.new(:six, :hearts), Card.new(:two, :diamonds), Card.new(:ten, :hearts)]
      hand
    end

    let(:hand_4) do
      hand = DummyTwoPair.new
      hand.kickers = [Card.new(:two, :hearts), Card.new(:three, :spades), Card.new(:three, :diamonds)]
      hand
    end

    let(:hand_5) do
      hand = DummyTwoPair.new
      hand.kickers = [Card.new(:six, :clubs), Card.new(:five, :clubs), Card.new(:ten, :diamonds)]
      hand
    end
    
    context "when comparing hands of the same rank" do
      describe "hand_1" do
        it "has lower value kickers than hand_2" do
          expect(hand_1 < hand_2).to be_true
        end

        it "has higher value kickers than hand_3" do
          expect(hand_1 > hand_3).to be_true
        end

        it "has higher value kickers than hand_4" do
          expect(hand_1 > hand_4).to be_true
        end

        it "has equal value kickers to hand_5" do
          expect(hand_1 == hand_5).to be_true
        end
      end
    end
    
  end
  
end