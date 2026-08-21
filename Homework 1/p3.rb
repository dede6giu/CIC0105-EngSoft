# Part 3: anagrams
# Given a list of words, group them by anagram groups.
# Order doesn't matter

def combine_anagrams(words)
    groups = {}
    words.each{|wd|
        anam = wd.downcase.split('').sort.join('');
        if groups[anam] == nil then groups[anam] = [] end
        groups[anam] = groups[anam] + [wd];
    }
    groups.values
end

#########################

def test_case(inp, res)
    tres = combine_anagrams(inp)

    tres.each{|gr| gr.sort!}
    tres.sort!{|a, b| a[0] <=> b[0]}
    
    res.each{|gr| gr.sort!}
    res.sort!{|a, b| a[0] <=> b[0]}

    if tres != res
        return 'Failed! "' + inp.to_s + '"'
    end
    return "Passed!"
end

puts "Testing..."
puts test_case(
    ['cars', 'for', 'potatoes', 'racs', 'four', 'scar', 'creams', 'scream'],
    [["cars", "racs", "scar"], ["four"], ["for"], ["potatoes"], ["creams", "scream"]]    
)
puts test_case([], [])
puts test_case([''], [['']])
puts test_case(
    ['undertale', 'deltarune', 'asriel', 'chara', 'ralsei', 'toriel', 'asgore'],
    [['deltarune', 'undertale'], ['asriel', 'ralsei'], ['chara'], ['toriel'], ['asgore']]
)