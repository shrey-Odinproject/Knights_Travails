require 'pry-byebug'
# represents a tile on chess board
class Node
  attr_accessor :data, :neigh, :prev, :visited

  def initialize(x_cor = nil, y_cor = nil)
    @data = [x_cor, y_cor]
    @neigh = []
    @prev = nil # points to node from which it came from
    @visited = false
  end

  def to_s
    "[#{data[0]},#{data[1]}]"
  end
end

# represents a chess-board
class Board
  attr_accessor :board

  def initialize
    @board = []
    a = *(0..7)
    # create a board with 64 tiles(nodes) [0,0] to [7,7]
    a.each do |i|
      a.each do |j|
        board.push(Node.new(i, j))
      end
    end
  end

  def data_to_node(data)
    # takes in data and finds node on board with the matching data
    i, j = data
    idx = i * 8 + j
    board[idx]
  end

  def on_board?(x, y)
    # checks if inputted cordinates are on board
    if [x, y].all? { |num| num <= 7 && num >= 0 }
      true
    else
      false
    end
  end

  def assign_neighbors(node)
    # takes in a node and assigns it all possible neighbors
    x, y = node.data
    n0 = data_to_node([x + 1, y + 2]) if on_board?(x + 1, y + 2)
    n1 = data_to_node([x + 1, y - 2]) if on_board?(x + 1, y - 2)
    n2 = data_to_node([x - 1, y + 2]) if on_board?(x - 1, y + 2)
    n3 = data_to_node([x - 1, y - 2]) if on_board?(x - 1, y - 2)

    n4 = data_to_node([x + 2, y + 1]) if on_board?(x + 2, y + 1)
    n5 = data_to_node([x + 2, y - 1]) if on_board?(x + 2, y - 2)
    n6 = data_to_node([x - 2, y + 1]) if on_board?(x - 2, y + 1)
    n7 = data_to_node([x - 2, y - 1]) if on_board?(x - 2, y - 1)

    node.neigh = [n0, n1, n2, n3, n4, n5, n6, n7] - [nil]
  end

  # gives path of a knight from start point to end point on chess board
  def knight_moves(s_data, e_data)
    start = data_to_node(s_data) # start node
    assign_neighbors(start) # connecting start with its neighbors
    destination = data_to_node(e_data) # end node

    queue = [] # queue dictates which node we look at next

    # Visit and add the start node to the queue
    start.visited = true
    queue.push(start)

    # BFS until queue becomes empty (no ans blank string returned ) or is emptied manually (ans found)
    while queue.length > 0
      # remove node from queue to look at it
      current_node = queue.shift

      # loop through neighbors of current to find destination
      current_node.neigh.each do |node|
        if !node.visited
          # visit and add node's neighbors to queue
          node.visited = true
          assign_neighbors(node) # before adding to queue connect node's neighbors with their respective neighbors
          queue.push(node)
          # update prev for neighbors as they all came from current_node
          node.prev = current_node

          # stop BFS if node we r visiting is destination node
          if node == destination
            queue.clear # force empty queue
            break # break out of each loop
          end
        end
      end
      # execution now jumps to while and as queue is empty we break out of while as well
    end
    # after breaking out of while
    trace_route(destination)
  end

  # Function to trace the route using preceding nodes
  def trace_route(destination)
    node = destination # start from end and go to start doing .prev evry-step
    route = []
    # start node has no preceding node
    # so loop until node exist
    # when node is start start.prev is null no next iteration nvr happens
    while node
      route.push(node)
      node = node.prev
    end
    puts route.reverse # reverse the route bring start to the front
  end
end

b = Board.new
b.knight_moves([3, 3], [4, 3])
