class SingleNode:

    def __init__(self, d):
        self.data = d
        self.next = None

    def append(self, d):
        end = SingleNode(d)
        n = self
        while n.next != None:
            n = n.next
        n.next = end

    def to_list(self):
        vals = [self.data]
        n = self
        while n.next != None:
            vals.append(n.next.data)
            n = n.next
        return vals

# A stack implemented via a singly-linked node
class Stack:
    top = None
    def pop(self):
        if self.top:
            item = self.top.data
            self.top = self.top.next
            return item
        return None
    def push(self, item):
        t = SingleNode(item)
        t.next = self.top
        self.top = t

# A queue implemented via a singly-linked node
class Queue:
    first = None
    last = None
    def enqueue(self, item):
        if not first:
            back = SingleNode(item)
            self.first = back
        else:
            back.next = SingleNode(item)
            back = back.next
    def dequeue(self):
        if self.first:
            item = self.first.data
            first = first.next
            return item
        return None
    def is_empty(self):
        self.first == self.last

# s = Stack()
# s.push(1)
# s.push(2)
# assert s.pop() == 2
# assert s.pop() == 1