include("Ch12functions.jl")
import Base.Test

node = Ch12.NewNode()
t = Ch12.Tree()
z = Ch12.Node(0)
Ch12.tree_insert(t, z) 
@assert t.root == z
Ch12.inorder_tree_walk(z)
z.empty
z.left
z.empty
t.root.empty

Ch12.tree_insert(t, Ch12.Node(5))
Ch12.tree_insert(t, Ch12.Node(7))
Ch12.tree_insert(t, Ch12.Node(1))

@assert Ch12.inorder_tree_walk(z) == [0, 1, 5, 7]
