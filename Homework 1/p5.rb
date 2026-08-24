# Part 5: advanced OOP, metaprogramming, open classes and duck typing
# Define a method attr_accessor_with_history that provides the
# same functionality as attr_accessor but also tracks every attribute
# it has ever had. Skeleton provided.

class Class
    def attr_accessor_with_history(attr_name)
        attr_name = attr_name.to_s          # make sure it's a string
        attr_reader attr_name               # create the attr getter
        class_eval %Q{
        def #{attr_name}_history
            @#{attr_name}_history ||= [nil]
        end

        def #{attr_name}=(new_value)
            (@#{attr_name}_history ||= [nil]).push(new_value)
            @#{attr_name} = new_value
        end
        }
    end
end

class Foo
    attr_accessor_with_history :bar
end

#########################

def test_aawh_1()
    f = Foo.new
    res = f.bar_history
    if f.bar != nil then return "Failed! Bad attr assignment" end
    if res != [nil] then return "Failed! No history attr_history != [nil]" end
    return "Passed!"
end

def test_aawh_2()
    f = Foo.new
    f.bar = 1
    f.bar = 2
    res = f.bar_history
    if f.bar != 2 then return "Failed! Bad attr assignment" end
    if res != [nil,1,2] then return "Failed! Bad history" end
    return "Passed!"
end

def test_aawh_3()
    f = Foo.new
    f.bar = 1
    f.bar = 'string'
    f.bar = nil
    res = f.bar_history
    if f.bar != nil then return "Failed! Bad attr assignment" end
    if res != [nil,1,'string',nil] then return "Failed! Bad history" end
    return "Passed!"
end

def test_aawh_4()
    f = Foo.new
    f.bar = 42
    f.bar = 42
    f.bar = 42
    res = f.bar_history
    if f.bar != 42 then return "Failed! Bad attr assignment" end
    if res != [nil,42,42,42] then return "Failed! Same value, different attributions not on history" end
    return "Passed!"
end

def test_aawh_5()
    f = Foo.new
    f.bar = 'independance!'
    f = Foo.new
    f.bar = 'yolo'
    res = f.bar_history
    if f.bar != 'yolo' then return "Failed! Bad attr assignment" end
    if res != [nil,'yolo'] then return "Failed! Instance class is not properly initialized" end
    return "Passed!"
end

puts test_aawh_1()
puts test_aawh_2()
puts test_aawh_3()
puts test_aawh_4()
puts test_aawh_5()