# Part 4A: Basic OOP
# Create a class Dessert with getters and setters for name and calories
# Define healthy? which is true if calories < 200
# Definte delicious? which is always true

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
puts test_nondestructive(Dessert.new('candy', 30), [:healthy?], true)
puts test_nondestructive(Dessert.new('candy', 30), [:delicious?], true)
puts test_nondestructive(Dessert.new('whole cake', 2500), [:healthy?], false)
puts test_nondestructive(Dessert.new('whole cake', 2500), [:delicious?], true)
puts test_nondestructive(Dessert.new('strawberry', 20), [:name], 'strawberry')
puts test_nondestructive(Dessert.new('goiabada', 700), [:calories], 700)
puts test_nondestructive(Dessert.new('goiabada', 700), [:==, Dessert.new('goiabada light', 450)], false)
puts test_nondestructive(Dessert.new('lollipop', 250), [:==, Dessert.new('lollipop', 250)], true)
puts test_destructive(Dessert.new('goiabada light', 700), [:set_calories, 450], Dessert.new('goiabada light', 450), 450)
puts test_destructive(Dessert.new('popsicle', 100), [:set_name, 'cooled water'], Dessert.new('cooled water', 100), 'cooled water')
puts test_destructive(Dessert.new('popsicle', 100), [:set_name, ''], Dessert.new('', 100), '')
puts test_destructive(Dessert.new('popsicle', 100), [:set_calories, 0], Dessert.new('popsicle', 0), 0)
