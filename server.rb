require 'socket'

Socket.udp_server_loop(9999) { |msg, msg_src|
  puts "Received message from #{msg_src.remote_address.ip_address} length=#{msg.length}"
  msg_src.reply msg
}
