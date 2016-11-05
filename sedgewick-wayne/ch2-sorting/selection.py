from helpers import exch, report

# Selection sort
# Loop over i=0..(N-1). For each i, select the lowest value in sequence i,...,N-1.
def sort(a):
    N = len(a)
    for i in range(N):
        min = i
        for j in range(i+1, N):
            if a[j] < a[min]:
                min = j
        exch(a, i, min)

report(sort)
