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
tree_insert = function(t::Tree, z::Node)
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
        

# Ex 12.1-4. Post-order walk is analogous
preorder_tree_walk = function(n::Node)
    keys = Int64[]
    if !n.empty
        push!(keys, n.key)
        append!(keys, preorder_tree_walk(n.left))
        append!(keys, preorder_tree_walk(n.right))
    end
    keys
end

# Ex 12.2-2. Maximum is analogous
tree_minimum_recursive = function(n::Node)
    if !n.left.empty
        tree_minimum_recursive(n.left)
    end
    n.key
end

tree_minimum = function(n::Node)
    while !x.left.empty
        x = x.left
    end
    return x
end 

tree_maximum = function(n::Node)
    while !x.right.empty
        x = x.right
    end
    x
end


tree_successor = function(x::Node)
  if !x.right.empty
    return tree_minimum(x.right)
  end
  y = x.p
  while !y.empty && x == y.right
      x = y
      y = y.p
  end
  y
end

end
