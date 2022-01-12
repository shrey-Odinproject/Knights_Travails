require 'pry-byebug'

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
  attr_accessor :board

  def initialize
    @board = []
    a = *(0..7)

    a.each do |i|
      a.each do |j|
        board.push(Node.new(i, j))
      end
    end
  end

  def data_to_node(data)
    i, j = data
    idx = i * 8 + j
    board[idx]
  end

  def on_board?(x, y) # checks if inputted cordinates are on board
    if [x, y].all? { |num| num <= 7 && num >= 0 }
      true
    else
      false
    end
  end

  def assign_neighbours(vertex)
    x, y = vertex.data
    n0 = data_to_node([x + 1, y + 2]) if on_board?(x + 1, y + 2)
    n1 = data_to_node([x + 1, y - 2]) if on_board?(x + 1, y - 2)
    n2 = data_to_node([x - 1, y + 2]) if on_board?(x - 1, y + 2)
    n3 = data_to_node([x - 1, y - 2]) if on_board?(x - 1, y - 2)

    n4 = data_to_node([x + 2, y + 1]) if on_board?(x + 2, y + 1)
    n5 = data_to_node([x + 2, y - 1]) if on_board?(x + 2, y - 2)
    n6 = data_to_node([x - 2, y + 1]) if on_board?(x - 2, y + 1)
    n7 = data_to_node([x - 2, y - 1]) if on_board?(x - 2, y - 1)

    vertex.neigh = [n0, n1, n2, n3, n4, n5, n6, n7] - [nil]
  end

  def knight_moves(s_data, e_data)
    start = data_to_node(s_data)
    destination = data_to_node(e_data)
    assign_neighbours(start)
    assign_neighbours(destination)

    path = [start]
    visited = [start]
    queue = [start]

    while true
      # binding.pry
      if start.neigh.include?(destination)
        queue.shift
        visited.push(destination)
        path.push(destination)
        return path
      else
        start.neigh.each do |vertex|
          assign_neighbours(vertex)
          queue.push(vertex)
        end

        start = queue.shift while visited.include?(start)

        visited.push(start)
        path.push(start)
      end
    end
  end
end

b = Board.new
puts b.knight_moves([3, 3], [0, 0])

# n=b.board[27]
# puts b.assign_neighbours(n)
