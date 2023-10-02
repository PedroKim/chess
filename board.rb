require_relative 'pieces/pieces'
require 'byebug'
class Board
    def initialize
        @sentinel = NullPiece.instance
        @grid = setup_board
    end

    def [](pos)
        row, col = pos
        grid[row][col]
    end

    def []=(pos, piece)
        row, col = pos
        grid[row][col] = piece
    end

    def render_board
        grid.each do |row|
            puts row.join(' ')
        end
    end

    def check_bounds(pos)
        pos.all? { |coord| coord.between?(0, 7) }
    end

    def move_piece(start_pos, end_pos)
        [start_pos, end_pos].each do |pos| 
            raise "#{pos} is out of bounds" unless check_bounds(pos)
        end
        raise "there is no piece at #{start_pos}" if self[start_pos].empty?
        raise "the piece cannot move to #{end_pos}" unless self[end_pos].empty?

        self[start_pos].pos = end_pos
        self[start_pos] = @sentinel
        grid
    end

    private
    attr_accessor :grid

    def setup_board
        self.grid = Array.new(8) { Array.new(8, @sentinel) }
        fill_back_rows(grid)
        fill_front_rows(grid)
        grid
    end

    def fill_back_rows(grid)
        pieces = [Rook, Piece, Bishop, Piece, Queen, Bishop, Piece, Rook]
        [0, 7].each do |row_idx|
            color = row_idx == 0 ? :white : :black
            pieces.each_with_index do |p_class, col_idx|
                p_class.new(color, self, [row_idx, col_idx])
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