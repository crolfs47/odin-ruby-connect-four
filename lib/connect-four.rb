require_relative 'game-board'
require_relative 'player'

class ConnectFour
  attr_reader :player_one, :player_two, :current_player, :board

  def initialize(board = nil, turn_count = 0)
    @player_one = Player.new('Player 1', '⚫')
    @player_two = Player.new('Player 2', '⚪')
    @current_player = @player_one
    @board = board.nil? ? GameBoard.new(@player_one.color, @player_two.color) : board
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
    puts 'This is a two player game. The first player to get 4 pieces in a row (horizontally, vertically, or diagonally wins.'
    setup_player_one
    setup_player_two
    take_turn
    display_result
  end

  def take_turn
    until game_over?
      puts ''
      puts "#{@current_player.name}'s turn: "
      puts @board.print
      puts 'Please enter a column: '
      column = gets.chomp.to_i
      if @board.place_chip(@current_player.color, column)
        @turn_count += 1
        switch_player
      end
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
    @board.check_winner || check_if_full?
  end

  def check_if_full?
    return true if @turn_count == 42

    false
  end

  def display_result
    puts @board.print
    if @board.check_winner
      switch_player
      puts "#{@current_player.name} wins!"
    end
    puts "It's a tie!" if check_if_full?
  end
end
