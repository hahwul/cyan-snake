

cmd = "0"
puts " -- boot mode" 
puts " select number for boot" 
puts " [1] terminal mode" 
puts " [2] graphic mode" 
print "#> "
cmd = gets.chomp
if cmd == "1"
  system("ln -sf /lib/systemd/system/multi-user.target /etc/systemd/system/default.target")
  puts " - success terminal mode"
end
if cmd == "2"
  system("ln -sf /lib/systemd/system/graphical.target  /etc/systemd/system/default.target")
  puts " - success graphic mode"
end


cmd = "0"
puts " -- autorun mode" 
puts " select number for autorun(.bashrc)" 
puts " [1] yes" 
puts " [2] no" 
print "#> "
cmd = gets.chomp
if cmd == "1"
  system("echo 'ruby "+File.dirname(__FILE__)+"/cyan-snake.rb' >> ~/.bashrc")
  puts "success autorun" 
end

if cmd == "2"
 puts "no autorun" 
end


