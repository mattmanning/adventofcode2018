SERIAL = 6392

def power(x, y)
  rack_id = x + 10
  p = rack_id * y
  p += SERIAL
  p = p * rack_id
  p = p.to_s.split('')[-3].to_i
  p - 5
end

grid = Hash.new(0)

1.upto(300) do |y|
  1.upto(300) do |x|
    grid[[x,y]] = power(x, y)
  end
end

def square(grid, x, y)
  (0..2).inject(0) do |s, i|
    s + (0..2).inject(0) do |ss, j|
      ss + grid[[x+i,y+j]]
    end
  end
end

max = [0, nil, nil]

1.upto(298) do |y|
  1.upto(298) do |x|
    val = square(grid, x, y)
    max = [val, x, y] if val > max.first
  end
end

puts max.inspect