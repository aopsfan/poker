class Broadcast
  
  def initialize(number_of_players, game)
    @server = SocketServer.new(number_of_players, game)
    @number_of_players = number_of_players
    @last_print_type = nil
  end
  
  def take_players
    @server.accept_clients do |index|
      yield(index)
    end
  end
  
  def log(player_index=nil, message)
    delimit(player_index) unless @last_print_type == :log
    @server.puts(player_index, "> #{message}")
    @last_print_type = :log
  end
  
  def print_block(player_index=nil, message)
    delimit(player_index)
    separator = "=========="
    @server.puts(player_index, "#{separator}\n#{message}\n#{separator}")
    @last_print_type = :print_block
  end
  
  def ask(player_index, prompt)
    delimit(player_index)
    @server.puts(player_index, prompt)
    @last_print_type = :ask
    
    @server.gets(player_index)
  end
  
  private
  
  def delimit(player_index=nil)
    @server.print(player_index, "\n") unless @last_print_type.nil?
  end
  
end