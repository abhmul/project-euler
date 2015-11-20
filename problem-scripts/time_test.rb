require 'benchmark'

hsh = {:A => 65}
hsh2 = {"A" => 65}
n=100000000
def sum(n, times)
    sum = 0
    times.times {sum+=n}
    sum
end

Benchmark.bm(10000) do |x|
  x.report("normal:") { puts sum("A".ord, n) }
  x.report("basic:") { puts sum(hsh["A".to_sym], n)}
  x.report("regular:") { puts sum(hsh2["A"], n)}
end