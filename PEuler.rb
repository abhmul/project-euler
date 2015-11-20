module PEuler

	#sums all elements in an array
	def self.sum(arr)
		arr.inject(:+)
	end

	#sums all positive integers upto 'n' inclusive
	def self.sum_n(n)
		n*(n+1)/2
	end

	#Sums all of the digits of a number
	def self.sum_digits(num)
    	str = num.to_s
    	array = str.split("")
    	array1 = array.map(&:to_i)
    	sum(array1)
	end

	#Multiplies a digit by some power of 10 so it is just larger than n
	def self.power_greater(n, dig)
    	starter_div = dig
    	starter_div *=10 until starter_div>n
    	starter_div
	end

	#FRACTIONS

	#Calculates the number of repeating digits in the decimal for 1/n
	def self.repeat(n)
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
        	contain = rem_arr[0...-1].index(rem_arr[-1])
        	break if contain!=nil
    	end
    	return rem_arr.length-contain-1
	end

	#Finds the n of fraction 1/n with the longest repeating decimal with n < max
	def self.longest_repeat(max)
    	(2...max).inject(0) { |greatest, n| repeat(n)>greatest ? greatest = n : greatest = greatest}
	end

	#PROBABILITY

	#Calculates factorial
	def self.factorial(num)
    	(1..num).inject(1, :*)
	end

	#Finds the number in the lexicographic sequence for a sequence of digits from 0 upto (exclusive) 'digit_max'
	def self.lexicograph(digit_max, n)
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

	#LATTICES

	#Calculates the number of possible paths from top left to bottom right of a size x size lattice
	def self.paths(size)
    	factorial(2*size)/(factorial(size)*factorial(size))
	end


	#PRIME NUMBER METHODS

	#Tests if a number is prime
	def self.is_prime(n)
		middle = Math.sqrt(n).to_i
    	divisors = (2..middle)
    	divisors.collect { |d| return false if n%d==0}
    	true
	end

	#Finds all prime numbers in a given Array with a max value 'ends'
	def self.primefind(prime_arr,ends)
    	middle = (Math.sqrt(ends)+1).to_i
    	divisors = prime_arr.select { |m| m<middle}
    	divisors.collect { |m| prime_arr = prime_arr.reject {|i| i>(m**2-1) && i%m==0}}
    	prime_arr
	end

	#Returns an array of all prime numbers under 'ends'
	def self.prime_list(ends)
    	primefind(Array(2...ends),ends)
	end

	#sums all prime numbers less than 'ends'
	def self.prime_summation(ends)
		sum(prime_list(ends))
	end

	#FIBONACCI METHODS

	#Calculates nth fibbonacci number
	def self.fib(n, cache = {})
  		return n if n == 0 || n == 1
  		cache[n] ||= fib(n-1, cache) + fib(n-2, cache)
	end

	#Returns index of fibbonacci number more or equal 'digits'
	def self.fib_digits(digits)
    	n = 1
    	n+=1 until fib(n).to_s.length >=digits
    	n
	end

	#PROPER DIVISORS AND FACTORS

	#First 3 methods could be Rubified

	#Calculates the lower middle factor of a number
	def self.middle_factor(num)
    	middle = (Math.sqrt(num)).to_i
    	until num%middle == 0
	        middle -=1
    	end
    	middle
	end

	#Counts the number of factors of a number
	def self.factor_count(num)
	    count = 4 #the two middle factors and 1 and the number
    	middle = middle_factor(num)
    	count = 3 if middle == Math.sqrt(num)
    	if middle>2
	        numbers = Array.new(middle-2) {|i| i+2}
        	#puts print numbers
        	numbers.each { |i| count+=2 if num%i==0}
    	end
    	count
	end

	#Finds the first triangular number (sum of natural numbers), starting with 'start' to have over 'count' factors
	def triangular_factors_count(start, count)
	    tri_start = start*(start+1)/2
	    adder = 1
	    until factor_count(tri_start)>count
        	tri_start+=(start+adder)
        	adder+=1
    	end
    	tri_start
	end

	#finds all proper divisors for a number
	def self.divisors(n) 
    	divisorArr = [1]
    	last = Math.sqrt(n).floor
    	(last-1).times { |append| divisorArr += [(append+2), n/(append+2)] if n%(append+2)==0}
    	divisorArr.uniq
	end

	#Sums up all of the proper divisors of a number
	def self.d(n)
    	sum(divisors(n))
	end

	#Finds all abundant numbers below 'max'
	def self.abundant_nums(max)
		abundants = (12...max).collect {|num| num if d(num)>num}
		abundants.compact
	end

	#Finds all non-abundant sums below 'max'
	def self.non_abundant_sums(max)
		abundants = abundant_nums(max)
		non_abundant_adds = Array(1...max)
		abundants.each do |num_add|
			abundants.each do |num|
				num+num_add>=max ? break : non_abundant_adds[num+num_add-1] = nil
			end
		end
		non_abundant_adds.compact
	end

	#Tests if two numbers are amicable
	def self.amicable?(n1, n2)
    	d(n1)==n2 && d(n2)==n1 && n1!=n2
	end

	#Finds all amicable numbers under n
	def self.amicableUnder(n)
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

	#Different implementation of amicableunder(n)
	def self.amicableUnder2(n)
    	d = (2...n).collect { |i| d(i)}
    	amicable = Array.new
    	(n-2).times { |amic| amicable << amic+2 if amicable?(amic+2, d[amic])}
    	amicable
	end

	#PYTHAGOREAN TRIANGLE MATH
	#!!!Could use some Rubifying!!!

	#Finds the Pythagorean Triple that adds up to the input
	def self.pythagorean_triple(sum)
    	addarr = []
    	a = 3
    	b= 1
    	c=Math.sqrt(a**2+b**2)
    	until a+b+c==sum
	        b+=1
        	if a+b+c>sum
	            a+=1
            	b=1
        	end
        	c=Math.sqrt(a**2+b**2)
    	end
    	{:a => a, :b => b, :c => c}
	end

	#COLLATZ SEQUENCES

	#Calculates the number of steps a number takes to reach 1 in a Collatz sequence
	def self.collatz(num)
    	steps = 0
    	until num==1 do
	        if num%2==0
            	num = num/2
        	else
	            num= 3*num+1
        	steps+=1
        	end
    	end
    	steps
	end

	#Finds the number less than 'max' that generates the longest Collatz sequence
	def self.longest_collatz(max)
    	step_count = 0
    	longest = 0
    	(max-2).times do |testnum|
	        count = collatz(testnum+1)
        	if count>step_count
	            step_count = count
            	longest = testnum+1
        	end
    	end
    	return longest, step_count
	end

	#NUMBER TO WORD

	#!!!The switch method works but you should've used a Hash instead!!!

	#Converts a any digit or number that does not follow a word pattern to its English form(helper function)
	def self.convert_dig_s(num)
    	case num
    	when 1
	        return "one"
	    when 2
        	return 'two'
    	when 3
	        return 'three'
	    when 4
        	return 'four'
    	when 5
	        return 'five'
	    when 6
        	return 'six'
    	when 7
	        return 'seven'
	    when 8
        	return 'eight'
    	when 9
	        return 'nine'
	    when 10
        	return 'ten'
    	when 11	
        	return 'eleven'
    	when 12
	        return 'twelve'
	    when 13
        	return 'thirteen'
    	when 15
	        return 'fifteen'
	    when 18
    	    return 'eighteen'
    	when 20
	        return 'twenty'
	    when 30
        	return 'thirty'
    	when 40
	        return 'forty'
	    when 50
        	return 'fifty'
    	when 60
	        return 'sixty'
	    when 70
        	return 'seventy'
    	when 80
	        return 'eighty'
	    when 90
        	return 'ninety'
    	else
	        return ''
	    end
	end

	#Converts most teen numbers (helper function)
	def self.convert_teen_s(num)
	    return convert_dig_s(num-10)+"teen"
	end

	#Converts a 2 digit number 20 or greater to a word (helper function)
	def self.convert_ten_s(num)
	    tens = num/10*10
	    convert_dig_s(tens)+convert_dig_s(num-tens)
	end

	#Converts a 3 digit number to a word (helper function)
	def self.convert_hund_s(num)
	    hund= num/100
	    ten = num-hund*100
	    num_s = convert_dig_s(hund) + "hundred"
	    num_s+= "and" + convert_num_s(ten) if ten!=0
	    num_s
	end

	#Converts a number to a word
	def self.convert_num_s(num)
	    if num<=13 || num==15 || num==18
        	return convert_dig_s(num)
    	elsif num>13 && num<20
	        return convert_teen_s(num)
	    elsif num>19 && num<100
        	return convert_ten_s(num)
    	elsif num>=100
	        return convert_hund_s(num)
	    end
	end

	#Counts the number of letters of all the word forms of numbers below 'max'
	#Can still be Rubified
	def self.let_num_counter(max)
	    sum= 0
	    (max-1).times do |num|
        	sum+=(convert_num_s(num+1)).length
        	puts convert_num_s(num+1)
    	end
    	sum
	end

	#ALPHABET MATH

	#All letters in alphabetical order
	def self.letters
		("A".."Z").to_a
	end

	#Assigns each letter a score according to its alphabetical order
	def self.scores
		Hash[letters.zip(1..26)]
	end

	#Takes a name and scores based on a 'scores' hash
	def self.alphascore(name, scores)
		nameArr= name.split(//)
		score = sum(nameArr.collect {|letter| scores[letter]})
	end

	#Calculates score of a list of names by summing each names alphascore multiplied by position in list
	def self.totalscore(names, scores)
		total = sum((1..names.length).collect {|idx| idx*alphascore(names[idx-1], scores) })
		total
	end

	#QUADRATIC FUNCTION PRIME COUNTER
	# Form: n^2 + an + b
	# b must be a positive prime number
	# The function must never be negative
	# => a^2 - 4b <=0
	# a^2 <= 4b
	# a <= 2sqrt(b) or a>= -2sqrt(b)
	# a != 0

	#Finds all possible b-values for n^2 + an + b for prime number generation
	def self.possible_b(max)
    	prime_list(max)
	end
	
	#Finds all possible a-values given a b-value for n^2 + an + b for prime number generation
	def self.possible_a(b)
    	base = (2*Math.sqrt(b)).to_i
    	pos_a = Array(1..base)
    	neg_a = Array(-1*base..-1)
    	neg_a+pos_a
	end

	#Counts the number of consecutive prime numbers n^2 + an + b with n starting at 0
	def self.quad_prime_count(a, b)
    	n=0
    	n+=1 while is_prime(n**2+a*n+b)
    	n
	end

	#Calculates a and b for the quadratic function n^2 + an + b that generates
	#the most number of consecutive prime numbers with n starting at 0
	#Returns a Hash of the number of prime numbers, a, and b
	def self.best_a_b(max)
    	poss_b = possible_b(max)
    	info = { :prime_count => 0, :a => 0, :b => 0}
    	poss_b.each do |b|
        	possible_a(b).collect { |a| (qpc =quad_prime_count(a, b)) > info[:prime_count] ? info = {:prime_count => qpc, :a => a, :b => b} : info = info}
    	end
    	info
	end

	#Multiplies the best a and b values
	def self.mult_ab(max)
    	info = best_a_b(max)
    	info[:a]*info[:b]
	end


end
