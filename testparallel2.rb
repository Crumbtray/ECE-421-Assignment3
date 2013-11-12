require 'test/unit'
require './parallel2'

class MergeSortTests < Test::Unit::TestCase

	# Test for:
	# - Invalid arguments
	# - Really Small Duration (All threads should be dead)
	# - Different sizes of input ()

	def test_basic_unsorted_numbers
  		a = [2, 3, 1, 4, 8, 10, 6]
  		newA = ParallelMergeSort.Sort(0.0000001, a)
		b = [1, 2, 3, 4, 6, 8, 10]
		assert_equal(b,newA)
  	end
end