require 'player'

class GameBoard
  attr_reader :white, :black, :board

  def initialize(black, white)
    @board = Array.new(6) { Array.new(7) }
    @black = black
    @white = white
    
  end

  def place_chip(player_color, column)
    @board.each_with_index do |_row, index|
      if @board[index][column - 1] == @black || @board[index][column - 1] == @white
        @board[index - 1][column - 1] = player_color
        break
      end
      @board[index][column - 1] = player_color if index == 5
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
    return false
  end

  def check_column_winner
    0.upto(2) do |row|
      0.upto(5) do |col|
        if !@board[row][col].nil? && @board[row][col] == @board[row + 1][col] && @board[row][col] == @board[row + 2][col] && @board[row][col] == @board[row + 3][col]
          return true
        end
      end
    end
    return false
  end

  def check_forward_diagonal_winner
    0.upto(2) do |row|
      0.upto(3) do |col|
        if !@board[row][col].nil? && @board[row][col] == @board[row + 1][col - 1] && @board[row][col] == @board[row + 2][col - 2] && @board[row][col] == @board[row + 3][col - 3]
          return true
        end
      end
    end
    return false
  end

  def check_backward_diagonal_winner
    0.upto(2) do |row|
      0.upto(3) do |col|
        if !@board[row][col].nil? && @board[row][col] == @board[row + 1][col + 1] && @board[row][col] == @board[row + 2][col + 2] && @board[row][col] == @board[row + 3][col + 3]
          return true
        end
      end
    end
    return false
  end

  def check_winner
    if check_row_winner == true || check_column_winner == true || check_forward_diagonal_winner == true || check_backward_diagonal_winner == true
      true
    else
      false
    end
  end
end

  # def check_if_row_winner
  #   count = 0
  #   winning_color = nil
  #   @board.each do |row|
  #     winning_color = nil
  #     row.each do |column|
  #       break if count == 4

  #       if !column.nil?
  #         winning_color = column
  #         count += 1
  #       elsif column == winning_color && !column.nil?
  #         count += 1
  #       else
  #         winning_color = nil
  #         count = 0
  #       end
  #     end
  #   end
  #   winning_color
  # end

  # def check_if_column_winner
  #   winning_color = nil
  #   winner = nil
  #   @board.each_with_index do |row, row_index|
  #     winning_color = nil
  #     row.each_with_index do |column, column_index|
  #       if !column.nil?
  #         winning_color = column
  #       elsif !winning_color.nil?
  #         count = 1
  #         for winning_row in row_index..5 do
  #           winner = winning_color if count == 4
  #           count += 1 if @board[winning_row][column_index - 1] == winning_color
  #         end
  #       else
  #         winning_color = nil
  #       end
  #     end
  #   end
  #   winner
  # end

  # def check_if_diagonal_winner
  #   winning_color = nil
  #   winner = nil
  #   @board.each_with_index do |row, row_index|
  #     row.each_with_index do |column, column_index|
  #       if !column.nil?
  #         winning_color = column
  #       elsif !winning_color.nil?
  #         winning_column_index = column_index - 1
  #         count = 1
  #         for winning_row in row_index..5 do
  #           winner = winning_color if count == 4
  #           count += 1 if @board[winning_row][winning_column_index] == winning_color && winning_column_index > 0
  #           winning_column_index -= 1
  #         end

  #         winning_column_index = column_index - 1
  #         count = 1
  #         for winning_row in row_index..5 do
  #           winner = winning_color if count == 4
  #           count += 1 if @board[winning_row][winning_column_index] == winning_color && winning_column_index > 0
  #           winning_column_index += 1
  #         end
  #       else
  #         winning_color = nil
  #       end
  #     end
  #   end
  #   winner
  # end

