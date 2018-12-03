class Claim
  REGEX = /\#(\d+)\s@\s(\d+)\,(\d+):\s(\d+)x(\d+)/

  attr_reader :id, :left, :top, :width, :height

  def initialize(str)
    m = REGEX.match(str)
    @id = m[1]
    @left = m[2].to_i
    @top = m[3].to_i
    @width = m[4].to_i
    @height = m[5].to_i
  end
end
