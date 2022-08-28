# frozen_string_literal: false

# Creates a node containing data and a pointer to its left and right children
class Node
  attr_accessor :data, :left, :right

  include Comparable

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
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

  def insert(value, root = @root)
    node = Node.new(value)

    puts 'Tree is empty. Start by calling Tree.new([array] then #build_tree.' if root.nil?
    case node <=> root
    when 1
      root.right = node if root.right.nil?
      insert(value, root.right)
    when -1
      root.left = node if root.left.nil?
      insert(value, root.left)
    end
  end

  def delete(value, root = @root)
    puts 'Tree is empty. Start by calling Tree.new([array] then #build_tree.' if root.nil?
  end
end

tree = Tree.new([1, 2, 3, 4, 5, 6, 8])
tree.build_tree
tree.pretty_print
tree.delete(8)
puts "___________________\n\n"
tree.pretty_print
