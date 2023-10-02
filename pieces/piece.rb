class Piece
    attr_reader :color, :board, :pos

    def initialize(color, board, pos)
        @color, @board = color, board
        self.pos = pos
    end

    def pos=(pos)
        board[pos] = self
        @pos = pos
    end

    def empty?
        false
    end

    def moves
        raise NotImplementedError
        # each individual piece class should implement it's own moves method
        # each version should return an array of places a piece can move to.
    end

    def to_s
        'P'
    end

    def inspect
        'P'
    end
end