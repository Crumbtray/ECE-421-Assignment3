require 'test/unit'
require './parallel_merge_sort'

class SortTests < Test::Unit::TestCase

	# Test for:
	# - Invalid arguments
	# - Really Small Duration (All threads should be dead)
	# - Different sizes of input ()

	def test_argument_not_array
		assert_raise ArgumentError do
			a = "BOOBOO"
			newA = ParallelMergeSort.Sort(10, a)
		end
  	end
	
	def test_arguments_not_comparable
		assert_raise ArgumentError do
			a = [1,'a']
			newA = ParallelMergeSort.Sort(10, a)
		end
  	end
	
	def atest_duration_exceeded
  		a = [2, 3, 1]
		duration = 0.001
		start = Time.now
  		newA = ParallelMergeSort.Sort(duration, a)
		assert_in_delta(start + duration, Time.now, 1);
		
  	end
	
	def test_two_sorted_numbers
  		a = [1, 2]
  		newA = ParallelMergeSort.Sort(10, a)
		b = [1, 2]
		assert_equal(b, newA)
  	end
	
	def test_two_reverse_numbers
  		a = [2, 1]
  		newA = ParallelMergeSort.Sort(10, a)
		b = [1, 2]
		assert_equal(b, newA)
  	end

  	def test_basic_sorted_numbers
  		a = [1, 2, 3]
  		newA = ParallelMergeSort.Sort(10, a)
		b = [1, 2, 3]
		assert_equal(b,newA)
  	end
	
	def test_basic_unsorted_numbers
  		a = [2, 3, 1]
  		newA = ParallelMergeSort.Sort(10, a)
		b = [1, 2, 3]
		assert_equal(b,newA)
  	end
	
	def test_basic_unsorted_strings
  		a = ['dog','cat', 'child']
  		newA = ParallelMergeSort.Sort(10, a)
		b = ['cat','child','dog',]
		assert_equal(b,newA)
  	end
	
	def test_basic_identical_numbers
  		a = [1, 1, 1]
  		newA = ParallelMergeSort.Sort(10, a)
		b = [1, 1, 1]
		assert_equal(b,newA)
  	end
	
  	def test_basic_large_numbers
  		a = [123456789, 987654321, -123456789]
  		newA = ParallelMergeSort.Sort(10, a)
		b = [-123456789, 123456789, 987654321]
		assert_equal(b,newA)
  	end
	
	def test_many_sorted_numbers
  		a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  		newA = ParallelMergeSort.Sort(10, a)
		b = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		assert_equal(b,newA)
  	end
	
	def test_many_unsorted_numbers
  		a = [5, 7, 9, 0, 2, 4, 6, 10, 8, 3, 1]
  		newA = ParallelMergeSort.Sort(10, a)
		b = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
		assert_equal(b,newA)
  	end
	
	def test_many_numbers_with_duplicates
  		a = [10, 4, 2, 4, 1, 7, 5, 8, 9, 9, 1]
  		newA = ParallelMergeSort.Sort(10, a)
		b = [1, 1, 2, 4, 4, 5, 7, 8, 9, 9, 10]
		assert_equal(b, newA)
  	end
  	
  def test_many_random_numbers
    srand(5)
    a = (0..300).map{rand(-1000..1000)}
    newA = ParallelMergeSort.Sort(2, a)
    b = a.sort
    assert_equal(b,newA)
    end
end