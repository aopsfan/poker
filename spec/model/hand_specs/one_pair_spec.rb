require_relative "../../spec_helper.rb"

describe OnePair do
  
  let(:queens) do
    hand = OnePair.new
    hand.pair = [Card.new(:queen, :clubs), Card.new(:queen, :hearts)]
    return hand
  end
  
  let(:aces) do
    hand = OnePair.new
    hand.pair = [Card.new(:ace, :spades), Card.new(:ace, :diamonds)]
    return hand
  end
  
  let(:tens) do
    hand = OnePair.new
    hand.pair = [Card.new(:ten, :hearts), Card.new(:ten, :clubs)]
    return hand
  end
  
  let(:queens_2) do
    hand = OnePair.new
    hand.pair = [Card.new(:queen, :spades), Card.new(:queen, :diamonds)]
    return hand
  end
  
  describe "#generate" do
    let(:generated_hand) do
      OnePair.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                        Card.new(:four, :clubs), Card.new(:five, :hearts),
                        Card.new(:five, :spades)]
    end
    
    let(:bad_generated_hand) do
      OnePair.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                        Card.new(:four, :clubs), Card.new(:five, :hearts),
                        Card.new(:ace, :spades)]
    end
    
    context "when good hand is generated" do
      describe "pair" do
        subject {generated_hand.pair}
        
        it "has 2 cards" do
          expect(subject.length).to eq 2
        end
    
        it "is Fives" do
          expect(subject[0].rank).to eq :five
          expect(subject[1].rank).to eq :five
        end
      end
      
      describe "kickers" do
        subject {generated_hand.kickers}
        
        it "has 3 objects" do
          expect(subject.length).to eq 3
        end
        
        it "does not have the pair" do
          expect(subject.include? generated_hand.pair[0]).to be_false
          expect(subject.include? generated_hand.pair[1]).to be_false
        end
      end
    end
    
    context "when bad hand is generated" do
      it "is nil" do
        expect(bad_generated_hand).to be_nil
      end
    end
  end
  
  describe "#<=>" do
    describe "Queens" do
      it "is less than Aces" do
        expect(queens < aces).to be_true
      end
      
      it "is greater than Tens" do
        expect(queens > tens).to be_true
      end
      
      it "is equal to other Queens" do
        expect(queens == queens_2).to be_true
      end
    end
  end
  
  describe "#to_s" do
    describe "hand with pair of Qs" do
      it "returns 'Pair of Queens'" do
        expect(queens.to_s).to eq "Pair of Queens"
      end
    end
    
    describe "hand with pair of As" do
      it "returns 'Pair of Aces'" do
        expect(aces.to_s).to eq "Pair of Aces"
      end
    end
    
    describe "hand with pair of 10s" do
      it "returns 'Pair of Tens'" do
        expect(tens.to_s).to eq "Pair of Tens"
      end
    end
  end
  
end