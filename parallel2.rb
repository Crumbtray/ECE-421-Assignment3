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
			

			return self.SeqMerge(left, right)
		end
	end

	def self.PMerge(a, b)
		puts "PMerge with #{a.to_s} and #{b.to_s}"
	end
end