require_relative "../../spec_helper.rb"

describe FullHouse do
  
  let(:queens_full_of_eights) do
    hand = FullHouse.new
    hand.set = [Card.new(:queen, :clubs), Card.new(:queen, :hearts), Card.new(:queen, :diamonds)]
    hand.pair = [Card.new(:eight, :spades), Card.new(:eight, :diamonds)]
    return hand
  end
  
  let(:aces_full_of_twos) do
    hand = FullHouse.new
    hand.set = [Card.new(:ace, :spades), Card.new(:ace, :diamonds), Card.new(:ace, :hearts)]
    hand.pair = [Card.new(:two, :clubs), Card.new(:two, :hearts)]
    return hand
  end
  
  let(:tens_full_of_queens) do
    hand = FullHouse.new
    hand.set = [Card.new(:ten, :hearts), Card.new(:ten, :clubs), Card.new(:ten, :spades)]
    hand.pair = [Card.new(:queen, :diamonds), Card.new(:queen, :spades)]
    return hand
  end
  
  let(:twos_full_of_eights) do
    hand = FullHouse.new
    hand.set = [Card.new(:two, :spades), Card.new(:two, :diamonds), Card.new(:two, :hearts)]
    hand.pair = [Card.new(:eight, :clubs), Card.new(:eight, :hearts)]
    return hand
  end
  
  describe "#generate" do
    let(:generated_hand) do
      FullHouse.generate [Card.new(:two, :diamonds), Card.new(:two, :spades),
                          Card.new(:five, :clubs), Card.new(:five, :hearts),
                          Card.new(:five, :spades)]
    end
    
    let(:generated_hand_2) do
      FullHouse.generate [Card.new(:five, :diamonds), Card.new(:five, :spades),
                          Card.new(:two, :clubs), Card.new(:two, :hearts),
                          Card.new(:two, :spades)]
    end
    
    let(:bad_generated_hand) do
      FullHouse.generate [Card.new(:two, :diamonds), Card.new(:two, :spades),
                          Card.new(:four, :clubs), Card.new(:five, :hearts),
                          Card.new(:five, :spades)]
    end
    
    let(:bad_generated_hand_2) do
      FullHouse.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                          Card.new(:four, :clubs), Card.new(:five, :hearts),
                          Card.new(:six, :spades)]
    end
    
    context "when Fives full of Twos is generated" do
      describe "set" do
        subject {generated_hand.set}
        
        it "has 3 cards" do
          expect(subject.length).to eq 3
        end
    
        it "is Fives" do
          expect(subject[0].rank).to eq :five
          expect(subject[1].rank).to eq :five
          expect(subject[2].rank).to eq :five
        end
      end
      
      describe "pair" do
        subject {generated_hand.pair}
        
        it "has 2 cards" do
          expect(subject.length).to eq 2
        end
        
        it "is Twos" do
          expect(subject[0].rank).to eq :two
          expect(subject[1].rank).to eq :two
        end
      end
      
      describe "kickers" do
        subject {generated_hand.kickers}
        
        it "is empty" do
          expect(subject.empty?).to be_true
        end
      end
    end
    
    context "when Twos full of Fives is generated" do
      describe "set" do
        subject {generated_hand_2.set}
        
        it "has 3 cards" do
          expect(subject.length).to eq 3
        end
    
        it "is Twos" do
          expect(subject[0].rank).to eq :two
          expect(subject[1].rank).to eq :two
          expect(subject[2].rank).to eq :two
        end
      end
      
      describe "pair" do
        subject {generated_hand_2.pair}
        
        it "has 2 cards" do
          expect(subject.length).to eq 2
        end
        
        it "is Fives" do
          expect(subject[0].rank).to eq :five
          expect(subject[1].rank).to eq :five
        end
      end
      
      describe "kickers" do
        subject {generated_hand_2.kickers}
        
        it "is empty" do
          expect(subject.empty?).to be_true
        end
      end
    end
    
    context "when bad hand is generated" do
      it "is nil" do
        expect(bad_generated_hand).to be_nil
        expect(bad_generated_hand_2).to be_nil
      end
    end
  end
  
  describe "#<=>" do
    describe "Queens full of Eights" do
      it "is less than Aces over Twos" do
        expect(queens_full_of_eights < aces_full_of_twos).to be_true
      end
      
      it "is greater than Tens full of queens" do
        expect(queens_full_of_eights > tens_full_of_queens).to be_true
      end
      
      it "is greater than Twos full of Eights" do
        expect(queens_full_of_eights > twos_full_of_eights).to be_true
      end
    end
  end
  
  describe "#to_s" do
    describe "hand with three Qs and pair of 8s" do
      it "returns 'Queens full of Eights'" do
        expect(queens_full_of_eights.to_s).to eq "Queens full of Eights"
      end
    end
    
    describe "hand with three As and pair of 2s" do
      it "returns 'Aces full of Twos'" do
        expect(aces_full_of_twos.to_s).to eq "Aces full of Twos"
      end
    end
    
    describe "hand with three 10s and pair of Qs" do
      it "returns 'Tens full of Queens'" do
        expect(tens_full_of_queens.to_s).to eq "Tens full of Queens"
      end
    end
    
    describe "hand with three 2s and pair of 8s" do
      it "returns 'Twos full of Eights'" do
        expect(twos_full_of_eights.to_s).to eq "Twos full of Eights"
      end
    end
  end
  
end