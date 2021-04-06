require 'socket'

class TcpServer

  def initialize(address, port)
    puts("Starting Server at #{address}:#{port}...")
    @server = TCPServer.new(address, port)
  end

  def waitForConnection
    @thread = Thread.new do
      loop do
        client = @server.accept
        client.puts "Hello !"
        client.puts "Time is #{Time.now}"
        puts("Message to client sent!")
        client.close
      end
    end
  end
end