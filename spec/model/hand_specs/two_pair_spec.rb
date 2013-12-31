require_relative "../../spec_helper.rb"

describe TwoPair do
  
  let(:queens_over_eights) do
    hand = TwoPair.new
    hand.high_pair = [Card.new(:queen, :clubs), Card.new(:queen, :hearts)]
    hand.low_pair = [Card.new(:eight, :spades), Card.new(:eight, :diamonds)]
    return hand
  end
  
  let(:aces_over_twos) do
    hand = TwoPair.new
    hand.high_pair = [Card.new(:ace, :spades), Card.new(:ace, :diamonds)]
    hand.low_pair = [Card.new(:two, :clubs), Card.new(:two, :hearts)]
    return hand
  end
  
  let(:tens_over_eights) do
    hand = TwoPair.new
    hand.high_pair = [Card.new(:ten, :hearts), Card.new(:ten, :clubs)]
    hand.low_pair = [Card.new(:eight, :diamonds), Card.new(:eight, :spades)]
    return hand
  end
  
  let(:queens_over_sixes) do
    hand = TwoPair.new
    hand.high_pair = [Card.new(:queen, :spades), Card.new(:queen, :diamonds)]
    hand.low_pair = [Card.new(:six, :clubs), Card.new(:six, :hearts)]
    return hand
  end
  
  let(:queens_over_eights_2) do
    hand = TwoPair.new
    hand.high_pair = [Card.new(:queen, :spades), Card.new(:queen, :diamonds)]
    hand.low_pair = [Card.new(:eight, :clubs), Card.new(:eight, :hearts)]
    return hand
  end
  
  describe "#generate" do
    let(:generated_hand) do
      TwoPair.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                        Card.new(:three, :clubs), Card.new(:five, :hearts),
                        Card.new(:five, :spades)]
    end
    
    let(:bad_generated_hand_1) do
      TwoPair.generate [Card.new(:five, :diamonds), Card.new(:three, :spades),
                        Card.new(:four, :clubs), Card.new(:five, :hearts),
                        Card.new(:five, :spades)]
    end
    
    let(:bad_generated_hand_2) do
      TwoPair.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                        Card.new(:four, :clubs), Card.new(:five, :hearts),
                        Card.new(:ace, :spades)]
    end
    
    context "when good hand is generated" do
      describe "high pair" do
        subject {generated_hand.high_pair}
        
        it "has 2 cards" do
          expect(subject.length).to eq 2
        end
    
        it "is Fives" do
          expect(subject[0].rank).to eq :five
          expect(subject[1].rank).to eq :five
        end
      end
      
      describe "low pair" do
        subject {generated_hand.low_pair}
        
        it "has 2 cards" do
          expect(subject.length).to eq 2
        end
        
        it "is Threes" do
          expect(subject[0].rank).to eq :three
          expect(subject[1].rank).to eq :three
        end
      end
      
      describe "kickers" do
        subject {generated_hand.kickers}
        
        it "has 1 object" do
          expect(subject.length).to eq 1
        end
        
        it "does not have either pair" do
          expect(subject.include? generated_hand.high_pair[0]).to be_false
          expect(subject.include? generated_hand.high_pair[1]).to be_false
          expect(subject.include? generated_hand.low_pair[0]).to be_false
          expect(subject.include? generated_hand.low_pair[1]).to be_false
        end
      end
    end
    
    context "when bad hand is generated" do
      it "is nil" do
        expect(bad_generated_hand_1).to be_nil
        expect(bad_generated_hand_2).to be_nil
      end
    end
  end
  
  describe "#<=>" do
    describe "Queens over Eights" do
      it "is less than Aces over Twos" do
        expect(queens_over_eights < aces_over_twos).to be_true
      end
      
      it "is greater than Tens over Eights" do
        expect(queens_over_eights > tens_over_eights).to be_true
      end
      
      it "is greater than Queens over Sixes" do
        expect(queens_over_eights > queens_over_sixes).to be_true
      end
      
      it "is equal to other Queens over Eights" do
        expect(queens_over_eights == queens_over_eights_2).to be_true
      end
    end
  end
  
  describe "#to_s" do
    describe "hand with pair of Qs and pair of 8s" do
      it "returns 'Queens over Eights'" do
        expect(queens_over_eights.to_s).to eq "Queens over Eights"
      end
    end
    
    describe "hand with pair of Qs and pair of 6s" do
      it "returns 'Queens over Sixes'" do
        expect(queens_over_sixes.to_s).to eq "Queens over Sixes"
      end
    end
    
    describe "hand with pair of As and pair of 2s" do
      it "returns 'Aces over Twos'" do
        expect(aces_over_twos.to_s).to eq "Aces over Twos"
      end
    end
    
    describe "hand with pair of 10s and pair of 8s" do
      it "returns 'Tens over Eights'" do
        expect(tens_over_eights.to_s).to eq "Tens over Eights"
      end
    end
  end
  
end