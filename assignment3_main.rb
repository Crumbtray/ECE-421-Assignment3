# Driver file for assignment 3.
# Group 4 Members:
# Jason Morawski
# Chris Beckett
# Tyler Schneider
# Clinton Wong

require './parallel_merge_sort'
require 'test/unit'
include 'assert'

a = [2, 3, 1, 4, 8, 10, 6]
newA = ParallelMergeSort.Sort(10, a)
b = [1, 2, 3, 4, 6, 8, 10]
assert_equal(b,newA)

# Example of Timeout:
a = [2, 3, 1, 4, 8, 10, 6]
newA = ParallelMergeSort.Sort(0.0000001, a)
