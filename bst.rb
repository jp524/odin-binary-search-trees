class Node
  include Comparable

  def initialize
    @data = []
    @left = []
    @right = []
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  def initialize(array)
    @array = array
    @root = ''
  end

  def clean_array
    @array.sort!.uniq!
  end

  def build_tree
    clean_array
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p tree.build_tree
