module Ch12
type Node
    empty::Bool
    p::Node
    left::Node
    right::Node
    key::Int64
    Node() = (x = new(true);)
end
NewNode = function()
    n = Node()
    n.p = Node()
    n.left = Node()
    n.right = Node()
    n
end
Node(k) = (n = NewNode(); n.empty=false; n.key = k; n)
type Tree
    root::Node
end
Tree() = Tree(Node())
tree_insert = function(t, z)
    y = Node() 
    x = t.root
    if x.empty
        t.root = z
        return
    end
    while !x.empty 
        y = x
        if z.key < x.key
            x = x.left
        else
            x = x.right
        end
    end
    z.p = y
    if z.key < y.key
        y.left = z
    else 
        y.right = z
    end
end   
inorder_tree_walk = function(n::Node)
    keys = Int64[]
    if !n.empty
        append!(keys, inorder_tree_walk(n.left))
        push!(keys, n.key)
        append!(keys, inorder_tree_walk(n.right))
    end
    keys
end
        
end
