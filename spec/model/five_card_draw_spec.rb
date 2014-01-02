require_relative "../spec_helper.rb"

describe FiveCardDraw do
  
  def default_deck
    ["2D", "3D", "4D", "5D",
     "2H", "4D", "AS", "AH",
     "3D", "8D", "10D", "2S",
     "5C", "8C", "10C", "JD",
     "AC", "QH", "JS", "KH"]
  end
  
  before :each do
    @bets_1 = Hash.new
    @bets_2 = Hash.new
    @antes = 0
    @card_requests = Hash.new
    @round_winner = nil
    @round_of_betting = 1
    @entered_first_round = false
    @entered_second_round = false
    
    @expected_card_requests = Hash.new
    @expected_bets_1 = Hash.new
    @expected_bets_2 = Hash.new
    
    @deck = Deck.new default_deck
    @game = FiveCardDraw.new(4, 100)
    @game.deck = @deck
    @game.ante = 1
    
    @game.action(:ante) do
      @antes += 1
    end
    
    @game.action(:enter_first_round_of_betting) do
      @entered_first_round = true
    end
    
    @game.action(:enter_second_round_of_betting) do
      @entered_second_round = true
    end
    
    @game.action(:bet) do |min_bet|
      if @entered_second_round
        @bets_2[@game.active_player_number] = @expected_bets_2[@game.active_player_number]
      else
        @bets_1[@game.active_player_number] = @expected_bets_1[@game.active_player_number]
      end
    end
    
    @game.action(:request_cards) do
      @round_of_betting = 2
      @card_requests[@game.active_player_number] = @expected_card_requests[@game.active_player_number]
      []
    end
    
    @game.action(:collect_pot) do |winner|
      @round_winner = winner
    end
  end
  
  describe "#play_round" do
    
    before :each do
      @expected_bets_1 = {
        1 => 4,
        2 => 4,
        3 => 6,
        4 => :fold
      }
      @expected_bets_2 = {
        1 => 6,
        2 => 7,
        3 => 7
      }
      @expected_card_requests = {
        1 => 0,
        2 => 0,
        3 => 0
      }
    end
    
    context "when standard round is played" do
      before :each do
        @game.play_round
      end
      
      it "makes all players ante up" do
        expect(@antes).to eq 4
      end
      
      it "enters the first round of betting" do
        expect(@entered_first_round).to be_true
      end
      
      it "makes first-round bets" do
        expect(@bets_1).to eq @expected_bets_1
      end
  
      it "enters the second round of betting" do
        expect(@entered_second_round).to be_true
      end
      
      it "makes second-round bets" do
        expect(@bets_2).to eq @expected_bets_2
      end
    
      it "requests the right cards" do
        expect(@card_requests).to eq @expected_card_requests
      end
      
      it "gives the whole pot to player 3" do
        expect(@game.players[2].chips).to eq 124
        expect(@round_winner).to eq 3
      end
      
      it "does not change the total number of chips" do
        total_chips = 0
        @game.players.each do |player|
          total_chips += player.chips
        end
        
        expect(total_chips).to eq 400
      end
    end
  end
  
end