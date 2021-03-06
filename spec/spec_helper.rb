# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

# Basic models
require_relative "../lib/model/card.rb"
require_relative "../lib/model/player.rb"
require_relative "../lib/model/game.rb"
require_relative "../lib/model/games/five_card_draw.rb"
require_relative "../lib/model/deck.rb"

# Hand models.  In their corresponding tests, we test behavior
# of the model against cases with a standard 52-card deck and a 5-card hand.
require_relative "../lib/model/hand.rb"
require_relative "../lib/model/hands/high_card.rb"
require_relative "../lib/model/hands/one_pair.rb"
require_relative "../lib/model/hands/two_pair.rb"
require_relative "../lib/model/hands/three_of_a_kind.rb"
require_relative "../lib/model/hands/full_house.rb"
require_relative "../lib/model/hands/straight.rb"
require_relative "../lib/model/hands/flush.rb"
require_relative "../lib/model/hands/four_of_a_kind.rb"
require_relative "../lib/model/hands/straight_flush.rb"

# Helpers
require_relative "helper/shared_examples.rb"