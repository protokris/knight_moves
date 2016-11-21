#
# Calculate the shortest path for a Chess Knight to an arbitrary position A,B on
# an infinite chessboard.  The knight starts at 0,0 and can go in any direction. 
# 

MAX_MOVES = 10000000 # for sanity

# A knight can move to 8 positions
MOVES = [
    { x: -2, y: -1 },
    { x: -2, y: 1 },
    { x: -1, y: -2 },
    { x: -1, y: 2 },
    { x: 1, y: -2 },
    { x: 1, y: 2 },
    { x: 2, y: -1 },
    { x: 2, y: 1 }
]

class Board
  
  def initialize(a, b)
    @maxx = [a, 0].max + 3
    @minx = [a, 0].min - 3
    @maxy = [b, 0].max + 3
    @miny = [b, 0].min - 3  
    @board = {}
  end
  
  def visited?(x, y)
    @board[x].nil? || @board[x][y].nil? ? false : true
  end
  
  def in_bounds?(x, y)
    x <= @maxx && y <= @maxy && x >= @minx && y >= @miny
  end
  
  def push(square)
    @board[square[:x]] = {} if @board[square[:x]].nil?
    @board[square[:x]][square[:y]] = square
  end
end

# This is a modified iterative application of Breadth First Search 
def solution(a, b)
  return 0 if a == 0 && b == 0 # why do anything?

  nummoves = 0  # track moves
  board = Board.new(a, b)  # handle visited squares

  queue = [ {x: 0, y: 0} ]  
  while queue.size > 0 && nummoves < MAX_MOVES do 
    nummoves = nummoves + 1 

    # "drain queue" to check and mark as checked
    queue.each do |square|
      board.push square
      square[:moves] = []

      MOVES.each do |move|
        nextmove = { x: move[:x] + square[:x], y: move[:y] + square[:y] }
        return nummoves if nextmove[:x] == a && nextmove[:y] == b
        if board.in_bounds?(nextmove[:x], nextmove[:y]) && !board.visited?(nextmove[:x], nextmove[:y]) 
          square[:moves].push nextmove 
        end
      end
    end    
    
    # enqueue children since we haven't hit our mark
    newq = []
    queue.each do |square|
       newq.concat square[:moves]
    end
    queue = newq.uniq
  end
  
  -1
end

puts solution(4, 5).to_s
puts solution(-100,92).to_s