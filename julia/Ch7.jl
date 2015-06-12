
# p. 171
function partition!(a, p, r)
	x = a[r]
	i = p - 1
	for j=p:(r-1)
		if a[j] <= x
			i += 1
			temp = a[i]
			a[i] = a[j]
			a[j] = temp
		end
	end
	temp = a[i+1]
	a[i+1] = a[r]
	a[r] = temp
	return(i+1)
end

function quicksort!(a, p=1, r=length(a))
	if p < r
		q = partition!(a, p, r)
		quicksort!(a, p, q-1)
		quicksort!(a, q+1, r)
	end
	return(a)
end


a = rand(10)
@test quicksort!(a) == sort(a)