lines = File.read('input.txt').split("\n")

coords = lines.map do |line|
  xy = line.split(', ')
  [xy.first.to_i, xy.last.to_i]
end

xs = coords.map{ |c| c.first }
ys = coords.map{ |c| c.last }

scores = Hash.new(0)

def distance(pointa, pointb)
  (pointa.first - pointb.first).abs +
  (pointa.last - pointb.last).abs
end 

area = 0

(xs.min).upto(xs.max) do |x|
  (ys.min).upto(ys.max) do |y|
    d = coords.inject(0) do |sum, c|
      sum + distance(c, [x,y])
    end
    area += 1 if d < 10_000    
  end
end

puts area
