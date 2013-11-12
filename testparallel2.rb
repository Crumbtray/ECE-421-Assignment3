require 'test/unit'
require './parallel2'

class MergeSortTests < Test::Unit::TestCase

	# Test for:
	# - Invalid arguments
	# - Really Small Duration (All threads should be dead)
	# - Different sizes of input ()

	def test_basic_unsorted_numbers
  		a = [2, 3, 1, 4]
  		newA = ParallelMergeSort.MergeSort(a)
		b = [1, 2, 3, 4]
		assert_equal(b,newA)
  	end
end