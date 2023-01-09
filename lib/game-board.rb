require_relative 'player'

class GameBoard
  attr_reader :white, :black, :board

  def initialize(black, white)
    @board = Array.new(6) { Array.new(7) }
    @black = black
    @white = white
  end

  def place_chip(player_color, column)
    return false unless check_valid_move?(column)

    col = column - 1
    @board.each_with_index do |_row, index|
      if @board[index][col] == @black || @board[index][col] == @white
        @board[index - 1][col] = player_color
        break
      end
      @board[index][col] = player_color if index == 5
    end
    true
  end

  def check_valid_move?(column)
    if !column.between?(1, 7)
      puts "\nPlease select a valid column (1-7)."
      false
    elsif !@board[0][column - 1].nil?
      puts "\nThat column is full. Please select another column."
      false
    else
      true
    end
  end

  def print
    board_string = ''
    @board.each do |row|
      row.each do |column|
        board_string += if column.nil?
                          '⚬  '
                        else
                          "#{column} "
                        end
      end
      board_string += "\n"
    end
    puts board_string
  end

  def check_row_winner
    0.upto(5) do |row|
      0.upto(3) do |col|
        if !@board[row][col].nil? && @board[row][col] == @board[row][col + 1] && @board[row][col] == @board[row][col + 2] && @board[row][col] == @board[row][col + 3]
          return true
        end
      end
    end
    false
  end

  def check_column_winner
    0.upto(2) do |row|
      0.upto(5) do |col|
        if !@board[row][col].nil? && @board[row][col] == @board[row + 1][col] && @board[row][col] == @board[row + 2][col] && @board[row][col] == @board[row + 3][col]
          return true
        end
      end
    end
    false
  end

  def check_forward_diagonal_winner
    0.upto(2) do |row|
      3.upto(6) do |col|
        if !@board[row][col].nil? && @board[row][col] == @board[row + 1][col - 1] && @board[row][col] == @board[row + 2][col - 2] && @board[row][col] == @board[row + 3][col - 3]
          return true
        end
      end
    end
    false
  end

  def check_backward_diagonal_winner
    0.upto(2) do |row|
      0.upto(3) do |col|
        if !@board[row][col].nil? && @board[row][col] == @board[row + 1][col + 1] && @board[row][col] == @board[row + 2][col + 2] && @board[row][col] == @board[row + 3][col + 3]
          return true
        end
      end
    end
    false
  end

  def check_winner
    check_row_winner == true || check_column_winner == true || check_forward_diagonal_winner == true || check_backward_diagonal_winner == true
  end
end