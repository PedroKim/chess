require_relative 'pieces/pieces'
require 'byebug'
class Board
    def initialize(grid = nil)
        @sentinel = NullPiece.instance
        @grid = grid ? grid : setup_board
    end

    def [](pos)
        row, col = pos
        grid[row][col]
    end

    def []=(pos, piece)
        row, col = pos
        grid[row][col] = piece
    end

    def dup
        grid = []
        @grid.each do |row|
            grid << row.dup
        end
        grid
        Board.new(grid)
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

    def all_pieces(color)
        grid.flatten.select do |piece|
            !piece.is_a?(NullPiece) && piece.color == color
        end
    end

    def find_king(color)
        all_pieces(color).each do |piece|
            return piece if piece.is_a?(King)
        end
    end

    def in_check?(color)
        king = find_king(color)
        opp_color = color == :black ? :white : :black
        all_pieces(opp_color).any? do |piece|
            piece.moves.include?(king.pos)
        end
    end

    def checkmate?(color)
        in_check?(color) && all_pieces(color).map(&:valid_moves).all?(&:empty?)
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
        pieces = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        [0, 7].each do |row_idx|
            color = row_idx == 0 ? :black : :white
            pieces.each_with_index do |p_class, col_idx|
                p_class.new(color, self, [row_idx, col_idx])
            end
        end
    end

    def fill_front_rows(grid)
        [1, 6].each do |row_idx|
            color = row_idx == 1 ? :black : :white
            grid[row_idx].map!.with_index do |_, col_idx|
                Pawn.new(color, self, [row_idx, col_idx])
            end
        end
    end
end