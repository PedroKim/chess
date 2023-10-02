require 'singleton'
require_relative 'piece'

class NullPiece < Piece
    include Singleton
    
    def initialize
    end

    def empty?
        true
    end

    def to_s
        ' '
    end

    def inspect
        ' '
    end
end