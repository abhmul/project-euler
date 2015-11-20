require 'benchmark'

def factorial(num)
    (1..num).inject(1, :*)
end

def lexicograph(digit_max, n)
    #create permutation array; holds numbers that haven't been used
    digit_arr = Array(0...digit_max)
    #creates my lexicograph number array
    digits_n = Array.new
    #adjusts for lexicograph indexing discrepancy
    n_count = n-1
    #let's try not to mutate anything here
    digit_count = digit_max*1
    #stop once we run out of digits
    until digit_count==0
        dfact = factorial(digit_count-1)
        #this is the index in the permutation array we need
        ind = n_count / dfact
        #let's stick that number into our lexicograph number arraw
        digits_n << digit_arr[ind]
        #we gotta get rid of the digit so it won't be used again
        digit_arr.delete_at(ind)
        #lowers the lexicograph position for the leftover digits
        n_count -= (ind*dfact)
        #can't have a negative position
        n_count = 0 if n_count<0
        #decrements the digit count because we just used one
        digit_count-=1
    end
    #turns the array into an integer and returns it
    digits_n.join.to_i
end

Benchmark.bm { |x| x.report {puts lexicograph(10, 1000000)}}