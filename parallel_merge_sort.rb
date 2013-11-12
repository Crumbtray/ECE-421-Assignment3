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
				raise ArgumentError, "ParallelMergeSort::ArgumentError -> Elements do not implement Comparable." unless element.included_modules.include? Comparable
			}
		end
		# End PRE Conditions

		@timeTaken = 0

		# POST Conditions
		assert(@timeTaken < duration, "Time taken is over the stated duration.")
		assert(acceptanceTest(a), "Array a is not sorted properly.")
		assert(Thread.list.select {|thread| thread.status == "run"}.count <= 1, "Threads running is greater than 1")
		# End POST Conditions
	end

	def MergeSortInternal(a, beginIndex, finalIndex)
		if(beginIndex < finalIndex)
			q = (beginIndex + finalIndex) / 2
			t1 = Thread.new do
				MergeSortInternal(A, beginIndex, q)
			end
			t2 = Thread.new do
				MergeSortInternal(A, q + 1, finalIndex)
			end
			t1.join
			t2.join
			# PMerge(A, B, C)
		end
	end

	# PMerge as described in the extra notes, page 10.
    # a is the array to be sorted, c is to contain the sorted results, 
	# aMin and aMax specifiy where the subarray A is in a
	# bMin and bMax specifiy where the subarray B is in a
	# cMin specifies where to insert a newly sorted value into c
    def PMerge(a, c, aMin, aMax, bMin, bMax, cMin)
	  aLength = aMax - aMin + 1
	  bLength = bMax - bMin + 1
		if bLength > aLength
			t1 = Thread.new do PMerge(a, bMin, bMax, aMin, aMax, vMin)
			end
			t1.join
		elsif (aLength== 1) and (bLength == 1)
			if a[aMin] <= a[bMin]
				c[cMin] = a[aMin]
				c[cMin + 1] = a[bMin]
			else
			  c[cMin] = a[bMin]
        c[cMin + 1] = a[aMin]
			end
		else 
			bMid = BinarySearch(a, bMin, bMax, a[alength/2 + aMin])
			aMid = (aMax + aMin) / 2
			
			t2 = Thread.new do 
			  PMerge(a, c, aMin, aMid - 1, bMin, bMid, cMin)
			end
			
			cMin = cMin + aMid - aMin + bMid - bMin
			c[cMin] = a[aMid] 
			
			t3 = Thread.new do
			  PMerge(a, c, aMid + 1, aMax, bMid, bMax, cMin)
			end
			t2.join
			t3.join
		end
	end

	def BinarySearch(b, bMin, bMax, value)
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

	def acceptanceTest(a)
		b = a.sort
		if(a == b)
			return true
		else
			return false
		end
	end
end