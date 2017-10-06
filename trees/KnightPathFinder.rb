require "PolyTreeNode"

class KnightPathFinder
  def initialize(pos)
    @visited_positions = [pos]
  end

  def self.valid_moves(pos)
    all_moves = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1],
                  [2, -1], [-2, -1]]
    squares = all_moves.map { |move| [(pos[0] + move[0]), (pos[1] + move[1])] }
    squares.select {|square| on_board?(square)}
  end

  def on_board?(pos)
    (0..7).include?(pos[0]) && (0..7).include?(pos[1])
  end

  def new_move_positions(pos)
   new_positions = valid_moves(pos).select {|move| !@visited_positions.include?(move)}
   @visited_positions.concat(new_positions)
   new_positions
  end

  def build_move_tree
    root = PolyTreeNode.new(@visited_positions.first)
    queue = [root]
    until queue.empty?
      current_node = queue.shift
      possible_moves = new_move_positions(current_node.value)
      possible_moves.each do |move|
        new_node = PolyTreeNode.new(move)
        queue.push(new_node)
        current_node.add_child(new_node)
      end
    end
    root

  end



end
