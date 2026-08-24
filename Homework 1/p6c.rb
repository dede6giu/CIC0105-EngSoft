# Part 6C: advanced OOP, metaprogramming, open classes and duck typing, continued
# Adapt the 6B so it can work on Enumerables
#   [1,2,3,2,1].palindrome  # => true
# Palindromes don't need to be recursive. Only the top layer needs to be.
# The solution doesn't need to make sense for hashes. It should not error, however.

module Enumerable
    def palindrome?
        val_l = self.count
        if val_l == 0 or val_l == 1
            return true
        end
        slices = [] 
        self.each_slice(val_l.div(2)) {|tuple| slices.push(tuple)}
        if val_l % 2 == 1
            slices[0] << slices[1][0]
            slices[1] += slices[2]
        end
        slices[0] == slices[1].reverse
    end
end

#########################

def test_case(str, res, check_error_only=false)
    if check_error_only
        str.palindrome?
        return "Passed!"
    end
    if str.palindrome? != res 
        return 'Failed! "' + str.to_s + '"'
    end
    return "Passed!"
rescue => exception
    return "Failed! #{exception}"
end

puts "Testing..."
puts test_case([], true)
puts test_case([1], true)
puts test_case(['test'], true)
puts test_case([1,2], false)
puts test_case([[1,2]], true)
puts test_case([1,3,3,1], true)
puts test_case([1,3,7,3,1], true)
puts test_case([1,3,7,3,100], false)
puts test_case([nil,3,3,nil], true)
puts test_case(['sock',0,0,'sock'], true)
puts test_case(['list',[1,3,3],[1,3,3],'list'], true)
puts test_case((1..4), false)
puts test_case((4..4), true)
puts test_case({:a => 'a', :b => 'banana'}, nil, true)
puts test_case({:c => 'checking', :d => 'data', :f => 'for', :e => 'errors'}, nil, true)