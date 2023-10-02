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

    def move_into_check?(end_pos)
        board_copy = board.dup 
        board_copy.move_piece(pos, end_pos)
        board_copy.in_check?(color)
    end

    def valid_moves
        moves.select { |move| !move_into_check?(move) }
    end

    def symbol
        'P'
    end

    def to_s
        "#{symbol}"
    end

    def inspect
        'P'
    end
end