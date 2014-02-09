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
    @did_replace_cards = false
    
    @deck = Deck.new default_deck
    @game = FiveCardDraw.new(4, 100)
    @game.deck = @deck
    @game.ante = 1
    
    @game.register(:replace_cards) do |player|
      @card_replacements[@game.players.index(player)]
    end
    
    @game.register(:did_replace_cards) do |player|
      @did_replace_cards = true
    end
  end
  
  describe "#start_deal" do
    context "when ante is 1" do
      before :each do
        @game.ante = 1
        @deal = @game.start_deal
      end
      
      it_behaves_like "a 5-card game during a deal" do
        let(:game) {@game}
      end
      
      it "takes one chip per player" do
        @game.players.each do |player|
          expect(player.chips).to eq 99 # 100 - 1
        end
      end
      
      it "has not replaced cards yet" do
        expect(@did_replace_cards).to be_false
      end

      it "has 4 chips in the pot" do
        expect(@deal[:pot]).to eq 4
      end

      it "does not have a deal winner yet" do
        expect(@deal[:winner]).to be_nil
      end
    end
    
    context "when ante is 2" do
      before :each do
        @game.ante = 2
        @deal = @game.start_deal
      end
      
      it_behaves_like "a 5-card game during a deal" do
        let(:game) {@game}
      end

      it "takes two chips per player" do
        @game.players.each do |player|
          expect(player.chips).to eq 98 # 100 - 2
        end
      end
      
      it "has not replaced cards yet" do
        expect(@did_replace_cards).to be_false
      end

      it "has 8 chips in the pot" do
        expect(@deal[:pot]).to eq 8
      end

      it "does not have a deal winner yet" do
        expect(@deal[:winner]).to be_nil
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

        it_behaves_like "a 5-card game during a deal" do
          let(:game) {@game}
        end
        
        it "has not replaced cards yet" do
          expect(@did_replace_cards).to be_false
        end

        it "has 11 chips in the pot" do
          expect(@deal[:pot]).to eq 11 # hahaha
        end
        
        describe "player 1" do
          it "has 98 chips" do
            expect(@game.players[0].chips).to eq 98 # 100 - 1 - 1
          end
        end
        
        describe "player 2" do
          it "has 96 chips" do
            expect(@game.players[1].chips).to eq 96 # 100 - 1 - 3
          end
        end

        describe "player 3" do
          it "has 96 chips" do
            expect(@game.players[2].chips).to eq 96 # 100 - 1 - 3
          end
        end
        
        describe "player 4" do
          it "has 99 chips" do
            expect(@game.players[3].chips).to eq 99 # 100 - 1
          end
        end

        it "does not have a deal winner yet" do
          expect(@deal[:winner]).to be_nil
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
        
        it_behaves_like "an active game after a deal" do
          let(:game) {@game}
        end
        
        it "has replaced cards" do
          expect(@did_replace_cards).to be_true
        end
        
        it "had 27 chips in the pot" do
          expect(@deal[:pot]).to eq 27
        end
        
        describe "player 1" do
          it "has 94 chips" do
            expect(@game.players[0].chips).to eq 94 # 100 - 1 - 1 - 4
          end
        end
        
        describe "player 2" do
          it "has 90 chips" do
            expect(@game.players[1].chips).to eq 90 # 100 - 1 - 3 - 6
          end
        end

        describe "player 3" do
          subject {@game.players[2]}
          
          it "has 117 chips" do
            expect(subject.chips).to eq 117 # 100 - 1 - 3 - 6 + 27
          end
          
          it "wins the deal" do
            expect(subject).to eq @deal[:winner]
          end
        end
        
        describe "player 4" do
          it "has 99 chips" do
            expect(@game.players[3].chips).to eq 99 # 100 - 1
          end
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

        it_behaves_like "a 5-card game during a deal" do
          let(:game) {@game}
        end
        
        it "has not replaced cards yet" do
          expect(@did_replace_cards).to be_false
        end

        it "has 11 chips in the pot" do
          expect(@deal[:pot]).to eq 11 # hahaha
        end

        describe "player 1" do
          it "has 98 chips" do
            expect(@game.players[0].chips).to eq 98 # 100 - 1 - 1
          end
        end
        
        describe "player 2" do
          it "has 96 chips" do
            expect(@game.players[1].chips).to eq 96 # 100 - 1 - 3
          end
        end

        describe "player 3" do
          it "has 96 chips" do
            expect(@game.players[2].chips).to eq 96 # 100 - 1 - 3
          end
        end
        
        describe "player 4" do
          it "has 99 chips" do
            expect(@game.players[3].chips).to eq 99 # 100 - 1
          end
        end
        
        it "does not have a deal winner yet" do
          expect(@deal[:winner]).to be_nil
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
        
        it_behaves_like "an active game after a deal" do
          let(:game) {@game}
        end
        
        it "has replaced cards" do
          expect(@did_replace_cards).to be_true
        end
        
        it "had 27 chips in the pot" do
          expect(@deal[:pot]).to eq 27
        end
        
        describe "player 1" do
          it "has 94 chips" do
            expect(@game.players[0].chips).to eq 94 # 100 - 1 - 1 - 4
          end
        end

        describe "player 2" do
          subject {@game.players[1]}
          
          it "has 117 chips" do
            expect(subject.chips).to eq 117 # 100 - 1 - 3 - 6 + 27
          end
          
          it "wins the deal" do
            expect(subject).to eq @deal[:winner]
          end
        end
        
        describe "player 3" do
          it "has 90 chips" do
            expect(@game.players[2].chips).to eq 90 # 100 - 1 - 3 - 6
          end
        end
        
        describe "player 4" do
          it "has 99 chips" do
            expect(@game.players[3].chips).to eq 99 # 100 - 1
          end
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
        
        it_behaves_like "an active game after a deal" do
          let(:game) {@game}
        end
        
        it "has not replaced cards yet" do
          expect(@did_replace_cards).to be_false
        end

        it "had 5 chips in the pot" do
          expect(@deal[:pot]).to eq 5
        end
        
        describe "player 1" do
          it "has 99 chips" do
            expect(@game.players[0].chips).to eq 99 # 100 - 1
          end
        end
        
        describe "player 2" do
          it "has 99 chips" do
            expect(@game.players[1].chips).to eq 99 # 100 - 1
          end
        end
        
        describe "player 3" do
          it "has 99 chips" do
            expect(@game.players[2].chips).to eq 99 # 100 - 1
          end
        end

        describe "player 4" do
          subject {@game.players[3]}
          
          it "has 103 chips" do
            expect(subject.chips).to eq 103 # 100 - 1 - 1 + 5
          end
          
          it "wins the deal" do
            expect(subject).to eq @deal[:winner]
          end
        end
      end
    end
  end
  
end