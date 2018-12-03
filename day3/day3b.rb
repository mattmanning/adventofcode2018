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

claims.each do |claim|
  overlap = false
  claim.left.upto(claim.left + claim.width - 1) do |x|
    claim.top.upto(claim.top + claim.height - 1) do |y|
      overlap = true if fabric[[x,y]] != 1
    end
  end
  if !overlap
    puts claim.id
    break
  end
end
