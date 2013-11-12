require 'test/unit'
require './parallel_merge_sort'

class MergeSortTests < Test::Unit::TestCase

	# Test for:
	# - Invalid arguments
	# - Really Small Duration (All threads should be dead)
	# - Different sizes of input ()

	def atest_argument_not_array
		assert_raise ArgumentError do
			a = "BOOBOO"
			ParallelMergeSort.MergeSort(10, a)
		end
  	end
	
	def atest_arguments_not_comparable
		assert_raise ArgumentError do
			a = [1,'a']
			ParallelMergeSort.MergeSort(10, a)
		end
  	end
	
	def atest_duration_exceeded
  		a = [2, 3, 1]
		duration = 0.001
		start = Time.now
  		ParallelMergeSort.MergeSort(duration, a)
		assert_in_delta(start + duration, Time.now, 1);
		
  	end
	
	def atest_two_sorted_numbers
  		a = [1, 2]
  		ParallelMergeSort.MergeSort(10, a)
		b = [1, 2]
		assert_equal(b,a)
  	end
	
	def atest_two_reverse_numbers
  		a = [2, 1]
  		ParallelMergeSort.MergeSort(10, a)
		b = [1, 2]
		assert_equal(b,a)
  	end

  	def atest_basic_sorted_numbers
  		a = [1, 2, 3]
  		ParallelMergeSort.MergeSort(10, a)
		b = [1, 2, 3]
		assert_equal(b,a)
  	end
	
	def test_basic_unsorted_numbers
  		a = [2, 3, 1]
  		ParallelMergeSort.MergeSort(10, a)
		b = [1, 2, 3]
		assert_equal(b,a)
  	end
	
	def atest_basic_unsorted_strings
  		a = ['dog','cat', 'child']
  		ParallelMergeSort.MergeSort(10, a)
		b = ['cat','child','dog',]
		assert_equal(b,a)
  	end
	
	def atest_basic_identical_numbers
  		a = [1, 1, 1]
  		ParallelMergeSort.MergeSort(10, a)
		b = [1, 1, 1]
		assert_equal(b,a)
  	end
	
  	def atest_basic_large_numbers
  		a = [123456789, 987654321, -123456789]
  		ParallelMergeSort.MergeSort(10, a)
		b = [-123456789, 123456789, 987654321]
		assert_equal(b,a)
  	end
	
	def atest_many_sorted_numbers
  		a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  		ParallelMergeSort.MergeSort(10, a)
		b = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		assert_equal(b,a)
  	end
	
	def atest_many_unsorted_numbers
  		a = [5, 7, 9, 0, 2, 4, 6, 10, 8, 3, 1]
  		ParallelMergeSort.MergeSort(10, a)
		b = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		assert_equal(b,a)
  	end
	
	def atest_many_numbers_with_duplicates
  		a = [10, 4, 2, 4, 1, 7, 5, 8, 9, 9, 1]
  		ParallelMergeSort.MergeSort(10, a)
		b = [1, 1, 2, 4, 4, 5, 7, 8, 9, 9, 10]
		assert_equal(b,a)
  	end
end