class Node
  def to_s
    "[#{data[0]},#{data[1]}]"
  end
  attr_accessor :data, :neigh

  def initialize(x = nil, y = nil)
    @data = [x, y]
    @neigh = []
  end
end

class Board
  def initialize
  end
end
