def fib(n, cache = {})
  if n == 0 || n == 1
    return n
  end
  cache[n] ||= fib(n-1, cache) + fib(n-2, cache)
end

def fib_digits(digits)
    n = 1
    n+=1 until fib(n).to_s.length >=digits
    n
end

puts fib_digits(1000)