require 'benchmark'
# b must be a positive prime number
# The function must never be negative
# => a^2 - 4b <=0
# a^2 <= 4b
# a <= 2sqrt(b) or a>= -2sqrt(b)
# a != 0

# finds all prime numbers under input
def prime_list(ends)
    primefind(Array(2...ends),ends)
end

# this function finds all the prime numbers in a given array
def primefind(prime_arr,ends)
    middle = (Math.sqrt(ends)+1).to_i
    divisors = prime_arr.select { |m| m<middle}
    divisors.collect { |m| prime_arr = prime_arr.reject {|i| i>(m**2-1) && i%m==0}}
    prime_arr
end

def possible_a(b)
    base = (2*Math.sqrt(b)).to_i
    pos_a = Array(1..base)
    neg_a = Array(-1*base..-1)
    neg_a+pos_a
end

def possible_b(max)
    prime_list(max)
end

def is_prime(n)
    middle = Math.sqrt(n).to_i
    divisors = (2..middle)
    divisors.collect { |d| return false if n%d==0}
    true
end

def quad_prime_count(a, b)
    n=0
    n+=1 while is_prime(n**2+a*n+b)
    n
end

def best_a_b(max)
    poss_b = possible_b(max)
    info = { :prime_count => 0, :a => 0, :b => 0}
    poss_b.each do |b|
        possible_a(b).collect { |a| (qpc =quad_prime_count(a, b)) > info[:prime_count] ? info = {:prime_count => qpc, :a => a, :b => b} : info = info}
    end
    info
end

def mult_ab(max)
    info = best_a_b(max)
    info[:a]*info[:b]
end

Benchmark.bm { |x| x.report {puts mult_ab(1000)}}

