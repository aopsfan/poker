class Broadcast
  
  def initialize(number_of_players, game)
    @server = SocketServer.new(number_of_players, game)
    @number_of_players = number_of_players
    @last_print_types = Hash.new
  end
  
  def take_players
    @server.accept_clients do |index|
      yield(index)
    end
  end
  
  def log(player_scope=nil, message)
    delimit(player_scope, :log) do |client|
      client.puts("> #{message}")
    end
  end
  
  def print_block(player_scope=nil, message)
    delimit(player_scope, :print_block) do |client|
      separator = "=========="
      client.puts("#{separator}\n#{message}\n#{separator}")
    end
  end
  
  def ask(player_scope, prompt)
    delimit(player_scope, :ask) do |client|
      client.puts(prompt)    
    end
    
    @server.gets(player_scope)
  end
  
  private
  
  def delimit(player_scope, print_type)
    @server.iterate_clients(player_scope) do |client|
      nil_condition = @last_print_types[client].nil?
      log_condition = print_type == :log && @last_print_types[client] == :log
      
      client.print("\n") unless nil_condition || log_condition
      yield(client)
      @last_print_types[client] = print_type
    end
  end
  
end