array = Array.new(15) { rand(1..100) }
tree = Tree.new(array)
tree.build_tree
puts "Tree is balanced? #{tree.balanced?}"
puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
puts "Inorder: #{tree.inorder}"
puts "Insert numbers > 100"
tree.insert(101)
tree.insert(118)
tree.insert(204)
tree.insert(307)
puts "Tree is balanced? #{tree.balanced?}"
tree.rebalance
puts "Tree is balanced? #{tree.balanced?}"
puts "Level order: #{tree.level_order}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
puts "Inorder: #{tree.inorder}"
