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
      
      it "removes all cards from each player" do
        @game.players.each do |player|
          expect(player.cards.empty?).to be_true
        end
      end
      
      it "takes 5 chips from player 1" do
        expect(@game.players[0].chips).to eq 95
      end
      
      it "takes 6 chips from player 2" do
        expect(@game.players[1].chips).to eq 94
      end
      
      it "takes 1 chip from player 4" do
        expect(@game.players[3].chips).to eq 99
      end
      
      it "makes player 3 the winner of the deal" do
        expect(@game.players.index @winner).to eq 2
      end
      
      it "had 18 chips in the pot" do
        expect(@pot).to eq 18
      end
      
      it "gives the pot to player 3" do
        expect(@game.players[2].chips).to eq 112
      end
      
      it "has no winner" do
        expect(@game.winner).to be_nil
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
      
      it "removes all cards from each player" do
        @game.players.each do |player|
          expect(player.cards.empty?).to be_true
        end
      end
      
      it "takes 7 chips from player 1" do
        expect(@game.players[0].chips).to eq 93
      end
      
      it "takes 9 chips from player 2" do
        expect(@game.players[1].chips).to eq 91
      end
      
      it "takes 6 chips from player 4" do
        expect(@game.players[3].chips).to eq 94
      end
      
      it "makes player 3 the winner of the deals" do
        expect(@game.players.index @winner).to eq 2
      end
      
      it "had 14 chips in the pot" do
        expect(@pot).to eq 14
      end
      
      it "gives the pot to player 3" do
        expect(@game.players[2].chips).to eq 122
      end
      
      it "has no winner" do
        expect(@game.winner).to be_nil
      end
    end
  end
  
end