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
  
  def iterate_clients(client_scope=nil)
    client_audience(client_scope).each {|client| yield(client)}
  end
  
  def print(client_scope=nil, message)
    iterate_clients(client_scope) {|client| client.print message}
  end
  
  def puts(client_scope=nil, message)
    iterate_clients(client_scope) {|client| client.puts message}
  end
    
  def gets(client_scope)
    @socket_clients[client_scope].gets
  end
  
  private
  
  def client_audience(client_scope)
    if client_scope.nil?
      @socket_clients
    elsif client_scope.is_a?(Array)
      client_scope.map{|index| @socket_clients[index]}
    else # it's an integer
      [@socket_clients[client_scope]]
    end
  end
  
end