require_relative 'piece'
require_relative 'stepable'

class King < Piece
    include Stepable
    
    def inspect
        'Ki'
    end

    private
    def move_diffs
        [
            [1, 1],
            [1, 0],
            [0, 1],
            [-1, -1],
            [-1, 0],
            [0, -1],
            [-1, 1],
            [1, -1]
        ]
    end
end