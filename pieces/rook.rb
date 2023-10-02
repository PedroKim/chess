require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
    include Slideable

    def move_dirs
        orthogonal_dirs
    end

    def inspect
        'Ro'
    end
end