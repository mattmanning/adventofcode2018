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

def tie?(hsh)
  values = hsh.values
  if values.count(values.min) > 1
    true
  else  
    false
  end
end

infinites = []

(xs.min - 1).upto(xs.max + 1) do |x|
  (ys.min - 1).upto(ys.max + 1) do |y|
    distances = {}
    coords.each do |c|
      distances[c] = distance(c, [x,y])
    end
    unless tie?(distances)
      closest = distances.min_by {|k,v| v}[0]
      scores[closest] = scores[closest] += 1
    end
    
    infinites << closest if (x <= xs.min) || (x >= xs.max) || (y <= ys.min ) || (y >= ys.max)
  end
end

infinites = infinites.uniq.compact
scores.reject! {|score| infinites.include?(score)}.inspect

puts scores.values.max