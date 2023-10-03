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
            render
        end

        unless board[start_pos].color == color
            raise "cannot move opponent's piece."
        end

        until end_pos
            end_pos = display.cursor.get_input
            render
        end

        board.move_piece(start_pos, end_pos, color)
        self.cursor_pos = end_pos
    end

    private
    def render
        system("clear")
        puts "#{color.capitalize}'s turn!"
        display.render
    end
end