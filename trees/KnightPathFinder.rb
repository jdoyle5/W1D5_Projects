require_relative "lib/00_tree_node.rb"

class KnightPathFinder
  attr_reader :move_tree

  def initialize(pos)
    @visited_positions = [pos]
    @move_tree= build_move_tree
  end

  def valid_moves(pos)
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

  def find_path(pos)
    end_pos = @move_tree.dfs(pos)
    trace_path_back(end_pos)
  end

  def trace_path_back(end_pos)
    path = [end_pos]
    until path.first.parent.nil?
      path.unshift(path.first.parent)
    end
    path
    path.map(&:value)

  end

end

k = KnightPathFinder.new([0,0])
k.move_tree.children.length
p k.find_path([6,2])
