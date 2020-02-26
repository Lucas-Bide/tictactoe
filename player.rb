class Player
    attr_accessor :name, :piece, :wins

    def initialize name
        @name = name
        @piece # 'x' or 'o'
        @wins = 0
    end

end
