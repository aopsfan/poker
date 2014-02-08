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
  
  def default_cards_with_three_player_second_round
    ["2D", "3D", "4D", "5D",
     "2H", "4D", "AS", "AH",
     "3D", "8D", "10D", "2S",
     "5C", "8C", "10C", "JD",
     "AC", "QH", "JS", "KH",
     
     "2D",       "4D", "5D",
     "2H",       "AS", "AH",
     "3D",       "10D", "2S",
     "5C",       "10C", "JD",
     "AC",       "JS", "KH"]
  end
  
  def default_cards_with_player_three_win
    ["2D", "3D", "4D", "5D",
     "2H", "4D", "AS", "AH",
     "3D", "8D", "10D", "2S",
     "5C", "8C", "10C", "JD",
     "AC", "QH", "JS", "KH",
    
     "2D", "3D", "4D", 
     "2H", "4D", "AS", 
     "3D", "8D", "10D",
     "5C", "8C", "10C",
     "AC", "QH", "JS", 
    
     "2D",       "4D", 
     "2H",       "AS", 
     "3D",       "10D",
     "5C",       "10C",
     "AC",       "JS"]
  end
  
  before :each do
    @game = DerpGame.new(4, 100)
    @game.deck = Deck.new(default_cards)
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
      
      it_behaves_like "a game with 4 active players" do
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
      
      it_behaves_like "a game with 4 active players" do
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

    context "after eliminating player 4" do
      before :each do
        @game.bets = {
          0 => 14,
          1 => :call,
          2 => 99,
          3 => :call
        }
        @game.play_deal
      end
      
      it_behaves_like "an active game after a deal" do
        let(:game) {@game}
      end
      
      describe "active players" do
        subject {@game.active_players}
        
        it "are players" do
          subject.each do |player|
            expect(player).to be_a Player
          end
        end
        
        it "have 3 objects" do
          expect(subject.length).to eq 3
        end
        
        it "do not have player 4" do
          expect(subject.include? @game.players[3]).to be_false
        end
      end
      
      describe "player 1" do
        it "has 85 chips" do
          expect(@game.players[0].chips).to eq 85
        end
      end
      
      describe "player 2" do
        it "has 85 chips" do
          expect(@game.players[1].chips).to eq 85
        end
      end
      
      describe "player 3" do
        subject {@game.players[2]}
        
        it "has 230 chips" do
          expect(subject.chips).to eq 230
        end
        
        it "wins the deal" do
          expect(subject).to eq @winner
        end
      end
      
      describe "player 4" do
        it "has 0 chips" do
          expect(@game.players[3].chips).to eq 0
        end
      end
      
      it "had 230 chips in the pot" do
        expect(@pot).to eq 230
      end
    end

    context "after eliminating player 2 and playing another deal" do
      before :each do
        deck = Deck.new default_cards_with_three_player_second_round
        @game.deck = deck
        @game.bets = {
          0 => 14,
          1 => 99,
          2 => :call,
          3 => :fold
        }
        @game.play_deal
        @game.bets = {
          0 => 4,
          1 => 99,
          2 => :call, # player 2 is out, so this :call should equal 4, not 99
          3 => 9
        }
        @game.play_deal        
      end
      
      it_behaves_like "an active game after a deal" do
        let(:game) {@game}
      end
      
      describe "active players" do
        subject {@game.active_players}
        
        it "are players" do
          subject.each do |player|
            expect(player).to be_a Player
          end
        end
        
        it "have 3 objects" do
          expect(subject.length).to eq 3
        end
        
        it "do not have player 2" do
          expect(subject.include? @game.players[1]).to be_false
        end
      end
      
      describe "player 1" do
        it "has 80 chips" do
          expect(@game.players[0].chips).to eq 80
        end
      end
      
      describe "player 2" do
        it "has 0 chips" do
          expect(@game.players[1].chips).to eq 0
        end
      end
      
      describe "player 3" do
        subject {@game.players[2]}
        
        it "has 231 chips" do
          expect(subject.chips).to eq 231
        end
        
        it "wins the deal" do
          expect(subject).to eq @winner
        end
      end
      
      describe "player 4" do
        it "has 89 chips" do
          expect(@game.players[3].chips).to eq 89
        end
      end
      
      it "had 20 chips in the last pot" do
        expect(@pot).to eq 20
      end
    end
    
    context "after eliminating all but player 4" do
      before :each do
        deck = Deck.new default_cards_with_player_three_win
        @game.deck = deck
        @game.bets = {
          0 => 24,
          1 => 49,
          2 => :call,
          3 => 99
        }
        @game.play_deal
        @game.bets = {
          0 => 24,
          1 => 49,
          2 => :call
        }
        @game.play_deal
        @game.bets = {
          0 => 49,
          2 => :call,
        }
        @game.play_deal
      end
      
      it_behaves_like "a game that has ended" do
        let(:game) {@game}
      end
    
      describe "player 3" do
        it "has 400 chips" do
          expect(@game.players[2].chips).to eq 400
        end
      end
    end
  end
  
end