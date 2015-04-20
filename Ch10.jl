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
@assert stack_empty(s)
push!(s, 1)
@assert s.top == 1
popped = pop!(s)
@assert popped == 1
@assert stack_empty(s)

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
  data = {0 for i=1:length}
  q = Queue(length, 1, 1, data)
end

function enqueue!(q::Queue, x::Any)
  if q.tail = q.head-1
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
  if q.head == q.tail
    error("Queue underflow")
  end
  x = q.data[q.head]
  if q.head == q.length
    q.head = 1
  else
    q.head += 1
  end
  x
end

q = Queue(2)
enqueue!(q, 1)
@assert dequeue!(q) == 1
enqueue!(q, 2)
@assert dequeue!(q) == 2
enqueue!(q, 3)
enqueue!(q, 4)
@assert dequeue!(q) == 3

q = Queue(1)
@test_throws ErrorException dequeue!(q)
enqueue!(q, 1)
@test_throws ErrorException enqueue!(q, 1)


