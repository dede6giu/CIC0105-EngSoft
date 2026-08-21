# Part 1B: fun with strings
# Given a string of input, return a hash counting the times words appear
# Keys are the string of the word, value is an integer amount
# Case doesn't matter. Ignore non-words.
# Don't use for-loops.

def count_words(str)
    val = str.downcase
    val = val.split(/\b/)
    val.each{|word| word.gsub!(/\W/, '')}
    val.delete_if{|word| word == ''}

    res_dic = {}
    val.each{|word| if res_dic.key?(word) then res_dic[word] += 1 else res_dic[word] = 1 end}

    return res_dic
end

#########################

def test_case(str, res)
    tres = count_words(str)
    if tres != res 
        return 'Failed! "' + str + '"'
    end
    return "Passed!"
end

puts "Testing..."
puts test_case("A man, a plan, a canal -- Panama", {'a'=>3,'man'=>1,'canal'=>1,'panama'=>1,'plan'=>1})
# \b considers ' as a word separator. by problem specification, the below test is correct.
# it also is "another word" in very technical terms
puts test_case("Madam, I'm Adam!", {'madam'=>1,'i'=>1,'m'=>1,'adam'=>1})
puts test_case("", {})
puts test_case("--$%&*)({", {})