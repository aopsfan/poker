describe Hand do
  before :each do
    @sorted_hands = [Flush.new, FourOfAKind.new, FullHouse.new,
                     HighCard.new, OnePair.new, Straight.new,
                     StraightFlush.new, ThreeOfAKind.new, TwoPair.new].sort do |a, b|
      b <=> a
    end
  end
  
  describe "#rank" do
    context "when sorting hands with unique ranks" do
      describe "highest rank" do
        it "should be Straight Flush" do
          expect(@sorted_hands[0]).to be_a StraightFlush
        end
      end
      
      describe "second-highest rank" do
        it "should be Four of a Kind" do
          expect(@sorted_hands[1]).to be_a FourOfAKind
        end
      end
      
      describe "third-highest rank" do
        it "should be Full House" do
          expect(@sorted_hands[2]).to be_a FullHouse
        end
      end
      
      describe "fourth-highest rank" do
        it "should be Flush" do
          expect(@sorted_hands[3]).to be_a Flush
        end
      end
      
      describe "middle rank" do
        it "should be Straight" do
          expect(@sorted_hands[4]).to be_a Straight
        end
      end
      
      describe "fourth-lowest rank" do
        it "should be Three of a Kind" do
          expect(@sorted_hands[5]).to be_a ThreeOfAKind
        end
      end
      
      describe "third-lowest rank" do
        it "should be Two Pair" do
          expect(@sorted_hands[6]).to be_a TwoPair
        end
      end
      
      describe "second-lowest rank" do
        it "should be One Pair" do
          expect(@sorted_hands[7]).to be_a OnePair
        end
      end
      
      describe "lowest rank" do
        it "should be High Card" do
          expect(@sorted_hands[8]).to be_a HighCard
        end
      end
    end
  end
end