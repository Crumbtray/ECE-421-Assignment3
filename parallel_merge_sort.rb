module ParallelMergeSort
	Thread.abort_on_exception = true

	def self.Sort(duration, a)
		# PRE Conditions
		begin
			raise ArgumentError, "ParallelMergeSort::ArgumentError -> duration is not a positive number" unless duration > 0
		end
		
		begin
			raise ArgumentError, "ParallelMergeSort::ArgumentError -> a is not an array." unless a.kind_of? Array
		end

		begin
			raise ArgumentError, "ParallelMergeSort::ArgumentError -> a is empty." unless (!a.empty?)
		end

		begin
			a.each {|element|
				raise ArgumentError, "ParallelMergeSort::ArgumentError -> Elements do not implement Comparable." unless element.class.included_modules.include? Comparable
			}
		end
		# End PRE Conditions

		@timeTaken = 0
		
		watchdog = Thread.new do
		  sleep duration
		  puts "timeout!"
		  Thread.list.each {|t| t.kill}
		end
		
		begin
			return self.MergeSort(a)
		rescue ThreadError
			Thread.list.each {|t| t.kill}
		end
		watchdog.kill
		
		
		# POST Conditions
		assert(@timeTaken < duration, "Time taken is over the stated duration.")
		assert(acceptanceTest(a), "Array is not sorted properly.")
		assert(Thread.list.select {|thread| thread.status == "run"}.count <= 1, "Threads running is greater than 1")
		# End POST Conditions
	end

	def self.MergeSort(a)
		if a.length <= 1
			return a
		else
			midpoint = a.length / 2
			t1 = Thread.new do
				self.MergeSort(a.take(midpoint))
			end
			t2 = Thread.new do
				self.MergeSort(a.drop(midpoint))
			end

			t1.join
			t2.join
			
			left = t1.value
			right = t2.value

			returnval = self.PMerge(left, right)
			return returnval
		end
	end

	def self.PMerge(a, b)
		result = Array.new
		# The idea here is to concatenate a with b, but finding the right place to merge by using binary search.
		if(b.length > a.length)
			self.PMerge(b, a)
		elsif(b.empty?)
			return a
		elsif(a.empty?)
			return b
		elsif(a.length == 1 and b.length == 1)
			if (a.first <= b.first)
				result.push(a.first).push(b.first)
				return result
			else
				result.push(b.first).push(a.first)
				return result
			end
		else
			# Split A and B by finding J through binary search.
			midpoint = a.length / 2
			j = self.MergeBinarySearch(b, a[midpoint])
			t1 = Thread.new do
				self.PMerge(a.take(midpoint), b.take(j + 1))
			end

			t2 = Thread.new do
				self.PMerge(a.drop(midpoint), b.drop(j + 1))
			end

			t1.join
			t2.join			
			
			return t1.value + t2.value
		end
	end

	# Special kind of binary search.
	# We're looking for the index J such that
	# B[J] < value < B[J+1]
	def self.MergeBinarySearch(b, value)
		imin = 0
		imax = b.length - 1

		while (imax >= imin)
			imid = (imax + imin) / 2
			if(b[imid] < value)
				imin = imid + 1
			elsif (b[imid] > value)
				imax = imid - 1
			else
				return imid
			end
		end

		return imax
	end

end