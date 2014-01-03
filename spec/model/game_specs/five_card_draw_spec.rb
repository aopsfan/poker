require_relative "../../spec_helper.rb"

describe FiveCardDraw do
  
  def default_deck
    ["2D", "3D", "4D", "5D",
     "2H", "4D", "AS", "AH",
     "3D", "8D", "10D", "2S",
     "5C", "8C", "10C", "JD",
     "AC", "QH", "JS", "KH",
           "AD",
           "6D"]
  end
  
  before :each do
    @card_replacements = Hash.new
    
    @deck = Deck.new default_deck
    @game = FiveCardDraw.new(4, 100)
    @game.deck = @deck
    @game.ante = 1
    
    @game.register(:replace_cards) do |player|
      @card_replacements[@game.players.index(player)]
    end
  end
  
  describe "#start_deal" do
    context "when ante is 1" do
      before :each do
        @game.ante = 1
        @deal = @game.start_deal
      end
      
      it "takes one chip per player" do
        @game.players.each do |player|
          expect(player.chips).to eq 99 # 100 - 1
        end
      end
      
      it "has 4 chips in the pot" do
        expect(@deal[:pot]).to eq 4
      end
    end
    
    context "when ante is 2" do
      before :each do
        @game.ante = 2
        @deal = @game.start_deal
      end
      
      it "takes one chip per player" do
        @game.players.each do |player|
          expect(player.chips).to eq 98 # 100 - 2
        end
      end
      
      it "has 8 chips in the pot" do
        expect(@deal[:pot]).to eq 8
      end
    end
  end
  
  describe "#play_round_of_betting" do
    context "when no players ask for card replacements and player 4 folds" do
      before :each do
        @bets_1 = {
          0 => :call,
          1 => 3,
          2 => :call,
          3 => :fold
        }
        
        @bets_2 = {
          0 => 4,
          1 => 6,
          2 => :call
        }
        
        @card_replacements = {
          0 => [],
          1 => [],
          2 => []
        }
      end
      
      context "after round 1" do
        before :each do
          @game.start_deal
          @deal = @game.play_round_of_betting do |player, min_bet|
            @bets_1[@game.players.index(player)]
          end
        end

        it "has 11 chips in the pot" do
          expect(@deal[:pot]).to eq 11 # hahaha
        end

        it "takes another chip from player 1" do
          expect(@game.players[0].chips).to eq 98 # 100 - 1 - 1
        end

        it "takes another 3 chips from player 2" do
          expect(@game.players[1].chips).to eq 96 # 100 - 1 - 3
        end

        it "takes another 3 chips from player 3" do
          expect(@game.players[2].chips).to eq 96 # 100 - 1 - 3
        end

        it "takes no more chips from player 4" do
          expect(@game.players[3].chips).to eq 99 # 100 - 1
        end

        it "does not have a deal winner yet" do
          expect(@deal[:winner]).to be_nil
        end

        it "does not have a game winner" do
          expect(@game.winner).to be_nil
        end
      end
      
      context "after round 2" do
        before :each do
          @game.start_deal
          @game.play_round_of_betting do |player, min_bet|
            @bets_1[@game.players.index(player)]
          end
          @deal = @game.play_round_of_betting do |player, min_bet|
            @bets_2[@game.players.index(player)]
          end
        end
        
        it "has 27 chips in the pot" do
          expect(@deal[:pot]).to eq 27
        end

        it "takes another 4 chips from player 1" do
          expect(@game.players[0].chips).to eq 94 # 100 - 1 - 1 - 4
        end

        it "takes another 6 chips from player 2" do
          expect(@game.players[1].chips).to eq 90 # 100 - 1 - 3 - 6
        end
        
        it "takes no more chips from player 4" do
          expect(@game.players[3].chips).to eq 99 # 100 - 1
        end

        it "makes player 3 the deal winner" do
          expect(@deal[:winner] == nil).to be_false
          expect(@game.players.index(@deal[:winner])).to eq 2
        end
        
        it "gives a net of 21 chips to player 3" do
          expect(@game.players[2].chips).to eq 117 # 100 - 1 - 3 - 6 + 27
        end

        it "does not have a game winner" do
          expect(@game.winner).to be_nil
        end
      end
    end
  
    context "when player 2 asks for 2 cards and player 4 folds" do
      before :each do
        @bets_1 = {
          0 => :call,
          1 => 3,
          2 => :call,
          3 => :fold
        }
        
        @bets_2 = {
          0 => 4,
          1 => 6,
          2 => :call
        }
        
        @card_replacements = {
          0 => [],
          1 => [[:eight, :clubs], [:queen, :hearts]],
          2 => []
        }
      end
      
      context "after round 1" do
        before :each do
          @game.start_deal
          @deal = @game.play_round_of_betting do |player, min_bet|
            @bets_1[@game.players.index(player)]
          end
        end

        it "has 11 chips in the pot" do
          expect(@deal[:pot]).to eq 11 # hahaha
        end

        it "takes another chip from player 1" do
          expect(@game.players[0].chips).to eq 98 # 100 - 1 - 1
        end

        it "takes another 3 chips from player 2" do
          expect(@game.players[1].chips).to eq 96 # 100 - 1 - 3
        end

        it "takes another 3 chips from player 3" do
          expect(@game.players[2].chips).to eq 96 # 100 - 1 - 3
        end

        it "takes no more chips from player 4" do
          expect(@game.players[3].chips).to eq 99 # 100 - 1
        end

        it "does not have a deal winner yet" do
          expect(@deal[:winner]).to be_nil
        end

        it "does not have a game winner" do
          expect(@game.winner).to be_nil
        end
      end
      
      context "after round 2" do
        before :each do
          @game.start_deal
          @game.play_round_of_betting do |player, min_bet|
            @bets_1[@game.players.index(player)]
          end
          @deal = @game.play_round_of_betting do |player, min_bet|
            @bets_2[@game.players.index(player)]
          end
        end
        
        it "has 27 chips in the pot" do
          expect(@deal[:pot]).to eq 27
        end

        it "takes another 4 chips from player 1" do
          expect(@game.players[0].chips).to eq 94 # 100 - 1 - 1 - 4
        end

        it "takes another 6 chips from player 3" do
          expect(@game.players[2].chips).to eq 90 # 100 - 1 - 3 - 6
        end
        
        it "takes no more chips from player 4" do
          expect(@game.players[3].chips).to eq 99 # 100 - 1
        end

        it "makes player 2 the deal winner" do
          expect(@deal[:winner] == nil).to be_false
          expect(@game.players.index(@deal[:winner])).to eq 1
        end
        
        it "gives a net of 21 chips to player 2" do
          expect(@game.players[1].chips).to eq 117 # 100 - 1 - 3 - 6 + 27
        end

        it "does not have a game winner" do
          expect(@game.winner).to be_nil
        end
      end
    end

    context "when every player except player 4 folds" do
      before :each do
        @bets = {
          0 => :fold,
          1 => :fold,
          2 => :fold,
          3 => :call
        }
      end
      
      context "after round 1" do
        before :each do
          @game.start_deal
          @deal = @game.play_round_of_betting do |player, min_bet|
            @bets[@game.players.index(player)]
          end
        end
        
        it "has 5 chips in the pot" do
          expect(@deal[:pot]).to eq 5
        end

        it "takes no more chips from player 1" do
          expect(@game.players[0].chips).to eq 99 # 100 - 1
        end

        it "takes no more chips from player 32" do
          expect(@game.players[1].chips).to eq 99 # 100 - 1
        end
        
        it "takes no more chips from player 3" do
          expect(@game.players[2].chips).to eq 99 # 100 - 1
        end

        it "makes player 4 the deal winner" do
          expect(@deal[:winner] == nil).to be_false
          expect(@game.players.index(@deal[:winner])).to eq 3
        end
        
        it "gives a net of 3 chips to player 4" do
          expect(@game.players[3].chips).to eq 103 # 100 - 1 - 1 + 5
        end

        it "does not have a game winner" do
          expect(@game.winner).to be_nil
        end
      end
    end
  end
  
end