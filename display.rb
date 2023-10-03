require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display
    attr_reader :board, :cursor

    def initialize(board = Board.new)
        @board = board
        @cursor = Cursor.new([0, 0], board)
    end

    def render
        board.grid.each_with_index do |row, row_idx|
            mapped_row = row.map.with_index do |piece, col_idx|
                # background = (row_idx + col_idx) % 2 == 0 ? :yellow : :green
                background = :light_gray
                if [row_idx, col_idx] == cursor.cursor_pos
                    background = cursor.selected ? :light_green : :light_red
                end
                # if [row_idx, col_idx] == [0, 0]
                #     debugger
                #     p piece.to_s.colorize(color: piece.color, background: background)
                # end
                piece.to_s.colorize(color: piece.color, background: background)
            end
            puts mapped_row.join('')
        end
    end

end

# d = Display.new
# puts "\e[0;30;41m♜ \e[0m"
# puts "\e[0;30;42m♜ \e[0m"
# puts "\e[0;37;42m♜ \e[0m"
# puts "\e[0;37;44m♜ \e[0m"
# puts "\e[0;30;104m♜ \e[0m"
# loop do
#     # system("clear")
#     d.render
#     val = d.cursor.get_input
#     puts val
# end