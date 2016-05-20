from helpers import exch, report

def sort(a):
    N = len(a)
    # h = 1, 3, 9, ...
    h = 1
    while (h < N / 3):
        h *= 3

    while h >= 1:
        print h
        for i in range(h, N):
            for j in range(h, i+1)[::-1]:
                if a[j] < a[j-h]:
                    exch(a, j, j-h)
                else:
                    break
        h /= 3


report(sort)
