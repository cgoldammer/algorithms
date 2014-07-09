macro timer(ex)
  return quote
    local t0 = time()
    local val = $ex
    local t1 = time()
    #println("elapsed time: ", t1-t0, " seconds")
    t1-t0
  end
end

function sort_timer(sorter!, size)
	a = random_array(size)
	t = @timer sorter!(a)
	return(t)
end

function random_array(size::Int64)
	a = rand(size)
	return(a)
end

# Comparing the speed of different sorting functions.
sorters = [sort!, insertionsort!, mergesort!]
obs = [10, 100, 1000, 10000]
sorter = sorters[1]
times = [sort_timer(sorter, size) for size=obs, sorter=sorters]
times_relative = broadcast(/, times, times[:,1])[:, 2:end]
# The times relative to the baked-in sort procedure.
times_relative