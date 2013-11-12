# Driver file for assignment 3.
# Group 4 Members:
# Jason Morawski
# Chris Beckett
# Tyler Schneider
# Clinton Wong

require './parallel_merge_sort'
require 'test/unit'

a = [2, 3, 1, 4, 8, 10, 6]
newA = ParallelMergeSort.Sort(10, a)
puts "Began with #{a}"
puts "Sorted: #{newA}"
puts "-----------"

# Example of Timeout:
puts "Example of a timeout:"
a = [2, 3, 1, 4, 8, 10, 6]
newA = ParallelMergeSort.Sort(0.0000001, a)
