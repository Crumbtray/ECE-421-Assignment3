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
		
		watchdog = Thread.new do
		  sleep duration
		  puts "timeout!"
		  Thread.list.each {|t| t.kill}
		end
		
		puts "BEFORE A: #{a.to_s}"
		puts "BEFORE C: #{c.to_s}"

		MergeSortInternal(c, a, 0, a.length - 1)
		watchdog.kill
		
		puts "END A: #{a.to_s}"
		puts "END C: #{c.to_s}"
		
		# POST Conditions
		assert(@timeTaken < duration, "Time taken is over the stated duration.")
		assert(acceptanceTest(a), "Array is not sorted properly.")
		assert(Thread.list.select {|thread| thread.status == "run"}.count <= 1, "Threads running is greater than 1")
		# End POST Conditions
	end

	def self.MergeSortInternal(a, c, beginIndex, finalIndex)
	  puts "MergeSortInternal"
	  puts "%i %i" %[beginIndex, finalIndex]
		if(beginIndex < finalIndex)
			q = (beginIndex + finalIndex) / 2
			t1 = Thread.new do
				self.MergeSortInternal(a, c, beginIndex, q)
			end
			t2 = Thread.new do
				self.MergeSortInternal(a, c, q + 1, finalIndex)
			end
			t1.join
			t2.join
			self.PMerge(a, c, beginIndex, q, q + 1, finalIndex, beginIndex)
		end
	end

	# PMerge as described in the extra notes, page 10.
    # a is the array to be sorted, c is to contain the sorted results, 
	# aMin and aMax specifiy where the subarray A is in a
	# bMin and bMax specifiy where the subarray B is in a
	# cMin specifies where to insert a newly sorted value into c
    def self.PMerge(unsorted, sorted, aMin, aMax, bMin, bMax, cMin)
      puts "PMerge"
    	puts unsorted.to_s
    	puts sorted.to_s
    	puts "%i %i %i %i %i" %[aMin, aMax, bMin, bMax, cMin]
    
		aLength = aMax - aMin + 1
		bLength = bMax - bMin + 1
		if bLength > aLength
			puts "Reordering (B is longer than A)"
			t1 = Thread.new do 
				self.PMerge(unsorted, sorted, bMin, bMax, aMin, aMax, cMin)
			end
			t1.join
		elsif bLength == 0
			puts "B is zero, so use A"
			puts "aMin: #{aMin} (Should be zero!!!!)"
			puts "Index #{cMin} should be equal to #{unsorted[aMin]}"
		  	sorted[cMin + 1] = unsorted[aMin]
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
			cMid = cMin + aMid - aMin + bMid - bMin
      
			t2 = Thread.new do 
			  self.PMerge(unsorted, sorted, aMin, aMid, bMin, bMid, cMin)
			end
			t3 = Thread.new do
			  self.PMerge(unsorted, sorted, aMid + 1, aMax, bMid + 1, bMax, cMid + 1)
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