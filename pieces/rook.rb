require_relative 'piece'
require_relative 'slideable'

class Rook < Piece
    include Slideable
    
    def inspect
        'Ro'
    end
    
    private
    def move_dirs
        orthogonal_dirs
    end
end