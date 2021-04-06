class TestClient
  attr_accessor :socket

  def initialize(address, port)
    @socket = TCPSocket.new(address, port)
  end
end