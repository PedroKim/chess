module Slideable
    DIAGONAL_DIRS = [
        [1, 1],
        [-1, -1],
        [1, -1],
        [-1, 1]
    ].freeze

    ORTHOGONAL_DIRS = [
        [1, 0],
        [0, 1],
        [-1, 0],
        [0, -1]
    ].freeze

    def diagonal_dirs
        DIAGONAL_DIRS
    end

    def orthogonal_dirs
        ORTHOGONAL_DIRS
    end

    
    def moves
        moves = []
        move_dirs.each do |dx, dy|
            moves.concat(grow_unblocked_moves_in_dir(dx, dy))
        end
        moves
    end
    
    private
    def move_dirs
        raise NotImplementedError
    end
    
    def grow_unblocked_moves_in_dir(dx, dy)
        moves = []
        next_pos = pos

        loop do
            next_pos = [next_pos[0] + dx, next_pos[1] + dy]
            break unless board.valid_pos?(next_pos)
            # next pos is in bound
            if board[next_pos].empty?
                moves << next_pos
            else
                if board[next_pos].color != self.color
                    moves << next_pos
                end
                break
            end
        end

        moves
    end
end