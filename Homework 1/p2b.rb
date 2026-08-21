# Part 2A: Rock-Paper-Scissors
# Write a method that simulates an RPS tournament.
# Returns the winning player's array
# If there are problems with the tournament structure
# raise BadTournamentError. That is, != 2^n players,

class WrongNumberOfPlayersError < StandardError ; end
class NoSuchStrategyError < StandardError ; end
class BadTournamentError < StandardError ; end

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

def rps_tournament_winner(tourney)
    raise WrongNumberOfPlayersError unless tourney.length == 2
    raise BadTournamentError unless tourney[0].class == tourney[1].class
    raise BadTournamentError unless tourney[0].class == Array
    raise BadTournamentError unless tourney[0].length * tourney[1].length != 0
    raise BadTournamentError unless tourney[0][0].class == tourney[1][0].class

    p1 = ""
    p2 = ""
    if tourney[0][0].class == Array
        p1 = rps_tournament_winner(tourney[0])
        p2 = rps_tournament_winner(tourney[1])
    elsif tourney[0][0].class == String
        return rps_game_winner(tourney)
    else
        raise BadTournamentError
    end

    return rps_game_winner([] << p1 << p2)
end


#########################

def test_case(game, res)
    tres = rps_tournament_winner(game)
    if tres != res
        return 'Failed! "' + game.to_s() + '"'
    end
    return "Passed!"
rescue => exception
    if res == exception.class
        return "Passed!"
    end
    return 'Failed! "' + game.to_s() + '"'
end


puts "Testing..."

# tests for the simple 2 player games should still work.
puts test_case([], WrongNumberOfPlayersError)
puts test_case([["John", "P"], ["Doe", "R"]], ["John", "P"])
puts test_case([["Jane", "S"], ["Roe", "R"]], ["Roe", "R"])
puts test_case([["Jack", "S"], ["Sho", "S"]], ["Jack", "S"])
puts test_case([["Name", "R"], ["", "P"]], ["", "P"])
puts test_case([["Name", "R"], ["Dummy", "G"]], NoSuchStrategyError)
puts test_case([["Name", "R"], ["Smartie", "Paper"]], NoSuchStrategyError)
puts test_case([["Jane", "S"], ["Roe", "R"], ["Foo", "P"]], WrongNumberOfPlayersError)
puts test_case([["Random", "R"], ["Number", "N"], ["Generator", "G"]], WrongNumberOfPlayersError)
puts test_case([["Alone", "R"]], WrongNumberOfPlayersError)

# tournaments
puts test_case([[],[]], BadTournamentError)
puts test_case(
    [
        [
            ["Ana", "P"],
            ["Brad", "R"]
        ],
        [
            ["Chris", "S"],
            ["David", "R"]
        ]
    ],
    ["Ana", "P"]
)
puts test_case(
    [
        [
            ["Ana", "A"],
            ["Brad", "B"]
        ],
        [
            ["Chris", "C"],
            ["David", "D"]
        ]
    ],
    NoSuchStrategyError
)
puts test_case(
    [
        [
            ["Ana", "A"],
            ["Brad", "B"]
        ],
        ["Chris", "C"]
    ],
    BadTournamentError
)
puts test_case(
    [
        [
            [ 
                ["Kristen", "P"], 
                ["Dave", "S"] 
            ],
            [ 
                ["Richard", "R"], 
                ["Michael", "S"] 
            ]
        ],
        [
            [ 
                ["Allen", "S"], 
                ["Omer", "P"] 
            ],
            [ 
                ["David E.", "R"], 
                ["Richard X.", "P"] 
            ]
        ]
    ],
    ["Richard", "R"]
)