shared_examples "an active game after a deal" do
  describe "players' cards" do
    it "are empty" do
      game.players.each do |player|
        expect(player.cards.empty?).to be_true
      end
    end
  end
  
  it "has no winner" do
    expect(game.winner).to be_nil
  end
  
  it "has more than one active player" do
    expect(game.active_players.length > 1).to be_true
  end
end

shared_examples "a 5-card game during a deal" do
  describe "active players' cards" do
    it "have 5 objects" do
      game.active_players.each do |player|
        expect(player.cards.length).to eq 5
      end
    end
  end
  
  it "has no winner" do
    expect(game.winner).to be_nil
  end
  
  it "has more than one active player" do
    expect(game.active_players.length > 1).to be_true
  end
end

shared_examples "a game with 4 active players" do
  describe "active players" do
    subject {game.active_players}
    
    it "has players" do
      subject.each do |player|
        expect(player).to be_a Player
      end
    end
    
    it "has 4 objects" do
      expect(subject.length).to eq 4
    end
  end
end

shared_examples "a game that has ended" do
  describe "active players' cards" do
    it "are empty" do
      game.active_players.each do |player|
        expect(player.cards.empty?).to be_true
      end
    end
  end
  
  it "has one active player" do
    expect(game.active_players.length).to eq 1
  end
  
  describe "last remaining player" do  
    subject {game.active_players.first}
      
    it "is not nil" do
      expect(subject.nil?).to be_false
    end
    
    it "is the winner" do
      expect(subject).to eq game.winner
    end
  end
end