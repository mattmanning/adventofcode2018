POINT_REGEX = /position=<(.+)>\svelocity=<(.+)>/

class Point
  attr_reader :position, :velocity

  def initialize(position, velocity)
    @position = position
    @velocity = velocity
  end

  def x
    @position.first
  end

  def y
    @position.last
  end

  def dx
    @velocity.first
  end

  def dy
    @velocity.last
  end

  def at?(x, y)
    @position == [x,y]
  end

  def tick(n=1)
    @position = [x + (n*dx), y + (n*dy)]
  end
end

def aligned(points)
  points.inject(0) do |sum, point|
    adjacent = points.detect do |p|
      p.at?(point.x, point.y + 1) ||
      p.at?(point.x, point.y - 1)
    end
    if adjacent
      sum + 1
    else
      sum
    end
  end
end

def plot(points)
  xs = points.map { |p| p.x }
  ys = points.map { |p| p.y }

  ys.min.upto(ys.max) do |y|
    xs.min.upto(xs.max) do |x|
      if points.detect { |point| point.at?(x, y) }
        print '#'
      else
        print '.'
      end
    end
    print "\n"
  end
end

start = 10450

def starting_points(start=0)
  lines = File.read('input.txt').split("\n")
  lines.map do |line|
    m = POINT_REGEX.match(line)
    position = m[1].split(',').map(&:to_i)
    velocity = m[2].split(',').map(&:to_i)
    p = Point.new(position, velocity)
    p.tick(start)
    p
  end
end

points = starting_points(start)
max_aligned_at = [0,0]

(start+1).upto(10550) do |n|
  points.each { |p| p.tick }
  a = aligned(points)
  max_aligned_at = [a, n] if (a > max_aligned_at.first)
end

time = max_aligned_at.last

puts "Message:"
points = starting_points.each { |p| p.tick(time) }
plot(points)

puts "Seconds: #{time}"
