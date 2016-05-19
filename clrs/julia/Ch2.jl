# Code corresponding to chapter 2
using Base.Test
using Distributions

# Insertion sort (page 18)
function insertionsort!(a)
	# Because this function changes the array, create a copy
	for j=2:length(a)
		key = a[j]
		i = j - 1
		while i > 0 && a[i] > key
			a[i+1] = a[i]
			i -= 1
		end
		a[i+1] = key
	end
	return(a)
end
@test insertionsort!([3,2,1]) == [1,2,3]

# Merge (page 31)
function merge!(a, p::Int64, q::Int64, r::Int64)
	n1 = q - p + 1
	n2 = r - q
	l = zeros(typeof(a[1]), n1 + 1)
	# Renamed L to m to fit Julia style
	m = zeros(typeof(a[1]), n2 + 1)
	for i = 1:n1
		l[i] = a[p + i - 1]
	end
	for j = 1:n2
		m[j] = a[q+j]
	end
	# The algorithms prescribes using infinity as the last value
	# and the closest value I have is the typemax. Need to check
	# whether this is still correct if the value equals the 
	# typemax.
	type_ = typeof(l[1])
	l[n1 + 1] = typemax(type_)
	m[n2 + 1] = typemax(type_)
	i = 1
	j = 1
	k = p
	for k = p:r
		if l[i] <= m[j]
			a[k] = l[i]
			i += 1
		else
			a[k] = m[j]
			j += 1
		end
	end
	return(a)
end

a = [2,4,6,3,5,7]
p = 1
q = 3
r = 6
@test merge!(a, p, q, r) == [i for i = 2:7]

# Merge-sort (p.34)
# Changes p and r to from and to for readability
function mergesort!(a, from=1::Int64, to=length(a)::Int64)
	if from < to
		middle = int(floor((from + to) / 2))
		mergesort!(a, from, middle)
		mergesort!(a, middle + 1, to)
		merge!(a, from, middle, to)
	end
	return(a)
end

a = [3,4,1]
@test mergesort!(a) == [1,3,4]