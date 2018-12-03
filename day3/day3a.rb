require './claim.rb'


lines = File.read('input.txt').split("\n")
claims = lines.map{|line| Claim.new(line) }
max_left = 0
max_top = 0
fabric = Hash.new(0)

claims.each do |claim|
  claim.left.upto(claim.left + claim.width - 1) do |x|
    max_left = x if x > max_left
    claim.top.upto(claim.top + claim.height - 1) do |y|
      max_top = y if y > max_top
      fabric[[x,y]] += 1
    end
  end
end

overlap = 0

0.upto(max_left) do |x|
  0.upto(max_top) do |y|
    overlap += 1 if fabric[[x,y]] > 1
  end
end

puts overlap
