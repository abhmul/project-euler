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

def abundant_nums(max)
	abundants = (12...max).collect {|num| num if d(num)>num}
	abundants.compact
end

def non_abundant_sums(max)
	abundants = abundant_nums(max)
	non_abundant_adds = Array(1...max)
	abundants.each do |num_add|
		abundants.each do |num|
			num+num_add>=max ? break : non_abundant_adds[num+num_add-1] = nil
		end
	end
	non_abundant_adds.compact
end

#puts print abundant_nums(31)
#puts print Array(1...31)
puts print non_abundant_sums(28124).inject(:+)
