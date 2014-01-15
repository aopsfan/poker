require_relative "../spec_helper.rb"

class DerpGame < Game
  attr_accessor :bets
  
  def play_deal
    deal(5)
    ante
    get_bets do |player, min_bet|
      @bets[players.index(player)]
    end
    
    winner = best_remaining_player
    winner.collect(pot)
    execute(:derp, winner, pot)
    reset
  end
end

describe DerpGame do
  def default_cards
    ["2D", "3D", "4D", "5D",
     "2H", "4D", "AS", "AH",
     "3D", "8D", "10D", "2S",
     "5C", "8C", "10C", "JD",
     "AC", "QH", "JS", "KH",
     
     "2D", "3D", "4D", "5D",
     "2H", "4D", "AS", "AH",
     "3D", "8D", "10D", "2S",
     "5C", "8C", "10C", "JD",
     "AC", "QH", "JS", "KH"]
  end
  
  before :each do
    deck = Deck.new default_cards
    @game = DerpGame.new(4, 100)
    @game.deck = deck
    @game.ante = 1
    @game.register(:derp) do |winner, pot|
      @winner = winner
      @pot = pot
    end
  end
  
  describe "#play_deal" do
    context "after playing one deal" do
      before :each do
        @game.bets = {
          0 => 4,
          1 => 5,
          2 => :call,
          3 => :fold
        }
        @game.play_deal
      end
      
      it_behaves_like "an active game after a deal" do
        let(:game) {@game}
      end
      
      describe "player 1" do
        it "has 95 chips" do
          expect(@game.players[0].chips).to eq 95
        end
      end
      
      describe "player 2" do
        it "has 94 chips" do
          expect(@game.players[1].chips).to eq 94
        end
      end
      
      describe "player 3" do
        subject {@game.players[2]}
        
        it "has 112 chips" do
          expect(subject.chips).to eq 112
        end
        
        it "wins the deal" do
          expect(subject).to eq @winner
        end
      end
      
      describe "player 4" do
        it "has 99 chips" do
          expect(@game.players[3].chips).to eq 99
        end
      end
      
      it "had 18 chips in the pot" do
        expect(@pot).to eq 18
      end
    end
    
    context "after playing two deals" do
      before :each do
        @game.bets = {
          0 => 4,
          1 => 5,
          2 => :call,
          3 => :fold
        }
        @game.play_deal
        @game.bets = {
          0 => 1,
          1 => 2,
          2 => 3,
          3 => 4
        }
        @game.play_deal
      end
      
      it_behaves_like "an active game after a deal" do
        let(:game) {@game}
      end
      
      describe "player 1" do
        it "has 93 chips" do
          expect(@game.players[0].chips).to eq 93
        end
      end
      
      describe "player 2" do
        it "has 91 chips" do
          expect(@game.players[1].chips).to eq 91
        end
      end
      
      describe "player 3" do
        subject {@game.players[2]}
        
        it "has 122 chips" do
          expect(subject.chips).to eq 122
        end
        
        it "wins the last deal" do
          expect(subject).to eq @winner
        end
      end
      
      describe "player 4" do
        it "has 94 chips" do
          expect(@game.players[3].chips).to eq 94
        end
      end
      
      it "had 14 chips in the last pot" do
        expect(@pot).to eq 14
      end
    end
  end
  
end