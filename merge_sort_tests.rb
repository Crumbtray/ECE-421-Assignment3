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
	
	def test_two_sorted_numbers
  		a = [1, 2]
  		ParallelMergeSort.MergeSort(10, a)
		b = [1, 2]
		puts 'arrays'
		puts a
		puts b
		assert_equal(a,b)
  	end
	
	def test_two_reverse_numbers
  		a = [2, 1]
  		ParallelMergeSort.MergeSort(10, a)
		b = [1, 2]
		puts 'arrays'
		puts a
		puts b
		assert_equal(a,b)
  	end

  	def test_basic_sorted_numbers
  		a = [1, 2, 3]
  		ParallelMergeSort.MergeSort(10, a)
		b = [1, 2, 3]
		assert_equal(a,b)
  	end
	
	def test_basic_unsorted_numbers
  		a = [3, 2, 1]
  		ParallelMergeSort.MergeSort(10, a)
		b = [2, 3, 1]
		assert_equal(a,b)
  	end
	
	def atest_many_sorted_numbers
  		a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  		ParallelMergeSort.MergeSort(10, a)
		b = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		assert_equal(a,b)
  	end
	
	def atest_many_unsorted_numbers
  		a = [5, 7, 9, 0, 2, 4, 6, 10, 8, 3, 1]
  		ParallelMergeSort.MergeSort(10, a)
		b = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		assert_equal(a,b)
  	end
end