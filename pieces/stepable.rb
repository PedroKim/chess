module Stepable
    def moves
        moves = []
        move_diffs.each do |dx, dy|
            next_pos = [pos[0] + dx, pos[1] + dy]
            next unless board.check_bounds(next_pos)
            if board[next_pos].empty?
                moves << next_pos
            else
                moves << next_pos if board[next_pos].color != self.color
                next
            end
        end
        moves
    end

    private
    def move_diffs
        raise NotImplementedError
    end
end