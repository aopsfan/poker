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
end

shared_examples "a 5-card game during a deal" do
  describe "players' cards" do
    it "have 5 objects" do
      game.players.each do |player|
        expect(player.cards.length).to eq 5
      end
    end
  end
  
  it "has no winner" do
    expect(game.winner).to be_nil
  end
end