require_relative 'board'
require_relative 'display'
require_relative 'player'

class Game
    attr_reader :board, :display, :player_1, :player_2, :current_player, :error_message

    def initialize
        @board = Board.new
        @display = Display.new(board)
        @player_1 = Player.new(:white, @display, [7, 0])
        @player_2 = Player.new(:black, @display, [0, 0])
        @current_player = @player_1
        @error_message = nil
    end

    def play
        until board.checkmate?(current_player.color)
            begin
                system("clear")
                puts "#{current_player.color.capitalize}'s turn!"
                display.cursor.cursor_pos = current_player.cursor_pos
                render
                if error_message
                    puts error_message
                    set_error_message(nil)
                end
                current_player.make_move(board)
            rescue StandardError => e
                set_error_message("Something went wrong: #{e.message}")
                display.cursor.deselect
                retry
            end
            swap_turn!
        end
        system("clear")
        display.cursor.cursor_pos = [-1, -1]
        render
        opp_player = current_player
        swap_turn!
        puts "checkmate #{opp_player.color}, #{current_player.color} wins!!!"
    end

    def render
        display.render([])
    end

    private
    
    def set_error_message(msg)
        @error_message = msg
    end

    # def notify_players
    # end

    def swap_turn!
        @current_player = @current_player == @player_1 ? @player_2 : @player_1
    end
end

if $PROGRAM_NAME == __FILE__
    Game.new.play
end