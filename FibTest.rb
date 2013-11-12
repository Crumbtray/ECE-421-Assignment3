module FibTest
	def self.Fib(n)
		begin

			if (n < 2)
				return n
			else
				Thread.abort_on_exception = true
				x = Thread.new do
					self.Fib(n - 1)
				end
				y = Thread.new do
					self.Fib(n - 2)
				end
				x.join
				y.join
				return x.value + y.value
			end
		rescue ThreadError
			Thread.list.each {|t| t.kill}
		end
	end

end