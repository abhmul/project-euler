
#arr = []
#arr.push(20,13)
#puts print arr

def number_list(start, ends)
    number_arr = Array.new(ends-1) { |i| i+=start}
    number_arr
end

#n = number_list(2,10)
#puts print n
#puts print n[1]

def prime_list(ends)
    prime_arr = number_list(2,ends)

    #puts middle
    primefind(prime_arr,ends)
end
    
def primefind(prime_arr,ends)
    middle = (Math.sqrt(ends)+1).to_i
    divisors = prime_arr.select { |m| m<middle}
    #puts divisors
    divisors.each do |m|
        #if m<middle
        prime_arr = prime_arr.reject {|i| i>(m**2-1) and i%m==0}
        #puts prime_arr
        #prime_arr.each do |i>(m*2-1)|
                #if i>(m*2-1) and i%m==0
                    #prime_arr.delete(i)
                #end
        #end
        #end
    end
    prime_arr
end


def prime_numbers(n)
    prime_arr = prime_list(n)
    while prime_arr.length < n do
        prime_arr.concat(number_list(prime_arr[-1]+1, n*2))
        primefind(prime_arr, prime_arr[-1])
    end
    #puts print prime_arr
    return prime_arr[n-1]
end   

def list_summation(array)
    sum = 0
    array.each do |i|
        sum+=i
    end
    sum
end

def prime_summation_repeat(ends)
    (ends+1).times do |i|
        primes = prime_list(i+2)
        puts list_summation(primes)
    end
end

def prime_summation(ends)
    list_summation(prime_list(ends))
end


puts prime_summation(2000000)