require_relative "board"
require_relative "player"

class TicTacToe
    
    def initialize
        @player1
        @player2
        @board
        greet
        play
    end

    private

    def greet
        puts "Welcome to".center( 80)
        puts
        puts " / X |   | X \\                   / T | T | T \\                   / O |   | O \\".center( 80)
        puts " \\-----------/                   \\-----------/                   \\-----------/".center( 80)
        puts " <   | X |   >                   < I | A | O >                   <   | O |   >".center( 80)
        puts " /-----------\\                   /-----------\\                   /-----------\\".center( 80)
        puts " \\ X |   | X /                   \\ C | C | E /                   \\ O |   | O /".center( 80)
        puts
        puts "Rules".center( 80)
        puts "_" *  80
        puts "Best of three.".center( 80)
        puts "A square's position is denoted by its row and column, in that order.".center( 80)
        puts "The row can be 't', 'm', or 'b' for top, middle, or bottom.".center( 80)
        puts "The column can be 'l', 'm', or 'r' for left, middle, or right.".center( 80)
        puts "The positions of 'A' and 'E' in the title board are 'mm' and 'br', respectively.".center( 80)
        puts "_" *  80
    end

    def play
        print "Player 1, enter your name: "
        @player1 = Player.new(gets.chomp)
        print "\nPlayer 2, enter you name: "
        @player2 = Player.new(gets.chomp)
        puts

        3.times do |round|
            puts "_" *  80
            puts "Round #{round}"
            play_round
            puts "_" *  80
        end

        if @player1.wins > @player2.wins
            puts @player1.name + " wins!"
        elsif @player2.wins > @player1.wins
            puts @player2.name + " wins!"
        else
            puts "You tied!"
        end
        play_or_end
    end

    def play_round
        players = []
        case rand(2)
        when 0
            @player1.piece = "x"
            @player2.piece = "o"
            players.push(@player1)
            players.push(@player2)
        when 1
            @player1.piece = "o"
            @player2.piece = "x"
            players.push(@player2)
            players.push(@player1)
        end

        turn = 0
        @board = Board.new
        while !@board.game_over?
            @board.display
            turn % 2 == 0 ? take_turn(players[0], "x") : take_turn(players[1], 'o')
            turn += 1
        end

        @board.display
        if @board.winner == "x"
            players[0].wins += 1
            puts players[0].name + " wins this round!"
        elsif @board.winner == "o"
            players[1].wins += 1
            puts players[1].name + " wins this round!"
        else
            puts "You tied this round!"
        end
    end

    def play_or_end
        chances = 3
        puts "Would you like to play again? (y/n)"
        answer = gets.chomp.downcase
        while answer != 'y' && answer != 'n' && chances > 0
            puts "Please enter 'y' or 'n'."
            answer = gets.chomp.downcase
            chances -= 1
        end

        if chances <= 0
            "Too many incorrect responses. Ending game. Come again!"
        else
            if answer == 'y'
                puts "Let's begin!"
                play
            else
                "Come again!"
            end
        end
    end

    def take_turn player, piece
        print player.name + "'s turn (#{piece}): "
        position = gets.chomp.downcase
        while !@board.available_spaces.include?(position)
            print "\nEnter a valid position #{@board.available_spaces}: "
            position = gets.chomp.downcase
        end
        @board.place_piece(piece, position)
        puts
    end
end

TicTacToe.new