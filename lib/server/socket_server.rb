require 'socket'

class SocketServer < TCPServer
  
  def initialize(number_of_sockets, game)
    super(SocketClient.port(game))
    @number_of_sockets = number_of_sockets
    @socket_clients = Array.new
  end
  
  def accept_clients
    while @socket_clients.count < @number_of_sockets
      @socket_clients << accept
      yield(@socket_clients.count - 1)
    end
  end
  
  def print(client_index=nil, message)
    client_audience(client_index).each {|client| client.print message}
  end
  
  def puts(client_index=nil, message)
    client_audience(client_index).each {|client| client.puts message}
  end
    
  def gets(client_index)
    @socket_clients[client_index].gets
  end
  
  private
  
  def client_audience(client_index)
    client_index ? [@socket_clients[client_index]] : @socket_clients
  end
  
end