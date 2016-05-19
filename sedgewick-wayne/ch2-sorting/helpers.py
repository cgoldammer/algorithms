import random

def exch(a, first, second):
    temp = a[first]
    a[first] = a[second]
    a[second] = temp

def report(sorting_function):
    a = random_list()
    print "Initial %s" %a
    sorting_function(a)
    print "Final: %s" %a


def random_list(max_value=10, length=20):
    return [random.randint(0, 20) for _ in range(20)]
