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
    puts 'Tree is empty. Start by calling Tree.new([array]) then #build_tree.' if root.nil?

    node = Node.new(value)
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
    puts 'Tree is empty. Start by calling Tree.new([array]) then #build_tree.' if @root.nil?

    node = Node.new(value)
    case node <=> root
    when 1
      root.right = delete(value, root.right)
      root
    when -1
      root.left = delete(value, root.left)
      root
    when 0
      if root.left.nil?
        root.right
      elsif root.right.nil?
        root.left
      else
        temp_right = root.right
        temp_left = root.left
        root = min_value(root.right)
        root.right = delete(root.data, temp_right)
        root.left = temp_left
        root
      end
    end
  end

  def min_value(root)
    root = root.left until root.left.nil?
    root
  end

  def find(value, root = @root)
    return if root.nil?

    node = Node.new(value)
    case node <=> root
    when 1
      find(value, root.right)
    when -1
      find(value, root.left)
    when 0
      root
    end
  end

  def level_order
    return if @root.nil?

    queue = []
    array = []
    queue << @root
    until queue.empty?
      current = queue.first
      yield current if block_given?
      array << current.data
      queue << current.left if current.left
      queue << current.right if current.right
      queue.shift
    end
    array
  end

  def inorder(root = @root, array = [], &block)
    return if root.nil?

    inorder(root.left, array, &block)
    block.call(root) if block_given?
    array << root.data
    inorder(root.right, array, &block)
    array
  end

  def preorder(root = @root, array = [], &block)
    return if root.nil?

    block.call(root) if block_given?
    array << root.data
    preorder(root.left, array, &block)
    preorder(root.right, array, &block)
    array
  end

  def postorder(root = @root, array = [], &block)
    return if root.nil?

    postorder(root.left, array, &block)
    postorder(root.right, array, &block)
    block.call(root) if block_given?
    array << root.data
    array
  end
end

tree = Tree.new([20, 30, 40, 50, 60, 70, 80])
tree.build_tree
tree.pretty_print
p tree.inorder
tree.inorder { |node| puts node.data }
p tree.preorder
tree.preorder { |node| puts node.data }
p tree.postorder
tree.postorder { |node| puts node.data }
