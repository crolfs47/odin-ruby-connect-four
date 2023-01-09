require 'game-board'
require 'player'

class ConnectFour
  attr_reader :player_one, :player_two, :current_player, :board

  def initialize(board = nil, turn_count = 0)
    @player_one = Player.new('Player 1', '⚫')
    @player_two = Player.new('Player 2', '⚪')
    @current_player = @player_one
    @board = board == nil ? GameBoard.new(@player_one.color, @player_two.color) : board
    @turn_count = turn_count
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

  def play_game
    puts 'Welcome to Connect Four!'
    setup_player_one
    setup_player_two
    take_turn
  end

  def take_turn
    until game_over?
      puts "#{@current_player}'s turn: "
      puts @board.print
      puts 'Please enter a column: '
      column = gets.chomp.to_i
      @board.place_chip(@current_player.color, column)
      @turn_count += 1
      switch_player
      take_turn
    end
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

  def game_over?
    if @board.check_winner
      puts "Congratulations! #{@current_player.name} wins!"
      true
    elsif check_if_full?
      puts "It's a tie!"
      true
    else
      false
    end
  end

  def check_if_full?
    return true if @turn_count == 42

    false
  end
end