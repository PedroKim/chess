require_relative 'pieces/pieces'
require 'byebug'
class Board
    attr_reader :grid

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
            new_row = []
            row.each do |piece|
                if piece.is_a?(NullPiece)
                    new_row << @sentinel
                else
                    new_row << piece.class.new(piece.color, piece.board, piece.pos)
                end
            end
            grid << new_row
        end
        grid
        Board.new(grid)
    end

    def render_board
        grid.each do |row|
            puts row.join(' ')
        end
    end

    def valid_pos?(pos)
        pos.all? { |coord| coord.between?(0, 7) }
    end

    def move_piece!(start_pos, end_pos)
        piece = self[start_pos]
        piece.pos = end_pos
        self[end_pos] = piece
        self[start_pos] = @sentinel
    end

    def move_piece(start_pos, end_pos, color)
        [start_pos, end_pos].each do |pos| 
            raise "#{pos} is out of bounds" unless valid_pos?(pos)
        end
        
        start_piece, end_piece = self[start_pos], self[end_pos]

        raise "there is no piece at #{start_pos}" if start_piece.empty?
        unless end_piece.empty? || end_piece.color != color
            raise "your piece is at #{end_pos}"
        end
        if start_piece.move_into_check?(end_pos)
            raise "this move will put you in check."
        end
        unless start_piece.valid_moves.include?(end_pos)
            raise "illegal move. #{start_piece.symbol} cannot be moved to #{end_pos}"
        end

        move_piece!(start_pos, end_pos)
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
    attr_writer :grid

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
            @grid[row_idx].map!.with_index do |_, col_idx|
                pieces[col_idx].new(color, self, [row_idx, col_idx])
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

# b = Board.new
# b.move_piece([6, 5], [5, 5])
# b.move_piece([1, 4], [3, 4])
# b.move_piece([6, 6], [4, 6])
# b.move_piece([0, 3], [4, 7])
# b.render_board
# puts b.checkmate?(:white)
# b.move_piece([6, 0], [5, 0])