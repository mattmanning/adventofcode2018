ids = File.read('input.txt').split("\n")

length = ids.first.length

0.upto(length) do |i|
  pair = ids.group_by do |id|
    if i == 0
      id[1..-1]
    else
      id[0..i-1] + id[i+1..-1]
    end
  end.detect{|g| g[1].count == 2}
  if !pair.nil?
    puts pair.first
    break
  end
end
