require 'socket'

address = ARGV[0]

if address.nil?
    puts "No address specified"
    exit(1) 
end

original_file_name = ARGV[1]

if original_file_name.nil?
    puts "No file specified"
    exit(2)
end

loop_times = ARGV[2].to_i || 100

file_name = original_file_name

loop_times.times { |i|
    message = File.read(file_name)
    socket = UDPSocket.new
    socket.connect(address, 9999)
    socket.puts message
    echoed_message, _ = socket.recvfrom(message.length)
    File.open("#{original_file_name}_#{i}", 'w') { |file|
        file.write echoed_message
    }
    if file_name != original_file_name
        system("rm #{file_name}")
    end
    file_name = "#{original_file_name}_#{i}"
}
system("mv #{file_name} #{original_file_name}_experimented")