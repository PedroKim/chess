require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display
    attr_reader :board, :cursor

    def initialize(board = Board.new)
        @board = board
        @cursor = Cursor.new([0, 0], board)
    end

    def render(positions = [])
        board.grid.each_with_index do |row, row_idx|
            mapped_row = row.map.with_index do |piece, col_idx|
                # for checker board style coloring
                # disabled for now - piece color not rendering properly on 
                # some background colors
                # background = (row_idx + col_idx) % 2 == 0 ? :yellow : :green
                # if [row_idx, col_idx] == [0, 0]
                #     debugger
                #     p piece.to_s.colorize(color: piece.color, background: background)
                # end
                background = :light_gray
                pos = [row_idx, col_idx]
                if positions.include?(pos)
                    background = :light_blue
                end
                if pos == cursor.cursor_pos
                    background = cursor.selected ? :light_green : :light_red
                end
                piece.to_s.colorize(color: piece.color, background: background)
            end
            puts mapped_row.join('')
        end
    end

end