require 'test/unit'
require './parallel_merge_sort'

class MergeSortTests < Test::Unit::TestCase

	# Test for:
	# - Invalid arguments
	# - Really Small Duration (All threads should be dead)
	# - Different sizes of input ()

	def test_invalid_arguments
		assert_raise ArgumentError do
			a = "BOOBOO"
			ParallelMergeSort.MergeSort(10, a)
		end
  	end

  	def test_basic_numbers
  		a = [1, 2, 3, 4]
  		ParallelMergeSort.MergeSort(10, a)
  	end
end