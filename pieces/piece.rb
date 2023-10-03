class Piece
    attr_reader :color, :board
    attr_accessor :pos

    def initialize(color, board, pos)
        @color, @board, @pos = color, board, pos
    end

    def empty?
        false
    end

    def moves
        raise NotImplementedError
    end

    def move_into_check?(end_pos)
        board_copy = board.dup
        board_copy.move_piece!(pos, end_pos)
        board_copy.in_check?(color)
    end

    def valid_moves
        moves.select { |move| !move_into_check?(move) }
    end

    def symbol
        'P'
    end

    def to_s
        "#{symbol} "
    end

    def inspect
        'P'
    end
end