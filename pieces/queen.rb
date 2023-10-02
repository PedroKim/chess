require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
    include Slideable
    
    def symbol
        '♛'
    end

    def inspect
        'Qu'
    end

    private
    def move_dirs
        diagonal_dirs + orthogonal_dirs
    end
end