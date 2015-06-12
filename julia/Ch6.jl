using Base.Test

# Helper functions to walk through the heap
parent(i::Int64) = i >>> 1
left(i::Int64) = 2i
right(i::Int64) = 2i + 1

# Defined on page 154.
function max_heapify!(a,heapsize,i)
	left_ = left(i)
	right_ = right(i)
	if left_ <= heapsize && a[left_] > a[i]
		largest = left_
	else
		largest = i
	end
	if right_ <= heapsize && a[right_] > a[largest]
		largest = right_
	end
	if largest != i
		temp = a[i]
		a[i] = a[largest]
		a[largest] = temp
		max_heapify!(a, heapsize, largest)
	end
	return(a)
end

a = [1, 2, 3]
@test max_heapify!(a, length(a), 1) == [3, 2, 1]

function build_max_heap!(a)
	for i=(length(a) >>> 1):-1:1
		max_heapify!(a, length(a), i)
	end
end

# p.160
function heapsort!(a)
	heapsize = length(a)
	build_max_heap!(a)
	for i=length(a):-1:2
		temp = a[i]
		a[i] = a[1]
		a[1] = temp
		heapsize -= 1
		max_heapify!(a, heapsize, 1)
	end
	return(a)
end 

a = rand(10)
@test heapsort!(a) == sort(a)


