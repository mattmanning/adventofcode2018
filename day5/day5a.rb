input = File.read('input.txt')

str = ''

input.split('').each do |char|
  if str.length == 0
    str += char
  elsif str[-1].swapcase == char
    str.chop!
  else
    str += char
  end
end

puts str.chomp.length
