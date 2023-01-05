class GameBoard
  attr_reader :white, :black

  def initialize
    @board = Array.new(6) { Array.new(7) }
    @white = "⚪"
    @black = "⚫"
  end

  def place_chip(player, column)
    @board.each_with_index do |row, index|
      if @board[index][column - 1] == @black || @board[index][column - 1] == @white
        @board[index - 1][column - 1] = player
        break
      end
      if index == 5
        @board[index][column - 1] = player
      end
    end
  end

  def print
    board_string = ''
    @board.each do |row|
      row.each do |column|
        if column.nil?
          board_string += '⚬  '
        else
          board_string += "#{column} "
        end
      end
      board_string += "\n"
    end
    board_string
  end
end