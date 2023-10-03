class Player
    attr_reader :color, :display
    attr_accessor :cursor_pos

    def initialize(color, display, cursor_pos)
        @color, @display = color, display
        @cursor_pos = cursor_pos
    end

    def make_move(board)
        start_pos, end_pos = nil, nil
        until start_pos
            start_pos = display.cursor.get_input
            render([])
        end

        piece = board[start_pos]
        unless piece.color == color
            raise "cannot move opponent's piece."
        end

        render(piece.valid_moves)

        until end_pos
            end_pos = display.cursor.get_input
            render(piece.valid_moves)
        end

        board.move_piece(start_pos, end_pos, color)
        self.cursor_pos = end_pos
    end

    private
    def render(positions)
        system("clear")
        puts "#{color.capitalize}'s turn!"
        display.render(positions)
    end
end