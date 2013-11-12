require 'test/unit/assertions.rb'
include Test::Unit::Assertions

# Module that implements multi-threaded merge sort
module ParallelMergeSort
	# Sorts Array A in the time limit duration
	# using Parallel MergeSort.
	def self.MergeSort(duration, a)
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

		c = a.dup
		
		MergeSortInternal(a, 1, a.length - 1, c)
		
		puts a.to_s
		
		# POST Conditions
		assert(@timeTaken < duration, "Time taken is over the stated duration.")
		assert(acceptanceTest(a), "Array is not sorted properly.")
		assert(Thread.list.select {|thread| thread.status == "run"}.count <= 1, "Threads running is greater than 1")
		# End POST Conditions
	end

	def self.MergeSortInternal(a, beginIndex, finalIndex, c)
	  	puts "MergeSortInternal"
	 	puts "A: #{a}"
	 	puts "BeginIndex: #{beginIndex}"
	 	puts "FinalIndex: #{finalIndex}"

		if(beginIndex == finalIndex)
			return a
		end

		if(beginIndex < finalIndex)
			q = (beginIndex + finalIndex) / 2
			t1 = Thread.new do
				self.MergeSortInternal(a, beginIndex, q, c)
			end
			t2 = Thread.new do
				self.MergeSortInternal(a, q + 1, finalIndex, c)
			end
			t1.join
			t2.join
			self.ClintonPMerge(t1.value, t2.value, c)
			#self.PMerge(threads, a, c, beginIndex, q, q + 1, finalIndex, beginIndex)
		end
	end

	# PMerge as described in the extra notes, page 10.
    # a is the array to be sorted, c is to contain the sorted results, 
	# aMin and aMax specifiy where the subarray A is in a
	# bMin and bMax specifiy where the subarray B is in a
	# cMin specifies where to insert a newly sorted value into c
    def self.PMerge(threads, unsorted, sorted, aMin, aMax, bMin, bMax, cMin)
      puts "PMerge"
    puts unsorted.to_s
    puts sorted.to_s
    puts "%i %i %i %i %i" %[aMin, aMax, bMin, bMax, cMin]
    
		aLength = aMax - aMin + 1
		bLength = bMax - bMin + 1
		if bLength > aLength
			t1 = Thread.new do 
				self.PMerge(threads, unsorted, sorted, bMin, bMax, aMin, aMax, cMin)
			end
			threads.push(t1)
			t1.join
		elsif bLength == 0
		  sorted[cMin] = unsorted[aMin]
		elsif (aLength == 1) and (bLength == 1)
  			if unsorted[aMin] <= unsorted[bMin]
  				sorted[cMin] = unsorted[aMin]
  				sorted[cMin + 1] = unsorted[bMin]
  			else
  			  sorted[cMin] = unsorted[bMin]
  			  sorted[cMin + 1] = unsorted[aMin]
  			end
		else 
			aMid = (aMax + aMin) / 2
			bMid = self.BinarySearch(unsorted, bMin, bMax, unsorted[aMid])
			cMid = cMin + aMid - aMin + bMid - bMin + 1
      
			t2 = Thread.new do 
			  self.PMerge(threads, unsorted, sorted, aMin, aMid, bMin, bMid, cMin)
			end
			t3 = Thread.new do
			  self.PMerge(threads, unsorted, sorted, aMid + 1, aMax, bMid + 1, bMax, cMid)
			end
			threads.push(t2, t3)
			t2.join
			t3.join
		end
	end

	def self.ClintonPMerge(a, b, c)
		puts "ClintonPMERGE:"
		puts "A: #{a}, #{a.class}"
		puts "B: #{b}"
		puts "C: #{c}"

		l = a.length - 1
		m = b.length - 1
		n = c.length - 1

		if(m > l)
			t1 = Thread.new do
				self.ClintonPMerge(b, a, c)
			end
			t1.join
		elsif (n == 1)
			c[1] = a[1]
		elsif (l == 1 && m == 1)
			if(a[1] <= b[1])
				c[1] = a[1]
				c[2] = b[1]
			else
				c[1] = b[1]
				c[2] = a[1]
			end
		else
			midpoint = a[l / 2]
			j = BinarySearch(b, b.first, b.last, midpoint)
			t2 = Thread.new do
				self.ClintonPMerge(a.take(l / 2), b.take(j), c.take(l/2 + j))
			end

			t3 = Thread.new do
				self.ClintonPMerge(a.drop(l / 2), b.drop(j), c.drop(l/2 + j))
			end
			t2.join
			t3.join
		end

	end


	def self.BinarySearch(b, bMin, bMax, value)
		low = bMin
		high = bMax
		while low < high
			mid = (low + high) / 2
			if b[mid] < value
				low = mid + 1
			else
				high = mid
			end
		end
		return low
	end

	def invariant
		assert(@timeTaken < duration)
	end

	def self.acceptanceTest(a)
		b = a.sort
		if(a == b)
			return true
		else
			return false
		end
	end
end