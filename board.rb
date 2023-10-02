require_relative 'piece'
require_relative 'null_piece'

class Board
    def initialize
        @sentinel = NullPiece.instance
        @grid = setup_board
    end

    def [](pos)
        row, col = pos
        @grid[row][col]
    end

    def []=(pos, piece)
        row, col = pos
        @grid[row][col] = piece
    end

    def render_board
        @grid.each do |row|
            puts row.join(' ')
        end
    end

    private
    def setup_board
        grid = Array.new(8) { Array.new(8, @sentinel) }
        fill_back_rows(grid)
        fill_front_rows(grid)
        grid
    end

    def fill_back_rows(grid)
        [0, 7].each do |row_idx|
            color = row_idx == 0 ? :white : :black
            grid[row_idx].map!.with_index do |_, col_idx| 
                Piece.new(color, self, [row_idx, col_idx]) 
            end
        end
    end

    def fill_front_rows(grid)
        [1, 6].each do |row_idx|
            color = row_idx == 1 ? :white : :black
            grid[row_idx].map!.with_index do |_, col_idx|
                Piece.new(color, self, [row_idx, col_idx])
            end
        end
    end
end