require 'game-board'
require 'player'

class ConnectFour
  attr_reader :player_one, :player_two, :current_player, :board

  def initialize
    @player_one = Player.new('Player 1', '⚫')
    @player_two = Player.new('Player 2', '⚪')
    @current_player = @player_one
    @board = GameBoard.new(@player_one.color, @player_two.color)
  end

  # Don't need to test methods that only contain puts and/or gets, these probably s/b private methods. See Ruby testing exercise 13 - input_ouput
  def setup_player_one
    puts 'Enter player one name:'
    @player_one.name = gets.chomp
    @player_one
  end

  def setup_player_two
    puts 'Enter player two name:'
    @player_two.name = gets.chomp
    @player_two
  end

  def start_game
    setup_player_one
    setup_player_two
    puts "#{@player_one}'s turn: "
    puts @board.print
    puts "Please enter a column: "
  end

  def switch_player
    @current_player = @current_player == @player_one ? @player_two : @player_one
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