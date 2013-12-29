require_relative "../../spec_helper.rb"

describe Flush do
  
  let(:queen_high_flush) do
    hand = Flush.new
    hand.flush_cards = [Card.new(:four, :diamonds), Card.new(:six, :diamonds),
                        Card.new(:eight, :diamonds), Card.new(:ten, :diamonds),
                        Card.new(:queen, :diamonds)]
    return hand
  end
  
  let(:ace_high_flush) do
    hand = Flush.new
    hand.flush_cards = [Card.new(:ace, :spades), Card.new(:six, :spades),
                        Card.new(:eight, :spades), Card.new(:ten, :spades),
                        Card.new(:four, :spades)]
    return hand
  end
  
  let(:ten_high_flush) do
    hand = Flush.new
    hand.flush_cards = [Card.new(:five, :hearts), Card.new(:six, :hearts),
                        Card.new(:eight, :hearts), Card.new(:nine, :hearts),
                        Card.new(:ten, :hearts)]
    return hand
  end
  
  let(:queen_high_flush_2) do
    hand = Flush.new
    hand.flush_cards = [Card.new(:five, :clubs), Card.new(:six, :clubs),
                        Card.new(:eight, :clubs), Card.new(:ten, :clubs),
                        Card.new(:queen, :clubs)]
    return hand
  end
  
  let(:queen_high_flush_3) do
    hand = Flush.new
    hand.flush_cards = [Card.new(:four, :clubs), Card.new(:six, :clubs),
                        Card.new(:eight, :clubs), Card.new(:ten, :clubs),
                        Card.new(:queen, :clubs)]
    return hand
  end
  
  describe "#generate" do
    let(:generated_hand) do
      Flush.generate [Card.new(:four, :clubs), Card.new(:three, :clubs),
                      Card.new(:two, :clubs), Card.new(:five, :clubs),
                      Card.new(:ace, :clubs)]
    end
    
    let(:bad_generated_hand) do
      Flush.generate [Card.new(:two, :spades), Card.new(:three, :clubs),
                      Card.new(:four, :clubs), Card.new(:five, :clubs),
                      Card.new(:ace, :clubs)]
    end    
    
    context "when hand is generated" do
      describe "flush cards" do
        subject {generated_hand.flush_cards}
        
        it "should have 5 objects" do
          expect(subject.length).to eq 5
        end
    
        it "should be all clubs" do
          subject.each do |card|
            expect(card.suit).to eq :clubs
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
    
    context "when bad hand is generated" do
      it "should be nil" do
        expect(bad_generated_hand).to be_nil
      end
    end
  end
  
  describe "#<=>" do
    describe "Queen-high flush" do
      it "should be less than Ace-high flush" do
        expect(queen_high_flush < ace_high_flush).to be_true
      end
      
      it "should be greater than Ten-high flush" do
        expect(queen_high_flush > ten_high_flush).to be_true
      end
      
      it "should be less than Queen-high flush ending in five" do
        expect(queen_high_flush < queen_high_flush_2).to be_true
      end
      
      it "should be equal to other Queen-high flush" do
        expect(queen_high_flush == queen_high_flush_3).to be_true
      end
    end
  end
  
  describe "#to_s" do
    describe "all-diamonds hand with high card QD" do
      it "should output 'Queen-high flush'" do
        expect(queen_high_flush.to_s).to eq "Queen-high flush"
      end
    end
    
    describe "all-spades hand with high card AS" do
      it "should output 'Ace-high flush'" do
        expect(ace_high_flush.to_s).to eq "Ace-high flush"
      end
    end
    
    describe "all-hearts hand with high card 10H" do
      it "should output 'Ten-high flush'" do
        expect(ten_high_flush.to_s).to eq "Ten-high flush"
      end
    end
  end
  
end