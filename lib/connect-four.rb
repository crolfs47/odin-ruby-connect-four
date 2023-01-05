require 'game-board'

class ConnectFour
  def initialize
    @player_one = ''
    @player_two = ''
    @board = GameBoard.new
  end

  def setup_player_one
    puts 'Enter player one name:'
    @player_one = gets.chomp
  end

  def setup_player_two
    puts 'Enter player two name:'
    @player_two = gets.chomp
  end

  def start_game
    setup_player_one
    setup_player_two
    puts "#{@player_one}'s turn: "
    puts @board.print
    puts "Please enter a column: "
  end

  def make_move(player, column)
    if player == @player_one
      @board.place_chip(@board.black, column)
    else
      @board.place_chip(@board.white, column)
    end
    puts @board.print
  end

  def check_winner
    color = @board.check_winner
    if color == @board.black
      puts "#{@player_one} wins!"
    end
    if color == @board.white
      puts "#{@player_two} wins!"
    end
  end
end