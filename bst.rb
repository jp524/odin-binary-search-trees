# frozen_string_literal: false

# Creates a node containing data and a pointer to its left and right children
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

# Creates a tree containing nodes
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

  def build_tree(start = @start, finish = @finish)
    return nil if start > finish

    mid = (start + finish) / 2
    node = Node.new(@array[mid])
    node.left = build_tree(start, mid - 1)
    node.right = build_tree(mid + 1, finish)
    @root = node
  end

  # pretty_print method from TOP community
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 2, 3, 4, 5, 6, 7])
tree.build_tree
tree.pretty_print
