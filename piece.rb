class Piece
    def initialize(color, board, pos)
        @color, @board, @pos = color, board, pos
    end

    def to_s
        'P'
    end

    def inspect
        'P'
    end
end