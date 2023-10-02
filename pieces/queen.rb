require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
    include Slideable

    def move_dirs
        diagonal_dirs + orthogonal_dirs
    end

    def inspect
        'Qu'
    end
end