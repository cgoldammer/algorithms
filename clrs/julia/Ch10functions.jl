# A stack operates like a set of trays in a cafeteria. You can put a plate on top (push) and you can take that plate
# off (pop). Thus, it's a Last-In-First-Out (LIFO) data structure.
type Stack
  top::Int64
  data::Array{Any, 1}
end
Stack() = Stack(0, Any[])

stack_empty(s::Stack) = s.top == 0

function stpush!(s::Stack, x::Any)
  s.top += 1
  push!(s.data, x)
  return
end

function stpop!(s::Stack)
  if stack_empty(s)
    error("Stack underflow")
  else
    s.top -= 1
    pop!(s.data)
  end
end

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

# Exercise 10.1-2
# Implement two stacks in one array such that  neither overflows until the total
# number of elements is bigger than n.
type TwoStack
  top::Array{Int64, 1}
  data
end

TwoStack(n) = TwoStack([0, n+1], {None for i=1:n})
stack_empty(ts::TwoStack, stack::Int64) = stack==1 ? ts.top[stack]==0 : ts.top[stack]==length(ts.data)+1

# I achieve this by storing the data as follows [s1, ..., s2] where the ... represent potentially missing values
# and s2 is stored in reverse order.
function tspush!(ts::TwoStack, stack::Int64, x)
  n = length(ts.data)
  top = ts.top[stack] + (stack==1 ? 1 : -1)
  if stack==1 ? top >= ts.top[2] : top<= ts.top[1]
    error("Twostack overflow")
  end
  ts.top[stack] = top
  ts.data[top] = x
end

function tspop!(ts::TwoStack, stack::Int64)
  if stack_empty(ts, stack)
    error("Twostack underflow")
  else
    ts.top[stack] = ts.top[stack] + (stack==1 ? -1 : 1)
  end
  stack==1 ? 1 : -1
end

# 10.1-6 Implement a queue using two stacks
type StackQueue
  add_stack::Stack
  drop_stack::Stack
end

StackQueue() = StackQueue(Stack(), Stack())

function enqueue!(s::StackQueue, x)
  print(s.add_stack)
  stpush!(s.add_stack, x)
end

function dequeue!(q::StackQueue)
  for i = 2:q.add_stack.top
    stpush!(q.drop_stack, stpop!(q.add_stack))
  end
  head = stpop!(q.add_stack)
  for i = 1:q.drop_stack.top
    stpush!(q.add_stack, stpop!(q.drop_stack))
  end
  head
end

