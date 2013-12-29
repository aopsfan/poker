require_relative "../../spec_helper.rb"

describe StraightFlush do
  
  let(:queen_high_straight_flush) do
    hand = StraightFlush.new
    hand.straight_cards = [Card.new(:eight, :spades), Card.new(:nine, :spades),
                           Card.new(:ten, :spades), Card.new(:jack, :spades),
                           Card.new(:queen, :spades)]
    return hand
  end
  
  let(:royal_flush) do
    hand = StraightFlush.new
    hand.straight_cards = [Card.new(:ten, :diamonds), Card.new(:jack, :diamonds),
                           Card.new(:queen, :diamonds), Card.new(:king, :diamonds),
                           Card.new(:ace, :diamonds)]
    return hand
  end
  
  let(:ten_high_straight_flush) do
    hand = StraightFlush.new
    hand.straight_cards = [Card.new(:six, :clubs), Card.new(:seven, :clubs),
                           Card.new(:eight, :clubs), Card.new(:nine, :clubs),
                           Card.new(:ten, :clubs)]
    return hand
  end
  
  let(:queen_high_straight_flush_2) do
    hand = StraightFlush.new
    hand.straight_cards = [Card.new(:eight, :hearts), Card.new(:nine, :hearts),
                           Card.new(:ten, :hearts), Card.new(:jack, :hearts),
                           Card.new(:queen, :hearts)]
    return hand
  end
  
  let(:five_high_straight_flush) do
    ace = Card.new(:ace, :spades)
    ace.low_card = true
    hand = StraightFlush.new
    hand.straight_cards = [ace, Card.new(:two, :spades),
                           Card.new(:three, :spades), Card.new(:four, :spades),
                           Card.new(:five, :spades)]
    return hand
  end
  
  describe "#generate" do
    let(:generated_hand) do
      StraightFlush.generate [Card.new(:two, :diamonds), Card.new(:four, :diamonds),
                              Card.new(:three, :diamonds), Card.new(:five, :diamonds),
                              Card.new(:six, :diamonds)]
    end
    
    let(:generated_hand_2) do
      StraightFlush.generate [Card.new(:two, :clubs), Card.new(:three, :clubs),
                              Card.new(:four, :clubs), Card.new(:five, :clubs),
                              Card.new(:ace, :clubs)]
    end
    
    let(:generated_hand_3) do
      StraightFlush.generate [Card.new(:ten, :hearts), Card.new(:ace, :hearts),
                              Card.new(:jack, :hearts), Card.new(:queen, :hearts),
                              Card.new(:king, :hearts)]
    end
    
    let(:bad_generated_hand) do
      StraightFlush.generate [Card.new(:two, :diamonds), Card.new(:three, :diamonds),
                              Card.new(:four, :diamonds), Card.new(:five, :diamonds),
                              Card.new(:six, :spades)]
    end
    
    let(:bad_generated_hand_2) do
      StraightFlush.generate [Card.new(:two, :clubs), Card.new(:three, :clubs),
                              Card.new(:queen, :clubs), Card.new(:king, :clubs),
                              Card.new(:ace, :clubs)]
    end
    
    context "when Six-high straight flush is generated" do
      describe "straight cards" do
        subject {generated_hand.straight_cards}
    
        it "should have 5 objects" do
          expect(subject.length).to eq 5
        end
        
        it "should be in sequential order" do
          expect(subject[0].rank).to eq :two
          expect(subject[1].rank).to eq :three
          expect(subject[2].rank).to eq :four
          expect(subject[3].rank).to eq :five
          expect(subject[4].rank).to eq :six
        end
        
        it "should be all diamonds" do
          subject.each do |card|
            expect(card.suit).to eq :diamonds
          end
        end
      end
      
      describe "kickers" do
        subject {generated_hand.kickers}
        
        it "should be empty" do
          expect(subject.empty?).to be_true
        end
      end
    end
    
    context "when Five-high straight flush is generated" do
      describe "straight cards" do
        subject {generated_hand_2.straight_cards}
    
        it "should have 5 objects" do
          expect(subject.length).to eq 5
        end
        
        it "should be in sequential order" do
          expect(subject[0].rank).to eq :ace
          expect(subject[1].rank).to eq :two
          expect(subject[2].rank).to eq :three
          expect(subject[3].rank).to eq :four
          expect(subject[4].rank).to eq :five
        end
        
        it "should be all clubs" do
          subject.each do |card|
            expect(card.suit).to eq :clubs
          end
        end
      end
      
      describe "kickers" do
        subject {generated_hand_2.kickers}
        
        it "should be empty" do
          expect(subject.empty?).to be_true
        end
      end
    end
    
    context "when Royal straight flush is generated" do
      describe "straight cards" do
        subject {generated_hand_3.straight_cards}
    
        it "should have 5 objects" do
          expect(subject.length).to eq 5
        end
        
        it "should be in sequential order" do
          expect(subject[0].rank).to eq :ten
          expect(subject[1].rank).to eq :jack
          expect(subject[2].rank).to eq :queen
          expect(subject[3].rank).to eq :king
          expect(subject[4].rank).to eq :ace
        end
        
        it "should be all hearts" do
          subject.each do |card|
            expect(card.suit).to eq :hearts
          end
        end
      end
      
      describe "kickers" do
        subject {generated_hand_3.kickers}
        
        it "should be empty" do
          expect(subject.empty?).to be_true
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
    describe "Queen-high straight flush" do
      it "should be less than Royal flush" do
        expect(queen_high_straight_flush < royal_flush).to be_true
      end
      
      it "should be greater than Ten-high straight flush" do
        expect(queen_high_straight_flush > ten_high_straight_flush).to be_true
      end
      
      it "should be greater than Five-high straight flush" do
        expect(queen_high_straight_flush > five_high_straight_flush).to be_true
      end
      
      it "should be equal to other Queen-high straight flush" do
        expect(queen_high_straight_flush == queen_high_straight_flush_2).to be_true
      end
    end
  end
  
  describe "#to_s" do
    describe "8-9-10-J-Q hand" do
      it "should output 'Queen-high straight flush'" do
        expect(queen_high_straight_flush.to_s).to eq "Queen-high straight flush"
      end
    end
    
    describe "10-J-Q-K-A hand" do
      it "should output 'Royal flush'" do
        expect(royal_flush.to_s).to eq "Royal flush"
      end
    end
    
    describe "6-7-8-9-10 hand" do
      it "should output 'Ten-high straight flush'" do
        expect(ten_high_straight_flush.to_s).to eq "Ten-high straight flush"
      end
    end
    
    describe "A-2-3-4-5 hand" do
      it "should output '5-high straight flush'" do
        expect(five_high_straight_flush.to_s).to eq "Five-high straight flush"
      end
    end
  end
  
end