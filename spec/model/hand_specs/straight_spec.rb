require_relative "../../spec_helper.rb"

describe Straight do
  
  let(:queen_high_straight) do
    hand = Straight.new
    hand.straight_cards = [Card.new(:eight, :clubs), Card.new(:nine, :hearts),
                           Card.new(:ten, :spades), Card.new(:jack, :diamonds),
                           Card.new(:queen, :clubs)]
    return hand
  end
  
  let(:royal_straight) do
    hand = Straight.new
    hand.straight_cards = [Card.new(:ten, :clubs), Card.new(:jack, :hearts),
                           Card.new(:queen, :spades), Card.new(:king, :diamonds),
                           Card.new(:ace, :clubs)]
    return hand
  end
  
  let(:ten_high_straight) do
    hand = Straight.new
    hand.straight_cards = [Card.new(:six, :clubs), Card.new(:seven, :hearts),
                           Card.new(:eight, :spades), Card.new(:nine, :diamonds),
                           Card.new(:ten, :clubs)]
    return hand
  end
  
  let(:queen_high_straight_2) do
    hand = Straight.new
    hand.straight_cards = [Card.new(:eight, :spades), Card.new(:nine, :diamonds),
                           Card.new(:ten, :clubs), Card.new(:jack, :hearts),
                           Card.new(:queen, :spades)]
    return hand
  end
  
  let(:five_high_straight) do
    ace = Card.new(:ace, :spades)
    ace.low_card = true
    hand = Straight.new
    hand.straight_cards = [ace, Card.new(:two, :diamonds),
                           Card.new(:three, :spades), Card.new(:four, :clubs),
                           Card.new(:five, :hearts)]
    return hand
  end
  
  describe "#generate" do
    let(:generated_hand) do
      Straight.generate [Card.new(:two, :diamonds), Card.new(:four, :spades),
                         Card.new(:three, :clubs), Card.new(:five, :hearts),
                         Card.new(:six, :spades)]
    end
    
    let(:generated_hand_2) do
      Straight.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                         Card.new(:four, :clubs), Card.new(:five, :hearts),
                         Card.new(:ace, :spades)]
    end
    
    let(:generated_hand_3) do
      Straight.generate [Card.new(:ten, :diamonds), Card.new(:ace, :spades),
                         Card.new(:jack, :clubs), Card.new(:queen, :hearts),
                         Card.new(:king, :spades)]
    end
    
    let(:bad_generated_hand) do
      Straight.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                         Card.new(:four, :clubs), Card.new(:five, :hearts),
                         Card.new(:five, :spades)]
    end
    
    let(:bad_generated_hand_2) do
      Straight.generate [Card.new(:two, :diamonds), Card.new(:three, :spades),
                         Card.new(:queen, :clubs), Card.new(:king, :hearts),
                         Card.new(:ace, :spades)]
    end
    
    context "when Six-high straight is generated" do
      describe "straight cards" do
        subject {generated_hand.straight_cards}
    
        it "has 5 objects" do
          expect(subject.length).to eq 5
        end
        
        it "is in sequential order" do
          expect(subject[0].rank).to eq :two
          expect(subject[1].rank).to eq :three
          expect(subject[2].rank).to eq :four
          expect(subject[3].rank).to eq :five
          expect(subject[4].rank).to eq :six
        end
      end
      
      describe "kickers" do
        subject {generated_hand.kickers}
        
        it "is empty" do
          expect(subject.empty?).to be_true
        end
      end
    end
    
    context "when Five-high straight is generated" do
      describe "straight cards" do
        subject {generated_hand_2.straight_cards}
    
        it "has 5 objects" do
          expect(subject.length).to eq 5
        end
        
        it "is in sequential order" do
          expect(subject[0].rank).to eq :ace
          expect(subject[1].rank).to eq :two
          expect(subject[2].rank).to eq :three
          expect(subject[3].rank).to eq :four
          expect(subject[4].rank).to eq :five
        end
      end
      
      describe "kickers" do
        subject {generated_hand_2.kickers}
        
        it "is empty" do
          expect(subject.empty?).to be_true
        end
      end
    end
    
    context "when Royal straight is generated" do
      describe "straight cards" do
        subject {generated_hand_3.straight_cards}
    
        it "has 5 objects" do
          expect(subject.length).to eq 5
        end
        
        it "is in sequential order" do
          expect(subject[0].rank).to eq :ten
          expect(subject[1].rank).to eq :jack
          expect(subject[2].rank).to eq :queen
          expect(subject[3].rank).to eq :king
          expect(subject[4].rank).to eq :ace
        end
      end
      
      describe "kickers" do
        subject {generated_hand_3.kickers}
        
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
    describe "Queen-high straight" do
      it "is less than Royal straight" do
        expect(queen_high_straight < royal_straight).to be_true
      end
      
      it "is greater than Ten-high straight" do
        expect(queen_high_straight > ten_high_straight).to be_true
      end
      
      it "is greater than Five-high straight" do
        expect(queen_high_straight > five_high_straight).to be_true
      end
      
      it "is equal to other Queen-high straight" do
        expect(queen_high_straight == queen_high_straight_2).to be_true
      end
    end
  end
  
  describe "#to_s" do
    describe "8-9-10-J-Q hand" do
      it "returns 'Queen-high straight'" do
        expect(queen_high_straight.to_s).to eq "Queen-high straight"
      end
    end
    
    describe "10-J-Q-K-A hand" do
      it "returns 'Royal straight'" do
        expect(royal_straight.to_s).to eq "Royal straight"
      end
    end
    
    describe "6-7-8-9-10 hand" do
      it "returns 'Ten-high straight'" do
        expect(ten_high_straight.to_s).to eq "Ten-high straight"
      end
    end
    
    describe "A-2-3-4-5 hand" do
      it "returns '5-high straight'" do
        expect(five_high_straight.to_s).to eq "Five-high straight"
      end
    end
  end
  
end