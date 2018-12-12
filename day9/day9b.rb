# Use a circular linked list to make inserts and deletes O(1)

COUNT_PLAYERS = 413
HIGHEST_MARBLE = 7108200

class Marble
  attr_accessor :prev, :nxt, :num

  def initialize(num, prev=self, nxt=self)
    @num, @prev, @nxt = num, prev, nxt
  end
end

players = Array.new(COUNT_PLAYERS, 0)
player = 0

marble_score = 1
current = Marble.new(marble_score)
current.nxt = current
current.prev = current

while marble_score <= HIGHEST_MARBLE
  if marble_score % 23 == 0
    players[player] += marble_score
    remove = current.prev.prev.prev.prev.prev.prev.prev
    players[player] += remove.num
    remove.nxt.prev = remove.prev
    remove.prev.nxt = remove.nxt
    current = remove.nxt
  else
    left = current.nxt
    right = current.nxt.nxt
    current = Marble.new(marble_score, left, right)
    left.nxt = current
    right.prev = current
  end
  marble_score += 1
  player += 1
  player = 0 if player == COUNT_PLAYERS
end

puts players.max
