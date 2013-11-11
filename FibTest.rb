module FibTest
Thread.abort_on_exception = false
	def self.Fib(n)
		if (n < 2)
			return n
		else
			x = Thread.new do
				self.Fibonacci(n - 1)
			end
			y = Thread.new do
				self.Fibonacci(n - 2)
			end
			x.join
			y.join
			return x.value + y.value
		end

	end

end