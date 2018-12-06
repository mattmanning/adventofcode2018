input = File.read('input.txt')

def react(s)
  str = ''
  s.split('').each do |char|
    if str.length == 0
      str += char
    elsif str[-1].swapcase == char
      str.chop!
    else
      str += char
    end
  end
  str
end

puts ('a'..'z').inject([]) {|arr, char| arr + [react(input.delete(char).delete(char.swapcase)).chomp.length]}.min