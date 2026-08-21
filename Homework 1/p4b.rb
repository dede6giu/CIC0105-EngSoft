# Part 4A: Basic OOP
# Create the class JellyBean that extends from Dessert.
# JellyBean has a flavor instance variable.
# delicious? returns false if the flavor is "black licorice".

class Dessert
    def initialize(new_name, new_calories)
        @name = new_name
        @calories = new_calories
    end

    def name
        @name
    end

    def calories
        @calories
    end

    def set_name(new_name)
        @name = new_name
    end

    def set_calories(new_calories)
        @calories = new_calories
    end

    def healthy?()
        @calories < 200
    end

    def delicious?()
        true
    end

    def ==(b)
        (@calories == b.calories) and (@name == b.name)
    end
end


class JellyBean < Dessert
    def initialize(name, calories, flavor)
        @name = name
        @calories = calories
        @flavor = flavor
    end

    def flavor
        @flavor
    end

    def set_flavor(new_flavor)
        @flavor = new_flavor
    end

    def delicious?
        !@flavor.match?(/black[ -]licorice/i)
    end
end



#########################

# Compares the result of calling the method
# in parcall with the expected result
def test_nondestructive(obj, parcall, res)
    tres = obj.send(*parcall)

    if tres != res 
        return 'Failed! "' + obj.to_s + '"'
    end
    return "Passed!"
end

# Compares the new object after calling the 
# method in parcall with the expected object
# and expected return result
def test_destructive(obj, parcall, exp_obj, result=nil)
    start_obj = obj
    t_res = start_obj.send(*parcall)
    
    if t_res != result or start_obj != exp_obj
        return 'Failed! "' + obj.to_s + '" "' + parcall.to_s + '"'
    end
    return "Passed!"
end

puts "Testing..."
puts test_nondestructive(JellyBean.new('iroiro', 30, 'tutti-fruti'), [:healthy?], true)
puts test_nondestructive(JellyBean.new('jumbo pack', 250, 'tutti-fruti'), [:healthy?], false)
puts test_nondestructive(JellyBean.new('jumbo pack', 250, 'tutti-fruti'), [:delicious?], true)
puts test_nondestructive(JellyBean.new('iroiro', 30, 'black licorice'), [:delicious?], false)
puts test_nondestructive(JellyBean.new('iroiro', 30, 'The mint and Black-Licorice Special'), [:delicious?], false)
puts test_nondestructive(JellyBean.new('willy', 42, 'wonka'), [:name], 'willy')
puts test_nondestructive(JellyBean.new('willy', 42, 'wonka'), [:calories], 42)
puts test_nondestructive(JellyBean.new('willy', 42, 'wonka'), [:flavor], 'wonka')
puts test_destructive(JellyBean.new('magik', 20, 'hat'), [:set_flavor, 'bnuuy'], JellyBean.new('magik', 20, 'bnuuy'), 'bnuuy')