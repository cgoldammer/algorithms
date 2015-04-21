using Base.Test

# A stack operates like a set of trays in a cafeteria. You can put a plate on top (push) and you can take that plate
# off (pop). Thus, it's a Last-In-First-Out (LIFO) data structure.

type Stack
  top
  data
end
Stack() = Stack(0, Any[])

stack_empty(s::Stack) = s.top == 0

function push!(s::Stack, x)
  s.top += 1
  push!(s.data, x)
  return
end

function pop!(s::Stack)
  if stack_empty(s)
    error("Stack underflow")
  else
    s.top -= 1
    s.data[s.top + 1]
  end
end

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

# A queue is FIFO: The person first who's first in line will be handled first, and new people join at
# the end.

# As described in the book, the queue has a maximum length.
type Queue
  length::Int64
  head::Int64
  tail::Int64
  data::Array{Any, 1}
end

function Queue(length)
  # Using curly brackets because we want the data to be of type Array{Any, 1}
  data = {None for i=1:length}
  q = Queue(length, 1, 1, data)
end

function enqueue!(q::Queue, x::Any)
  if q.data[q.tail] != None
    error("Queue overflow")
  end
  q.data[q.tail] = x
  if q.tail == q.length
    q.tail = 1
  else
    q.tail += 1
  end
end

function dequeue!(q::Queue)
  x = copy(q.data[q.head])
  if x == None
      error("Queue underflow")
  end
  q.data[q.head] = None
  if q.head == q.length
    q.head = 1
  else
    q.head += 1
  end
  x
end

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
@test_throws ErrorException  dequeue!(q)
enqueue!(q, 1)
@test_throws ErrorException enqueue!(q, 1)

# Exercise 10.1-2
# Implement two stacks in one array such that  neither overflows until the total
# number of elements is bigger than n.

# I achieve this by storing the data as follows [s1, ..., s2] where the ... represent potentially missing values
# and s2 is stored in reverse order.

type twostack
  top::Array{Int64, 1}
  data
end

twostack(n) = twostack([0, n+1], {None for i=1:n})

stack_empty(ts::twostack, stack::Int64) = stack==1 ? ts.top[stack]==0 : ts.top[stack]==length(ts.data)+1

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

stack=2
ts = twostack(1)
@test_throws ErrorException tspop!(ts, 1)
@test_throws ErrorException tspop!(ts, 2)
tspush!(ts, 1, 1)
@test_throws ErrorException tspush!(ts, 1, 1)
@test_throws ErrorException tspush!(ts, 2, 1)

