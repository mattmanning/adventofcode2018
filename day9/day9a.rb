COUNT_PLAYERS = 413
HIGHEST_MARBLE = 7108200

class Circle < Array
  def insert(i, obj)
    idx = i % length
    if idx == 0
      push(obj)
    else
      super(idx, obj)
    end
  end

  def delete_at(i)
    super(i % length)
  end
end

circle = Circle.new
circle.push(0)
marble = 1
current = 0

players = Array.new(COUNT_PLAYERS, 0)
player = 0


while true
  #puts "#{circle.inspect}     #{current}"
  #puts marble
  break if marble > HIGHEST_MARBLE
  if (marble % 23) == 0
    players[player] += marble
    current = ((current - 7) % circle.length)
    players[player] += circle.delete_at(current)
  else
    circle.insert(current + 2, marble)
    current = circle.find_index(marble)
  end
  marble += 1
  player += 1
  player = 0 if player == COUNT_PLAYERS
end

puts players.max
