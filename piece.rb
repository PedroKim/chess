class Piece
    attr_reader :color, :board, :pos

    def initialize(color, board, pos)
        @color, @board, @pos = color, board, pos
    end

    def pos=(pos)
        board[pos] = self
        @pos = pos
    end

    def empty?
        false
    end

    def to_s
        'P'
    end

    def inspect
        'P'
    end
end