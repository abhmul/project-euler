require 'benchmark'

def divisors(n) #finds all proper divisors for a number
    divisorArr = [1]
    last = Math.sqrt(n).floor
    (last-1).times { |append| divisorArr += [(append+2), n/(append+2)] if n%(append+2)==0}
    divisorArr.uniq
end

def d(n) #sums up all of the proper divisors !!NEEDS divisors(n)!!
    divisorArr = divisors(n)
    divisorArr.inject(:+)
end

def amicable?(n1, n2)
    d(n1)==n2 && d(n2)==n1 && n1!=n2
end

def amicableUnder(n)
    amicable = Array.new
    repeat = Array.new
    (2...n).collect { |amic|
        d = d(amic)
        next if amicable.include?(amic)
        if amicable?(amic, d)
            amicable += [amic, d]
        end}
    amicable
end

def amicableUnder2(n)
    d = (2...n).collect { |i| d(i)}
    amicable = Array.new
    (n-2).times { |amic| amicable << amic+2 if amicable?(amic+2, d[amic])}
    amicable
end


Benchmark.bm do |x|
  x.report("amicableUnder: ") { puts amicableUnder(50000).inject(:+) }
  x.report("amicableUnder2: ") { puts amicableUnder2(50000).inject(:+) }
end
    