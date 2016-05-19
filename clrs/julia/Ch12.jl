include("Ch12functions.jl")
import Base.Test

node = Ch12.NewNode()
t = Ch12.Tree()

keys = [5, 7, 1, 4, 6]
nodes = {k => Ch12.Node(k) for k in keys}

for key in keys
    Ch12.tree_insert(t, nodes[key])
end

@assert t.root.key == nodes[keys[1]].key

@assert Ch12.inorder_tree_walk(t.root) == sort(keys)
@assert Ch12.tree_successor(nodes[1]).key == 4
@assert Ch12.tree_successor(nodes[5]).key == 6 


