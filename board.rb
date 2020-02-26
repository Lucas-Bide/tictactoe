=begin
    I don't know how I want these classes interfaces to interact...
=end

class Board
    attr_reader :winner
    @@COLUMNS = ["l", "m", "r"]
    @@ROWS = ["t", "m", "b"]

    def initialize
        @board = Array.new(3) {Array.new(3, " ")}
        @winner
    end

    def available_spaces
        spaces = []
        for r in 0..2
            for c in 0..2
                spaces.push(@@ROWS[r] + @@COLUMNS[c]) if @board[r][c] == " "
            end
        end
        spaces
    end
    
    def display
        puts
        puts " #{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]} ".center(50)
        puts "-----------".center(50)
        puts " #{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]} ".center(50)
        puts "-----------".center(50)
        puts " #{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]} ".center(50)
        puts
    end

    def game_over?
        result
        !@winner.nil?
    end

    # Pre-condition: position is an empty position
    def place_piece piece, position
        @board[@@ROWS.index(position[0])][@@COLUMNS.index(position[1])] = piece
    end

    private

    def result
        players = ["x", "o"]
        players.each do |p|
            combination = p * 3

            if (combination == @board[0].join || 
                combination == @board[1].join || 
                combination == @board[2].join ||
                combination == @board[0][0] + @board[1][0] + @board[2][0] ||
                combination == @board[0][1] + @board[1][1] + @board[2][1] ||
                combination == @board[0][2] + @board[1][2] + @board[2][2] ||
                combination == @board[0][0] + @board[1][1] + @board[2][2] ||
                combination == @board[0][2] + @board[1][1] + @board[2][0])
                @winner = p
                break
            end
        end
        #puts @board.include?(" ").to_s + "is fulls"
        @winner ||= "tie" if !@board[0].include?(" ") && !@board[1].include?(" ") && !@board[2].include?(" ")
    end


end
