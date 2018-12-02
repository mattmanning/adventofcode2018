lines = File.read('input.txt').split("\n")

freqs = [0]
freq = 0
line = 0

while true
  delta = lines[line]
  if delta[0] == '+'
    freq += delta[1..-1].to_i
  else
    freq -= delta[1..-1].to_i
  end
  break if freqs.include?(freq)
  freqs << freq
  line += 1
  line = 0 if line >= lines.length
end

puts freq