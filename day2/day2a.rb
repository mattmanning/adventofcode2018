ids = File.read('input.txt').split("\n")

twos = 0
threes = 0 

ids.each do |id|
  hsh = id.split('').group_by{|e| e}.map{|k, v| [k, v.length]}.to_h
  twos += 1 if hsh.values.include?(2)
  threes += 1 if hsh.values.include?(3)
end

puts twos * threes