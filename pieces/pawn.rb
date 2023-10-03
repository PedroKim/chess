require_relative 'piece'

class Pawn < Piece

    def symbol
        '♟︎'
    end

    def moves
        forward_steps + side_attacks
    end

    def inspect
        'Pa'
    end

    private
    def forward_dir
        color == :black ? 1 : -1
    end

    def forward_steps
        col, row = pos
        steps = [[col + forward_dir, row]]
        if (color == :black && col == 1) || (color == :white && col == 6)
            steps << [col + (2 * forward_dir), row]
        end
        steps.select { |pos| board[pos].empty? }
    end

    def side_attacks
        next_col = pos[0] + forward_dir
        row = pos[1]
        [[next_col, row + 1], [next_col, row - 1]].select do |pos|
            board.valid_pos?(pos) && !board[pos].empty? && board[pos].color != color
        end
    end
end