# CAN BE MADE MORE EFFICIENT

require 'benchmark'

def power_greater(n, dig)
    starter_div = dig
    starter_div *=10 until starter_div>n
    starter_div
end

# puts power_greater(10, 1)

def repeat(n)
    starter_div = power_greater(n, 1)
    rem1 = starter_div%n
    rem_arr = [rem1]
    ind =0
    contain = 0
    loop do
        cur = rem_arr[-1]
        return 0 if cur==0
        greater = power_greater(n, cur)
        (Math.log10(greater/cur)-1).to_i.times {rem_arr << 0}
        rem_arr << greater%n        
        # puts print rem_arr
        # break if gets.chomp=='break'
        contain = rem_arr[0...-1].index(rem_arr[-1])
        # puts contain
        break if contain!=nil
    end
    return rem_arr.length-contain-1
end

def longest_repeat(max)
    (2...max).inject(0) { |greatest, n| repeat(n)>greatest ? greatest = n : greatest = greatest}
end
Benchmark.bm { |x| x.report {puts longest_repeat(1000)}}