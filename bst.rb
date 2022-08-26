class Node
  attr_accessor :data, :left, :right

  include Comparable

  def initialize(data)
    @data = data
    @left = []
    @right = []
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  attr_reader :root

  def initialize(array)
    @array = array
    clean_array
    @root = ''
    @start = 0
    @finish = @array.size - 1
  end

  def clean_array
    @array.sort!.uniq!
  end

  def build_tree(array = @array, start = @start, finish = @finish)
    return nil if start > finish

    mid = (start + finish) / 2
    node = Node.new(array[mid])
    node.left = array[start..mid - 1]
    node.right = array[mid + 1..finish]
    @root = node
  end
end

tree = Tree.new([1, 2, 3])
tree.build_tree
p tree.root
