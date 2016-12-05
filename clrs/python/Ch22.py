from Ch10 import Queue

# Define adjacency lists
class AdjList():
    def  __init__(self, origin):
        self.origin = origin
        self.head = None
        self.tail = None

    def push(self, el):
        if not self.head:
            self.head = el
            self.tail = el
        else:
            self.tail.next = el
            self.tail = el

    def get_adj(self):
        elements = []
        next_el = self.head
        while next_el != None:
            elements.append(next_el.value)
            next_el = next_el.next
        return elements

    def vertices(self):
        val = []
        next = self.head
        while next != None:
            val.append(next)
            next = next.next
        return val

    def values(self):
        val = []
        next = self.head
        while next != None:
            val.append(next.value)
            next = next.next
        return val

    def values_with_origin(self):
        return [[self.origin.value] + self.values()]


    @classmethod
    def from_list(self, values):
        a = AdjList(AdjElement(values[0]))
        for value in values[1:]:
            a.push(AdjElement(value))
        return a

class AdjElement():
    def __init__(self, x):
        self.value = x
        self.next = None

    def __str__(self):
        return "Adjacency element: Value=%s" % self.value

    def as_list(self):
        vals = []
        if self.value:
            vals.append(self)
            next = self.next
            while next:
                vals.append(next)
                next = next.next
        return vals

class Graph():
    def __init__(self, lists):
        self.lists = {adj.origin.value: adj for adj in lists}

    @classmethod
    def from_lists(self, lists):
        return Graph([AdjList.from_list(values) for values in lists])

    def origins(self):
        v = [adj.origin for adj in self.lists.values() if adj != None]
        return v

    def transpose(self):
        origins = self.origins()
        lists = {}
        for (origin, head) in [(adj.origin, adj.head) for adj in self.lists.values()]:
            key = origin.value
            next = head
            while next != None:
                if next.value in lists:
                    lists[next.value].push(AdjElement(key))
                else:
                    adj = AdjList(AdjElement(next.value))
                    adj.push(AdjElement(key))
                    lists[next.value] = adj
                next = next.next
        return Graph(lists.values())

    def vertices(self):
        data = {}
        for (origin, head) in [(adj.origin, adj.head) for adj in self.lists.values()]:
            key = origin.value
            if key not in data:
                data[key] = origin
            elements = head.as_list()
            for element in elements:
                key = element.value
                if key not in data:
                    data[key] = element
        return data.values()

    def to_list(self):
        return sorted([[adj.origin.value] + adj.values() for adj in self.lists.values()])

        

# Testing the adjacency list
values = [1, 5, 3]
a = AdjList(AdjElement(values[0]))
for value in values[1:]:
    a.push(AdjElement(value))
assert a.get_adj() == values[1:]
assert a.origin.value == values[0]

# Define the sample graph used in the book, p.590

lists = [[1, 2, 5], [2, 1, 5, 3, 4], [3, 2, 4], [4, 2, 5, 3], [5, 4, 1, 2]]
graph = Graph.from_lists(lists)
heads = graph.origins()
values = [v.value for v in heads]
assert values == range(1, 6), "Vertices found %s" % values

# Exercises:
# 1-1
# The out-degree is O(n), where n is the length of the adjacency list
# The in-degrees have an upper-bound complexity of O(n^2), since I
# need to go through all occurrences in all lists

# 1-3
# For matrices, the transposed graph is just the transposed matrix
# For AdjList:
# Done via `Graph.transpose`.
# I am storing each potential target in a dictionary. For each of these targets,
# I build the adjacency list of edges leading towards that element.

lists = [[1, 2, 5], [2, 3]]
graph = Graph.from_lists(lists)
graph_lists = graph.to_list()
assert graph_lists == lists, "Expected: %s, got: %s" %(lists, graph_lists)
transposed = graph.transpose().to_list()
expected = [[2, 1], [3, 2], [5, 1]]
assert transposed == expected, "Expected: %s | Got: %s" % (expected, transposed)

# 1-4: There's multiple interpretations. What happens to single edges? Do they stay
# or disappear? Let's do it both ways.
# a) Single edges disappear
# Approach: Store the count for each sorted edge in a dict (this takes O(E))
# Then loop through again and take all elements with count = 2
# Add them to an adjacency list (This takes O(V + E))


COLOR_WHITE = 0
COLOR_GRAY = 1
COLOR_BLACK = 2
def bfs(graph, s):
    vertices = graph.vertices()
    for vertex in vertices:
        vertex.color = COLOR_WHITE
        vertex.d = 100
        vertex.parent = None
    s.color = COLOR_GRAY
    s.d = 0
    s.parent = None
    qu = Queue(len(vertices))
    qu.enqueue(s)
    while len(qu) > 0:
        u = qu.dequeue()
        if u.value in graph.lists:
            for v in graph.lists[u.value].vertices():
                if v.color == COLOR_WHITE:
                    v.color == COLOR_GRAY
                    v.d = u.d + 1
                    v.parent = u
                    qu.enqueue(v)
            u.color = COLOR_BLACK
    return graph

expected = [(1, 0), (2, 1), (3, 2), (5,1)]
vertices = graph.vertices()
ls = graph.lists[vertices[0].value]
calculated = [(v.value, v.d) for v in bfs(graph, vertices[0]).vertices()]
assert expected == calculated, "Expected: %s, got %s" % (expected, calculated)
