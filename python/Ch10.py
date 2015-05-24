from unittest import TestCase

class Stack(object):
    def __init__(self, n):
        self.vals = range(n)
    top = 0
    def empty(self):
        return self.top == 0
    def push(self, x):
        self.top += 1
        self.vals[self.top] = x
    def pop(self):
        if self.empty():
            raise Exception("Underflow")
        else:
            self.top -= 1
            return self.vals[self.top + 1]

class Queue(object):
    head = 0
    tail = 0

    def __len__(self):
        return self.len

    def __init__(self, n):
        self.len = n
        self.vals = range(n)

    def next(self, i):
        return (i+1) % len(self)

    def enqueue(self, x):
        self.vals[self.tail] = x
        self.tail = self.next(self.tail)

    def dequeue(self):
        x = self.vals[self.head]
        self.head = self.next(self.head)
        return x

# Ex 10.1-4: Rewrite ENQUEUE and DEQUEUE to detect underflow and overflow of a queue.
# To do this, I add an `empty` attribute that is toggled whenever the queue runs
# out of elements.
# Overflow happens whenever we're adding to a queue that isn't empty and where
# tail equals head.
# Underflow happens whenever we'd be dequeueing from an empty list.
class ExceptionQueue(Queue):
    empty = True
    def enqueue(self, x):
        if not self.empty and self.head == self.tail:
            raise Exception("Overflow")
        super(ExceptionQueue, self).enqueue(x)
        self.empty = False

    def dequeue(self):
        if self.empty:
            raise Exception("Underflow")
        if self.next(self.tail) == self.head:
            self.empty = True
        return super(ExceptionQueue, self).dequeue()

class TestStack(TestCase):
    def test_stack(self):
        s = Stack(10)

        with self.assertRaises(Exception):
            s.pop()

        s.push(1)
        x = s.pop()
        self.assertEqual(x, 1)

        s.push(2)
        x = s.pop()
        self.assertEqual(x, 2)

class TestQueue(TestCase):
    def test_queue(self):
        q = Queue(2)
        q.enqueue(1)
        x = q.dequeue()
        self.assertEquals(x, 1)
        q.enqueue(1)
        q.enqueue(2)
        x = q.dequeue()
        self.assertEquals(x, 1)

class TestExceptionQueue(TestCase):
    def test_queue(self):
        q = ExceptionQueue(2)
        with self.assertRaises(Exception):
            q.dequeue()
        q.enqueue(1)
        x = q.dequeue()
        self.assertEquals(x, 1)
        q.enqueue(1)
        q.enqueue(2)
        x = q.dequeue()
        self.assertEquals(x, 1)
        q.enqueue(2)
        with self.assertRaises(Exception):
            q.enqueue(3)

# Implement a deque. No bounds checking
class Deque(Queue):
    def previous(self, i):
        return (i-1) % len(self)
    def add_end(self, x):
        return super(Deque, self).enqueue(x)
    def pop_start(self):
        return super(Deque, self).dequeue()
    def add_start(self, x):
        self.head = self.previous(self.head)
        self.vals[self.head] = x
    def pop_end(self):
        self.tail = self.previous(self.tail)
        return self.vals[self.tail]

class TestDeque(TestCase):
    def test_deque(self):
        q = Deque(2)
        q.add_start(1)
        x = q.pop_start()
        self.assertEquals(x, 1)
        q.add_end(2)
        q.add_start(1)
        x = q.pop_end()
        self.assertEquals(x, 2)
        x = q.pop_start()
        self.assertEquals(x, 1)


if __name__ == "__main__":
    unittest.main()

