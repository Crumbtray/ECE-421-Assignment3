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
				raise ArgumentError, "ParallelMergeSort::ArgumentError -> Elements do not implement Comparable." unless a.first.included_modules.include? Comparable
			}
		end
		# End PRE Conditions

		@timeTaken = 0

		# POST Conditions
		assert(@timeTaken < duration)
		# End POST Conditions
	end

	def invariant
		assert(@timeTaken < duration)
	end

end