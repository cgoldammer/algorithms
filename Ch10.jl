include("Ch10functions.jl")
using Base.Test

# Testing that the stack works as expected.
s = Stack()
@test stack_empty(s)
push!(s, 1)
@test s.top == 1
popped = pop!(s)
@test popped == 1
@test stack_empty(s)

# Checking that I'm providing a clean interface - just the three functions defined above.
methodswith(Stack)

# Testing that the queue works as expected
q = Queue(2)
enqueue!(q, 1)
@test dequeue!(q) == 1
enqueue!(q, 2)
@test dequeue!(q) == 2
enqueue!(q, 3)
enqueue!(q, 4)
@test dequeue!(q) == 3

# Testing the boundary conditions
q = Queue(1)
@test_throws ErrorException dequeue!(q)
enqueue!(q, 1)
@test_throws ErrorException enqueue!(q, 1)

# Exercise 10.1-2
# Implement two stacks in one array such that  neither overflows until the total
# number of elements is bigger than n.

type twostack
  top::Array{Int64, 1}
  data
end

twostack(n) = twostack([0, n+1], {None for i=1:n})
stack_empty(ts::twostack, stack::Int64) = stack==1 ? ts.top[stack]==0 : ts.top[stack]==length(ts.data)+1

# I achieve this by storing the data as follows [s1, ..., s2] where the ... represent potentially missing values
# and s2 is stored in reverse order.
function tspush!(ts::twostack, stack::Int64, x)
  n = length(ts.data)
  top = ts.top[stack] + (stack==1 ? 1 : -1)
  if stack==1 ? top >= ts.top[2] : top<= ts.top[1]
    error("Twostack overflow")
  end
  ts.top[stack] = top
  ts.data[top] = x
end

function tspop!(ts::twostack, stack::Int64)
  if stack_empty(ts, stack)
    error("Twostack underflow")
  else
    ts.top[stack] = ts.top[stack] + (stack==1 ? -1 : 1)
  end
  stack==1 ? 1 : -1
end

# Testing that the Twostack works as expected
ts = twostack(1)
@test_throws ErrorException tspop!(ts, 1)
@test_throws ErrorException tspop!(ts, 2)
tspush!(ts, 1, 1)
@test_throws ErrorException tspush!(ts, 1, 1)
@test_throws ErrorException tspush!(ts, 2, 1)

# Testing that the StackQueue works as expected
q = StackQueue()
q.add_stack
enqueue!(q, 1)
@test dequeue!(q) == 1
enqueue!(q, 2)
@test dequeue!(q) == 2
enqueue!(q, 3)
enqueue!(q, 4)
@test dequeue!(q) == 3

# Testing the boundary conditions
q = StackQueue()
@test_throws ErrorException dequeue!(q)

