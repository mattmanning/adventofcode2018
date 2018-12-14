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




def max_submatrix(grid, size)
  strip_sum = Hash.new(0)

  1.upto(300) do |x|
    sum = (1..size).inject(0) do |s, y|
      s + grid[[x,y]]
    end
    strip_sum[[x,0]] = sum

    (2..300-size+1).each do |y|
      sum += grid[[x,y+size-1]] - grid[[x,y-1]]
      strip_sum[[x,y]] = sum
    end
  end

  max = [(size**2)*(-9), nil, nil]

  1.upto(300-size+1) do |y|
    sum = (1..size).inject(0) do |s, x|
      s + strip_sum[[x,y]]
    end

    if sum > max.first
      max = [sum, 0, y]
    end

    (2..300-size+1).each do |x|
      sum += strip_sum[[x+size-1,y]] - strip_sum[[x-1, y]]
      if sum > max.first
        max = [sum, x, y]
      end
    end
  end

  max
end

max_max = [(300**2)*(-9), nil]

1.upto(300) do |s|
  max = max_submatrix(grid, s)
  if max.first > max_max.first
    max_max = [max.first, [max[1], max[2], s]]
  end
end

puts max_max.inspect

# def square(grid, x, y)
#   (0..2).inject(0) do |s, i|
#     s + (0..2).inject(0) do |ss, j|
#       ss + grid[[x+i,y+j]]
#     end
#   end
# end

# max = [0, nil, nil]

# 1.upto(298) do |y|
#   1.upto(298) do |x|
#     val = square(grid, x, y)
#     max = [val, x, y] if val > max.first
#   end
# end

# puts max.inspect