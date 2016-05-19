include("Ch10functions.jl")
using Base.Test

# Testing that the stack works as expected.
s = Stack()
@test stack_empty(s)
stpush!(s, 1)
@test s.top == 1
popped = stpop!(s)
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

# Testing that the Twostack works as expected
ts = TwoStack(1)
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


sl = SingleList()
