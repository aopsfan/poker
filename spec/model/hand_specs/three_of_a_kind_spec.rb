require_relative "../../spec_helper.rb"

describe ThreeOfAKind do
  
  let(:trips_queens) do
    hand = ThreeOfAKind.new
    hand.set = [Card.new(:queen, :clubs), Card.new(:queen, :hearts), Card.new(:queen, :diamonds)]
    return hand
  end
  
  let(:trips_aces) do
    hand = ThreeOfAKind.new
    hand.set = [Card.new(:ace, :spades), Card.new(:ace, :diamonds), Card.new(:ace, :hearts)]
    return hand
  end
  
  let(:trips_tens) do
    hand = ThreeOfAKind.new
    hand.set = [Card.new(:ten, :hearts), Card.new(:ten, :clubs), Card.new(:ten, :spades)]
    return hand
  end
  
  describe "#generate" do
    let(:generated_hand) do
      ThreeOfAKind.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                             Card.new(:five, :clubs), Card.new(:five, :hearts),
                             Card.new(:five, :spades)]
    end
    
    let(:bad_generated_hand) do
      ThreeOfAKind.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                             Card.new(:four, :clubs), Card.new(:five, :hearts),
                             Card.new(:ace, :spades)]
    end
    
    let(:bad_generated_hand_2) do
      ThreeOfAKind.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                             Card.new(:four, :clubs), Card.new(:five, :hearts),
                             Card.new(:five, :spades)]
    end
    
    context "when good hand is generated" do
      describe "set" do
        subject {generated_hand.set}
        
        it "should have 3 cards" do
          expect(subject.length).to eq 3
        end
    
        it "should be Fives" do
          expect(subject[0].rank).to eq :five
          expect(subject[1].rank).to eq :five
          expect(subject[2].rank).to eq :five
        end
      end
      
      describe "kickers" do
        subject {generated_hand.kickers}
        
        it "should have 2 objects" do
          expect(subject.length).to eq 2
        end
        
        it "should not have the set" do
          expect(subject.include? generated_hand.set[0]).to be_false
          expect(subject.include? generated_hand.set[1]).to be_false
          expect(subject.include? generated_hand.set[2]).to be_false
        end
      end
    end
    
    context "when bad hand is generated" do
      it "should be nil" do
        expect(bad_generated_hand).to be_nil
        expect(bad_generated_hand_2).to be_nil
      end
    end
  end
  
  describe "#<=>" do
    describe "Trips (Queens)" do
      it "should be less than Trips (Aces)" do
        expect(trips_queens < trips_aces).to be_true
      end
      
      it "should be greater than Trips (Tens)" do
        expect(trips_queens > trips_tens).to be_true
      end
    end
  end
  
  describe "#to_s" do
    describe "hand with three Qs" do
      it "should output 'Trips (Queens)'" do
        expect(trips_queens.to_s).to eq "Trips (Queens)"
      end
    end
    
    describe "hand with three As" do
      it "should output 'Trips (Aces)'" do
        expect(trips_aces.to_s).to eq "Trips (Aces)"
      end
    end
    
    describe "hand with three 10s" do
      it "should output 'Trips (Tens)'" do
        expect(trips_tens.to_s).to eq "Trips (Tens)"
      end
    end
  end
  
end