class ConnectFour
  def initialize
    @player_one = ''
    @player_two = ''
  end

  def setup_players
    puts 'Enter player one name:'
    puts 'Enter player two name:'
  end


  def setup_player_one
    @player_one = gets.chomp
  end

  def setup_player_two
    @player_two = gets.chomp
  end
end