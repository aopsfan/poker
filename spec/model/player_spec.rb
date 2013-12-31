require_relative "../spec_helper.rb"

describe Player do
  
  before :each do
    @player = Player.new(100)
  end
  
  describe "#bet" do
    context "when betting 5" do
      before :each do
        @player.bet(5)
      end
      
      it "has 95 chips" do
        expect(@player.chips).to eq 95
      end
    end
    
    context "when betting 10" do
      before :each do
        @player.bet(10)
      end
      
      it "has 90 chips" do
        expect(@player.chips).to eq 90
      end
    end
  end
  
  describe "#collect" do
    context "when collecting 30" do
      before :each do
        @player.collect(30)
      end
      
      it "has 130 chips" do
        expect(@player.chips).to eq 130
      end
    end
    
    context "when collecting 101" do
      before :each do
        @player.collect(101)
      end
      
      it "has 201 chips" do
        expect(@player.chips).to eq 201
      end
    end
  end
  
  describe "#take_cards" do
    context "when taking 3 cards" do
      before :each do
        @player.take_cards [Card.new(:ten, :spades), Card.new(:five, :spades), Card.new(:ace, :spades)]
      end
      
      it "has 3 cards" do
        expect(@player.cards.length).to eq 3
      end
      
      it "has ten of spades" do
        expect(@player.cards[0].rank).to eq :ten
        expect(@player.cards[0].suit).to eq :spades
      end
      
      it "has five of spades" do
        expect(@player.cards[1].rank).to eq :five
        expect(@player.cards[1].suit).to eq :spades
      end
      
      it "has ace of spades" do
        expect(@player.cards[2].rank).to eq :ace
        expect(@player.cards[2].suit).to eq :spades
      end
      
      context "when taking another card" do
        before :each do
          @player.take_cards [Card.new(:king, :spades)]
        end
          
        it "has 4 cards" do
          expect(@player.cards.length).to eq 4
        end
        
        it "has king of spades" do
          expect(@player.cards[3].rank).to eq :king
          expect(@player.cards[3].suit).to eq :spades
        end
      end
    end
  end
  
  describe "#drop_card" do
    before :each do
      @player.take_cards [Card.new(:ten, :spades), Card.new(:ten, :clubs), Card.new(:ace, :spades)]
    end
    
    context "when dropping ten of spades" do
      before :each do
        @card = @player.drop_card(:ten, :spades)
      end
      
      it "has 2 cards" do
        expect(@player.cards.length).to eq 2
      end
      
      it "returns ten of spades" do
        expect(@card.rank).to eq :ten
        expect(@card.suit).to eq :spades
      end
      
      it "has no ten of spades" do
        @player.cards.each do |card|
          expect(card.rank == :ten && card.suit == :spades).to be_false
        end
      end
    end
    
    context "when dropping five of spades" do
      before :each do
        @card = @player.drop_card(:five, :spades)
      end
      
      it "has 3 cards" do
        expect(@player.cards.length).to eq 3
      end
      
      it "returns nil" do
        expect(@card).to be_nil
      end
    end
  end
  
  describe "#drop_all" do
    before :each do
      @cards = @player.take_cards [Card.new(:ten, :spades), Card.new(:ten, :clubs), Card.new(:ace, :spades)]
    end
    
    context "when dropping all cards" do
      before :each do
        @player.drop_all
      end
      
      it "has no cards" do
        expect(@player.cards.empty?).to be_true
      end
      
      it "returns 3 cards" do
        expect(@cards.length).to eq 3
      end
    end
  end
  
  describe "#best_hand" do
    context "when given royal flush" do
      before :each do
        @player.take_cards [Card.new(:ten, :clubs), Card.new(:queen, :clubs),
                            Card.new(:king, :clubs), Card.new(:ace, :clubs),
                            Card.new(:jack, :clubs)]
      end
      
      it "returns StraightFlush" do
        expect(@player.best_hand).to be_a StraightFlush
      end
    end
    
    context "when given four 8s" do
      before :each do
        @player.take_cards [Card.new(:eight, :clubs), Card.new(:eight, :spades),
                            Card.new(:eight, :hearts), Card.new(:eight, :diamonds),
                            Card.new(:jack, :clubs)]
      end
      
      it "returns FourOfAKind" do
        expect(@player.best_hand).to be_a FourOfAKind
      end
    end
    
    context "when given three kings and two jacks" do
      before :each do
        @player.take_cards [Card.new(:jack, :clubs), Card.new(:jack, :hearts),
                            Card.new(:king, :clubs), Card.new(:king, :hearts),
                            Card.new(:king, :diamonds)]
      end
      
      it "returns FullHouse" do
        expect(@player.best_hand).to be_a FullHouse
      end
    end
    
    context "when given five clubs" do
      before :each do
        @player.take_cards [Card.new(:ten, :clubs), Card.new(:queen, :clubs),
                            Card.new(:king, :clubs), Card.new(:ace, :clubs),
                            Card.new(:two, :clubs)]
      end
      
      it "returns Flush" do
        expect(@player.best_hand).to be_a Flush
      end
    end
    
    context "when given 9-10-J-Q-K" do
      before :each do
        @player.take_cards [Card.new(:nine, :hearts), Card.new(:ten, :clubs),
                            Card.new(:jack, :clubs), Card.new(:queen, :clubs),
                            Card.new(:king, :clubs)]
      end
      
      it "returns Straight" do
        expect(@player.best_hand).to be_a Straight
      end
    end

    context "when given three kings" do
      before :each do
        @player.take_cards [Card.new(:jack, :clubs), Card.new(:ten, :hearts),
                            Card.new(:king, :clubs), Card.new(:king, :hearts),
                            Card.new(:king, :diamonds)]
      end
      
      it "returns ThreeOfAKind" do
        expect(@player.best_hand).to be_a ThreeOfAKind
      end
    end

    context "when given two kings and two jacks" do
      before :each do
        @player.take_cards [Card.new(:jack, :clubs), Card.new(:jack, :hearts),
                            Card.new(:king, :clubs), Card.new(:king, :hearts),
                            Card.new(:two, :diamonds)]
      end
      
      it "returns TwoPair" do
        expect(@player.best_hand).to be_a TwoPair
      end
    end

    context "when given two jacks" do
      before :each do
        @player.take_cards [Card.new(:jack, :clubs), Card.new(:jack, :hearts),
                            Card.new(:king, :clubs), Card.new(:queen, :hearts),
                            Card.new(:ace, :diamonds)]
      end
      
      it "returns OnePair" do
        expect(@player.best_hand).to be_a OnePair
      end
    end

    context "when given a horrible hand" do
      before :each do
        @player.take_cards [Card.new(:two, :clubs), Card.new(:four, :hearts),
                            Card.new(:six, :clubs), Card.new(:eight, :hearts),
                            Card.new(:ten, :diamonds)]
      end
      
      it "returns HighCard" do
        expect(@player.best_hand).to be_a HighCard
      end
    end
  end
  
end