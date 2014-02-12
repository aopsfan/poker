require 'socket'

class LocalSocketServer < TCPServer
  
  attr_accessor :puts_prefix, :print_suffix
  
  def initialize(number_of_sockets, game)
    super(LocalSocketClient.port(game))
    @number_of_sockets = number_of_sockets
    @socket_clients = Array.new
  end
  
  def accept_clients
    while @socket_clients.count < @number_of_sockets
      @socket_clients << accept
      yield(@socket_clients.count - 1)
    end
  end
  
  def puts(client_index=nil, message)
    client_audience(client_index).each {|client| client.puts @puts_prefix + message}
  end
  
  def print(client_index=nil, message)
    client_audience(client_index).each {|client| client.print message + @print_suffix}
  end
  
  def gets(client_index)
    @socket_clients[client_index].gets
  end
  
  private
  
  def client_audience(client_index)
    client_index ? [@socket_clients[client_index]] : @socket_clients
  end
  
end