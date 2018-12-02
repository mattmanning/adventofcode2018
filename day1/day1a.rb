lines = File.read('input.txt').split("\n")

ans = lines.inject(0) do |freq, delta|
  if delta[0] == '+'
    freq + delta[1..-1].to_i
  else
    freq - delta[1..-1].to_i
  end
end

puts ans