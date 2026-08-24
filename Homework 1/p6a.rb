# Part 6A: advanced OOP, metaprogramming, open classes and duck typing, continued
# Extend the currency-conversion method so you can write:
#   5.dollars.in(:euros)
#   10.euros.in(:rupees)
# To be supported: 'dollars', 'euros', 'rupees', 'yen':
#   dollars = rupeee x 0.019
#   dollars = yen x 0.013
#   dollars = euro x 1.292
# Both singular and plural should be acceptable ('dollar'/'dollars')
# Skeleton provided.

class NoSuchCurrency < StandardError ; end

class Numeric
    @@currencies = {'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019, 'dollar' => 1}

    def in(currency)
        # this assumes a dollar -> currency conversion
        singular_currency = currency.to_s.gsub(/s$/, '')
        if @@currencies.has_key?(singular_currency)
            return self / @@currencies[singular_currency]
        end
        raise NoSuchCurrency
    end

    def method_missing(method_id, *args, &block)  # capture all args in case have to call super
        singular_currency = method_id.to_s.gsub(/s$/, '')
        if @@currencies.has_key?(singular_currency)
            self * @@currencies[singular_currency]
        else
            super
        end
    end
end

#########################

def test_curr_dd()
    if 10.in(:dollar) != 10 or 
        10.in(:dollars) != 10
        return "Failed! dollar -> dollar"
    end
    "Passed!"
end

def test_curr_dy()
    if 20.in(:yen) != (20/0.013) or 
        20.in(:yens) != (20/0.013)
        return "Failed! dollar -> yen"
    end
    "Passed!"
end

def test_curr_de()
    if 0.5.in(:euro) != (0.5/1.292) or 
        0.5.in(:euros) != (0.5/1.292)
        return "Failed! dollar -> euro"
    end
    "Passed!"
end

def test_curr_dr()
    if 100.in(:rupee) != (100/0.019) or 
        100.in(:rupees) != (100/0.019)
        return "Failed! dollar -> rupee"
    end
    "Passed!"
end

def test_curr_dde()
    if 5.dollar.in(:euro) != (5/1.292) or 
        5.dollars.in(:euros) != (5/1.292)
        return "Failed! dollar -> dollar -> euro"
    end
    "Passed!"
end

def test_curr_der()
    if 10.euro.in(:rupee) != (10*1.292/0.019) or 
        10.euros.in(:rupees) != (10*1.292/0.019)
        return "Failed! dollar -> euro -> rupee"
    end
    "Passed!"
end

def test_curr_badcurr()
    real = 2.in(:real)
    raise StandardError
rescue => exception
    if exception.class != NoSuchCurrency
        return "Failed! real didn't raise NoSuchCurrency"
    end
    "Passed!"
end

puts test_curr_dd()
puts test_curr_dy()
puts test_curr_de()
puts test_curr_dr()
puts test_curr_dde()
puts test_curr_der()
puts test_curr_badcurr()