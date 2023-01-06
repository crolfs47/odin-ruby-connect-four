class GameBoard
  attr_reader :white, :black

  def initialize
    @board = Array.new(6) { Array.new(7) }
    @white = '⚪'
    @black = '⚫'
  end

  def place_chip(player, column)
    @board.each_with_index do |_row, index|
      if @board[index][column - 1] == @black || @board[index][column - 1] == @white
        @board[index - 1][column - 1] = player
        break
      end
      @board[index][column - 1] = player if index == 5
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
    board_string
  end

  def check_if_row_winner
    count = 0
    winning_color = nil
    @board.each do |row|
      winning_color = nil
      row.each do |column|
        break if count == 4

        if !column.nil?
          winning_color = column
          count += 1
        elsif column == winning_color && !column.nil?
          count += 1
        else
          winning_color = nil
          count = 0
        end
      end
    end
    winning_color
  end

  def check_if_column_winner
    winning_color = nil
    winner = nil
    @board.each_with_index do |row, row_index|
      winning_color = nil
      row.each_with_index do |column, column_index|
        if !column.nil?
          winning_color = column
        elsif !winning_color.nil?
          count = 1
          for winning_row in row_index..5 do
            winner = winning_color if count == 4
            count += 1 if @board[winning_row][column_index - 1] == winning_color
          end
        else
          winning_color = nil
        end
      end
    end
    winner
  end

  def check_if_diagonal_winner
    winning_color = nil
    winner = nil
    @board.each_with_index do |row, row_index|
      row.each_with_index do |column, column_index|
        if !column.nil?
          winning_color = column
        elsif !winning_color.nil?
          winning_column_index = column_index - 1
          count = 1
          for winning_row in row_index..5 do
            winner = winning_color if count == 4
            count += 1 if @board[winning_row][winning_column_index] == winning_color && winning_column_index > 0
            winning_column_index -= 1
          end

          winning_column_index = column_index - 1
          count = 1
          for winning_row in row_index..5 do
            winner = winning_color if count == 4
            count += 1 if @board[winning_row][winning_column_index] == winning_color && winning_column_index > 0
            winning_column_index += 1
          end
        else
          winning_color = nil
        end
      end
    end
    winner
  end

  def check_winner
    winner = check_if_row_winner
    winner ||= check_if_column_winner
    winner ||= check_if_diagonal_winner
    winner
  end
end