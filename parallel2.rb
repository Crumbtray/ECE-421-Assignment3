module ParallelMergeSort

	def self.MergeSort(a)
		puts "MergeSort"
		if a.length <= 1
			return a
		else
			midpoint = a.length / 2
			t1 = Thread.new do
				self.MergeSort(a.take(midpoint))
			end
			t2 = Thread.new do
				self.MergeSort(a.drop(midpoint))
			end

			t1.join
			t2.join
			
			left = t1.value
			right = t2.value

			puts "Right is: #{right}"
			returnval = self.PMerge(left, right)
			puts "RETURN VAL: #{returnval}"
			return returnval
		end
	end

	def self.PMerge(a, b)
		result = Array.new
		puts "PMerge with #{a.to_s} and #{b.to_s}"
		# The idea here is to concatenate a with b, but finding the right place to merge by using binary search.
		if(b.length > a.length)
			self.PMerge(b, a)
		elsif(b.empty?)
			return a
		elsif(a.empty?)
			return b
		elsif(a.length == 1 and b.length == 1)
			if (a.first <= b.first)
				result.push(a.first).push(b.first)
				return result
			else
				result.push(b.first).push(a.first)
				return result
			end
		else
			# Split A and B by finding J through binary search.
			midpoint = a.length / 2
			j = self.MergeBinarySearch(b, a[midpoint])
			puts "J: #{j}"
			
			newa = self.PMerge(a.take(midpoint), b.take(j))
			newb = self.PMerge(a.drop(midpoint), b.drop(j))

			puts "NEWA: #{newa}"
			puts "NEWB: #{newb}"
			# Crude filler right now.

			return newa + newb
		end
	end

	# Special kind of binary search.
	# We're looking for the index J such that
	# B[J] < value < B[J+1]
	def self.MergeBinarySearch(b, value)
		puts "Looking for #{value} within #{b.to_s}"
		imin = 0
		imax = b.length - 1

		while (imax >= imin)
			imid = (imax + imin) / 2
			if(b[imid] < value)
				imin = imid + 1
			elsif (b[imid] > value)
				imax = imid - 1
			else
				return imid
			end
		end

		if(b[imax] < value)
			return imid
		end
	end

end