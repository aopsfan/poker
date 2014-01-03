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