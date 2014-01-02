require_relative "../spec_helper.rb"

describe Deck do
  
  before :each do
    @standard_deck = Deck.new
    @custom_deck = Deck.new [
      "2D", "3D", "4D", "5D",
      "2H", "4D", "AS", "AH",
      "3D", "8D", "10D", "2S",
      "5C", "8C", "10C", "JD",
      "AC", "QH", "JS", "KH"
    ]
  end
  
  describe "#length" do
    context "when initialized with an array of 20 strings" do
      it "has length 20" do
        expect(@custom_deck.length).to eq 20
      end
    end
    
    context "when initialized with no parameters" do
      it "has length 52" do
        expect(@standard_deck.length).to eq 52
      end
    end
  end
  
  describe "#[]" do
    context "when initialized with an array of 20 strings" do
      it "is an array of cards" do
        index = 0
        20.times do
          expect(@custom_deck[index]).to be_a Card
          index += 1
        end
      end
    end
    
    context "when initialized with no parameters" do
      it "is an array of cards" do
        index = 0
        52.times do
          expect(@standard_deck[index]).to be_a Card
          index += 1
        end
      end
    end
  end
  
  describe "#deal" do
    context "with no parameters" do
      before :each do
        @dealt_cards = @custom_deck.deal
      end
      
      it "deals one card" do
        expect(@dealt_cards.length).to eq 1
      end
      
      it "deals from the top" do
        expect(@dealt_cards[0].rank).to eq :two
        expect(@dealt_cards[0].suit).to eq :diamonds
      end
      
      it "has one less card" do
        expect(@custom_deck.length).to eq 19
      end
    end
    
    context "with parameter 5" do
      before :each do
        @dealt_cards = @custom_deck.deal(5)
      end
      
      it "deals five cards" do
        expect(@dealt_cards.length).to eq 5
      end
      
      it "deals from the top" do
        expect(@dealt_cards[0].rank).to eq :two
        expect(@dealt_cards[0].suit).to eq :diamonds
        
        expect(@dealt_cards[1].rank).to eq :three
        expect(@dealt_cards[1].suit).to eq :diamonds
        
        expect(@dealt_cards[2].rank).to eq :four
        expect(@dealt_cards[2].suit).to eq :diamonds
        
        expect(@dealt_cards[3].rank).to eq :five
        expect(@dealt_cards[3].suit).to eq :diamonds
        
        expect(@dealt_cards[4].rank).to eq :two
        expect(@dealt_cards[4].suit).to eq :hearts
      end
      
      it "has five less cards" do
        expect(@custom_deck.length).to eq 15
      end
    end
  end
  
end