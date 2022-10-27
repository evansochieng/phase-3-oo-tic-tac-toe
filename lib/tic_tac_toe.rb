require "pry"

# TicTacToe class
class TicTacToe

    #initialize a new game(instance) with starting state of the board
    def initialize
        @board = Array.new(9, " ")
    end

    # Winning combinations
    WIN_COMBINATIONS = [
        [0,1,2], # Top row
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    # Helper Methods
    #display_board
    def display_board
        toprow = @board.slice(0, 3).join(" | ")
        middlerow = @board.slice(3, 6).join(" | ")
        bottomrow = @board.slice(6, @board.length()).join(" | ")

        # combine them using ----
        board_rep = " #{[toprow, middlerow, bottomrow].join(' ----------- ')} "
        puts board_rep
    end

    #input_to_index
    def input_to_index str
        str.to_i - 1 #return index where player intends to place token
    end

    #move
    def move(index, token='X')
        @board[index] = token #place the players token to the chosen index
    end

    #position_taken?
    def position_taken? index
        #check if position is free or taken
        if (@board[index] == "X" || @board[index] == "O")
            true
        else
            false
        end
    end

    #valid_move?
    def valid_move? index
        # check if position is present on the game board
        validPos = (index >= 0) && (index <= 8)
        #check if position is free or taken
        if (validPos && (@board[index] != "X" && @board[index] != "O"))
            true
        else
            false
        end
    end

    #turn_count
    def turn_count
        count = 0
        @board.each do |token|
            if token == "X" || token == "O"
                count += 1
            end
        end
        
        #return number of turns played
        count
    end

    #current_player
    def current_player
        turns_played = self.turn_count
        if turns_played % 2 == 0
            "X"
        else
            "O"
        end
    end

    #turn
    def turn
        chosen_move = gets.chomp
        chosen_index = input_to_index chosen_move

        #move is valid ? move and display board : reenter move
        unless valid_move? chosen_index
            turn
        else
            current_player
            move(chosen_index)
            display_board
        end
    end

    #won?
    def won?
        winner_status = false
        # check if there is a win combination in the board
        WIN_COMBINATIONS.each do |win_com|
            if (@board[win_com[0]] != " ") && (@board[win_com[0]] == @board[win_com[1]]) && (@board[win_com[1]] == @board[win_com[2]])
                winner_status = true
                return win_com
            end
        end

        #return winner status
        winner_status
    end

    #full?
    def full?
        if @board.include?(" ")
            false
        else
            true
        end
    end

    #draw?
    def draw?
        #check if its full but not won
        # if self.full? && !self.won?
        #     true
        # else
        #     false
        # end
        self.full? && !self.won?
    end

    #over?
    def over?
        #check if its won or full(draw)
        self.won? || self.draw?
    end

    #winner
    def winner
        winning_combo = self.won?
        #return token that won
        if winning_combo.class == Array
            @board[winning_combo[0]]
        else
            nil
        end
    end
end

#Test game
game = TicTacToe.new
board = ["X", "O", " ", " ", " ", " ", " ", "O", "X"]
game.instance_variable_set(:@board, board)
binding.pry