# Part 2A: Rock-Paper-Scissors
# Write a method that simulates RPS. An RPS game is one list 
# composed of two other lists, one for each player, with their 
# name and respective move ("R", "P" or "S").
# Returns the winning player's array
# If the amount of players != 2, raise WrongNumberOfPlayersError
# If the move is invalid, raise NoSuchStrategyError
# If there is a tie, the first player is the winner

class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end

def rps_game_winner(game)
    raise WrongNumberOfPlayersError unless game.length == 2
    raise NoSuchStrategyError unless game[0].length == 2
    raise NoSuchStrategyError unless game[1].length == 2
    
    p1 = game[0][1]
    p2 = game[1][1]

    raise NoSuchStrategyError unless p1.length == 1 and p2.length == 1
    raise NoSuchStrategyError unless p1.match?(/[RPS]/) and p2.match?(/[RPS]/) 
    
    if  (p1 == "R" and p2 == "P") or 
        (p1 == "P" and p2 == "S") or 
        (p1 == "S" and p2 == "R") then
        return game[1]
    end
    return game[0]
end

#########################

def test_case(game, res)
    tres = rps_game_winner(game)
    if tres != res 
        return 'Failed! "' + game.to_s() + '"'
    end
    return "Passed!"
rescue WrongNumberOfPlayersError
    if res == WrongNumberOfPlayersError
        return "Passed!"
    end
    return 'Failed! "' + game.to_s() + '"'
rescue NoSuchStrategyError
    if res == NoSuchStrategyError
        return "Passed!"
    end
    return 'Failed! "' + game.to_s() + '"'
end

puts "Testing..."
puts test_case([], WrongNumberOfPlayersError)
puts test_case([[],[]], NoSuchStrategyError)
puts test_case([["John", "P"], ["Doe", "R"]], ["John", "P"])
puts test_case([["Jane", "S"], ["Roe", "R"]], ["Roe", "R"])
puts test_case([["Jack", "S"], ["Sho", "S"]], ["Jack", "S"])
puts test_case([["Name", "R"], ["", "P"]], ["", "P"])
puts test_case([["Name", "R"], ["Dummy", "G"]], NoSuchStrategyError)
puts test_case([["Name", "R"], ["Smartie", "Paper"]], NoSuchStrategyError)
puts test_case([["Jane", "S"], ["Roe", "R"], ["Foo", "P"]], WrongNumberOfPlayersError)
puts test_case([["Random", "R"], ["Number", "N"], ["Generator", "G"]], WrongNumberOfPlayersError)
puts test_case([["Alone", "R"]], WrongNumberOfPlayersError)