module ParallelMergeSort
	def self.MergeSort(a)
		if a.length == 1
			return a
		else
			midpoint = a.length / 2
			t1 = Thread.new do
				self.MergeSort(a.take(midpoint + 1))
			end
			t2 = Thread.new do
				self.MergeSort(a.drop(midpoint + 1))
			end
			t1.join
			t2.join
			self.PMerge(t1.value, t2.value)
		end
	end
end