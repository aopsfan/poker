require_relative "../../spec_helper.rb"

describe HighCard do
  
  let(:queen_high) do
    hand = HighCard.new
    hand.high = Card.new(:queen, :clubs)
    return hand
  end
  
  let(:ace_high) do
    hand = HighCard.new
    hand.high = Card.new(:ace, :spades)
    return hand
  end
  
  let(:ten_high) do
    hand = HighCard.new
    hand.high = Card.new(:ten, :hearts)
    return hand
  end
  
  let(:queen_high_2) do
    hand = HighCard.new
    hand.high = Card.new(:queen, :spades)
    return hand
  end
  
  describe "#generate" do
    let(:generated_hand) do
      HighCard.new
      HighCard.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                         Card.new(:four, :clubs), Card.new(:five, :hearts),
                         Card.new(:ace, :spades)]
    end
    
    context "when hand is generated" do
      describe "high" do
        subject {generated_hand.high}
        
        it "should be an ace" do
          expect(subject.rank).to eq :ace
        end
    
        it "should be a spade" do
          expect(subject.suit).to eq :spades
        end
      end
      
      describe "kickers" do
        subject {generated_hand.kickers}
        
        it "should have 4 objects" do
          expect(subject.length).to eq 4
        end
        
        it "should not have the high" do
          expect(subject.include? generated_hand.high).to be_false
        end
      end
    end
  end
  
  describe "#<=>" do
    describe "Queen high" do
      it "should be less than Ace high" do
        expect(queen_high < ace_high).to be_true
      end
      
      it "should be greater than Ten high" do
        expect(queen_high > ten_high).to be_true
      end
      
      it "should be equal to other Queen high" do
        expect(queen_high == queen_high_2).to be_true
      end
    end
  end
  
  describe "#to_s" do
    describe "hand with high card QC" do
      it "should output 'Queen high'" do
        expect(queen_high.to_s).to eq "Queen high"
      end
    end
    
    describe "hand with high card AS" do
      it "should output 'Ace high'" do
        expect(ace_high.to_s).to eq "Ace high"
      end
    end
    
    describe "hand with high card TH" do
      it "should output 'Ten high'" do
        expect(ten_high.to_s).to eq "Ten high"
      end
    end
  end
  
end