class Node
  def to_s
    "[#{data[0]},#{data[1]}]"
  end
  attr_accessor :data, :neigh

  def initialize(x = nil, y = nil)
    @data = [x, y]
    @neigh = []
  end

  def on_board?(x, y) # checks if inputted cordinates are on board
    if [x, y].all? { |num| num <= 7 && num >= 0 }
      true
    else
      false
    end
  end

  def make_neighbours
    x, y = data
    n0 = Node.new(x + 1, y + 2) if on_board?(x + 1, y + 2)
    n1 = Node.new(x + 1, y - 2) if on_board?(x + 1, y - 2)
    n2 = Node.new(x - 1, y + 2) if on_board?(x - 1, y + 2)
    n3 = Node.new(x - 1, y - 2) if on_board?(x - 1, y - 2)

    n4 = Node.new(x + 2, y + 1) if on_board?(x + 2, y + 1)
    n5 = Node.new(x + 2, y - 1) if on_board?(x + 2, y - 1)
    n6 = Node.new(x - 2, y + 1) if on_board?(x - 2, y + 1)
    n7 = Node.new(x - 2, y - 1) if on_board?(x - 2, y - 1)

    [n0, n1, n2, n3, n4, n5, n6, n7].each { |n| neigh.push(n) if n }
    neigh
  end
end

class Board
  attr_accessor :center

  def initialize(x, y)
    @center = Node.new(x, y)
  end
end

n = Node.new(0, 0)
puts n.make_neighbours
