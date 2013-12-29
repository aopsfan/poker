require_relative "../../spec_helper.rb"

describe FourOfAKind do
  
  let(:quads_queens) do
    hand = FourOfAKind.new
    hand.set = [Card.new(:queen, :clubs), Card.new(:queen, :hearts), Card.new(:queen, :diamonds), Card.new(:queen, :spades)]
    return hand
  end
  
  let(:quads_aces) do
    hand = FourOfAKind.new
    hand.set = [Card.new(:ace, :spades), Card.new(:ace, :diamonds), Card.new(:ace, :hearts), Card.new(:ace, :clubs)]
    return hand
  end
  
  let(:quads_tens) do
    hand = FourOfAKind.new
    hand.set = [Card.new(:ten, :hearts), Card.new(:ten, :clubs), Card.new(:ten, :spades), Card.new(:ten, :diamonds)]
    return hand
  end
  
  describe "#generate" do
    let(:generated_hand) do
      FourOfAKind.generate [Card.new(:five, :diamonds), Card.new(:three, :spades),
                            Card.new(:five, :clubs), Card.new(:five, :hearts),
                            Card.new(:five, :spades)]
    end
    
    let(:bad_generated_hand) do
      FourOfAKind.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                            Card.new(:four, :clubs), Card.new(:five, :hearts),
                            Card.new(:ace, :spades)]
    end
    
    let(:bad_generated_hand_2) do
      FourOfAKind.generate [Card.new(:five, :diamonds), Card.new(:three, :spades),
                            Card.new(:four, :clubs), Card.new(:five, :hearts),
                            Card.new(:five, :spades)]
    end
    
    context "when good hand is generated" do
      describe "set" do
        subject {generated_hand.set}
        
        it "should have 4 cards" do
          expect(subject.length).to eq 4
        end
    
        it "should be Fives" do
          expect(subject[0].rank).to eq :five
          expect(subject[1].rank).to eq :five
          expect(subject[2].rank).to eq :five
          expect(subject[3].rank).to eq :five
        end
      end
      
      describe "kickers" do
        subject {generated_hand.kickers}
        
        it "should have 1 object" do
          expect(subject.length).to eq 1
        end
        
        it "should not have the set" do
          expect(subject.include? generated_hand.set[0]).to be_false
          expect(subject.include? generated_hand.set[1]).to be_false
          expect(subject.include? generated_hand.set[2]).to be_false
          expect(subject.include? generated_hand.set[3]).to be_false
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
    describe "Quads (Queens)" do
      it "should be less than Quads (Aces)" do
        expect(quads_queens < quads_aces).to be_true
      end
      
      it "should be greater than Quads (Tens)" do
        expect(quads_queens > quads_tens).to be_true
      end
    end
  end
  
  describe "#to_s" do
    describe "hand with three Qs" do
      it "should output 'Quads (Queens)'" do
        expect(quads_queens.to_s).to eq "Quads (Queens)"
      end
    end
    
    describe "hand with three As" do
      it "should output 'Quads (Aces)'" do
        expect(quads_aces.to_s).to eq "Quads (Aces)"
      end
    end
    
    describe "hand with three 10s" do
      it "should output 'Quads (Tens)'" do
        expect(quads_tens.to_s).to eq "Quads (Tens)"
      end
    end
  end
  
end