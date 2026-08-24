# Part 6B: advanced OOP, metaprogramming, open classes and duck typing, continued
# Adapt the 1A exercise so instead of writing palindrome?("foo")
# you can write "foo".palindrome?

class String
    def palindrome?
        val = self.downcase
        val.gsub!(/\W/, '')

        val_l = val.length

        if val_l == 0
            return true
        else
            return val[0, val_l.div(2)+(val_l%2)] == (val[val_l.div(2), val_l-1]).reverse
        end
    end
end

#########################

def test_case(str, res)
    if str.palindrome? != res 
        return 'Failed! "' + str + '"'
    end
    return "Passed!"
end

puts "Testing..."
puts test_case("Madam, I'm Adam!", true)
puts test_case("A man, a plan, a canal -- Panama", true)
puts test_case("Abracadabra", false)
puts test_case("not a palindrome", false)
puts test_case("this_is_si_siht", true)
puts test_case("", true)
puts test_case("abc", false)
puts test_case("--$%&*)({", true)