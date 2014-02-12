require 'socket'

module LocalSocketClient
  
  GAME_PORTS = {:poker => 3333}
  
  def self.port(game)
    GAME_PORTS[game]
  end
  
  def self.join(game)
    socket = TCPSocket.new('localhost', port(game))
    
    Thread.new(socket) do |socket|
      while output = socket.gets.chomp
        puts output
      end
    end
    
    loop do
      socket.puts gets.chomp
    end
  end
  
end

if __FILE__ == $0
  LocalSocketClient.join(:poker)
end