from helpers import exch, report

# Insertion sort
def sort(a):
    N = len(a)
    for i in range(1, N-1):
        for j in range(1, i)[::-1]:
            if a[j-1] > a[j]:
                exch(a, j-1, j)
            else:
                break

report(sort)


