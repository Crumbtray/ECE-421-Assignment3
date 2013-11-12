module ParallelMergeSort

	@c = Array.new

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
			if(t2.value.nil?)
				right = Array.new
			else
				right = t2.value
			end
			

			return self.PMerge(left, right)
		end
	end

	def self.PMerge(a, b)
		result = Array.new
		puts "PMerge with #{a.to_s} and #{b.to_s}"
		# The idea here is to concatenate a with b, but finding the right place to merge by using binary search.
		if(b.empty?)
			return a
		elsif(a.empty?)
			return b
		elsif(a.length == 1 and b.length == 1)
			if (a.first <= b.first)
				return result.push(a).push(b)
			else
				return result.push(b).push(a)
			end
		else
			# Split A and B by finding J through binary search.
			# Crude filler right now.
			return a.concat(b)
		end
	end
end