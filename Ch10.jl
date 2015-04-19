# A stack operates like a set of trays in a cafeteria. You can put a plate on top (push) and you can take that plate
# off (pop). Thus, it's a Last-In-First-Out data structure.

type Stack
  top
  data
end
Stack() = Stack(0, Any[])

stack_empty(s::Stack) = s.top == 0

function push(s::Stack, x)
  s.top += 1
  push!(s.data, x)
  return
end

function pop(s::Stack)
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
push(s, 1)
@assert s.top == 1
popped = pop(s)
@assert popped == 1
@assert stack_empty(s)

# Checking that I'm providing a clean interface - just the three functions defined above.
methodswith(Stack)

