=begin
METHOD 1
=end

@game.register(:ante) do # or blind, depending on the setup
  # show each player's chips+cards
end

@game.register(:enter_betting_round) do
  # announce the new round of betting
end

@game.register(:bet) do |player, min_bet|
  # return the user's input for betting
end

@game.register(:replace_cards) do |player|
  # return the user's input for replacing cards
end

while !@game.winner
  # state that the deal is about to begin
  deal_winner = @game.play_deal
  # announce the winner of the deal
end

# announce the winner of the game


=begin
METHOD 2
=end

@game.register(:replace_cards) do |player|
  # return the user's input for replacing cards
end

while !@game.winner
  deal_winner = nil
  # state that the deal is about to begin
  @game.start_deal # ante happens here--use a block if you want a blind
  # show each player's chips+cards
  
  while !deal_winner
    # announce the new round of betting
    deal_winner = @game.play_round_of_betting do |player, min_bet|
      # return the user's input for betting
    end
  end
  
  # announce the winner of the deal
end

# announce the winner of the game


=begin
METHOD 2.1
=end

@game.register(:replace_cards) do |player|
  # return the user's input for replacing cards
end

while !@game.winner
  # state that the deal is about to begin
  current_deal = @game.start_deal # ante happens here--use a block if you want a blind
  # show each player's chips+cards, and the pot
  
  while !current_deal[:winner]
    # announce the new round of betting
    current_deal = @game.play_round_of_betting do |player, min_bet|
      # return the user's input for betting
    end
  end
  
  # announce the winner of the deal, and the size of the pot he/she received
end

# announce the winner of the game