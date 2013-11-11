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

	def MergeSortInternal(A, beginIndex, finalIndex)
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
	# A is the first array, B is the second array,
	# And the final result should be put into C.
	def PMerge(A, B, C)

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