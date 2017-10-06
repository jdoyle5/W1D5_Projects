class PolyTreeNode
  attr_reader :value, :parent
  attr_accessor :children

  def initialize(value, children = [])
    @value = value
    @children = children
    @parent = nil
  end

  def parent=(parent)
    return if parent == @parent
    @parent.children.delete(self) unless @parent.nil?
    @parent = parent
    @parent.children << self unless parent.nil?
    self
  end

  def add_child(child)
    child.parent= (self)
  end

  def remove_child(child)
    if @children.include?(child)
      child.parent = (nil)
    else
      raise "this is not your baby"
    end
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue.concat(current_node.children)
    end
    nil
  end

end
