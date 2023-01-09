require './lib/connect-four'

describe ConnectFour do
  subject(:game) { described_class.new }
  # let(:player_one) { instance_double(Player, name: 'Cathy', color: '⚫') }

  before do
    # player_one = game.instance_variable_get(:@player_one)
  end

  describe '#initialize' do
    context 'when a new game is initialized' do
      it 'should create a new instance of Player for player one' do
        expect(game.player_one).to be_an_instance_of(Player)
        expect(game.player_one.name).to eq('Player 1')
        expect(game.player_one.color).to eq('⚫')
      end
      it 'should create a new Player class for player two' do
        expect(game.player_two).to be_an_instance_of(Player)
        expect(game.player_two.name).to eq('Player 2')
        expect(game.player_two.color).to eq('⚪')
      end
    end
  end

  describe '#set_up_players' do
    context 'when player one is set up' do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('Cathy')
      end
      it 'should get a name for player one' do
        player_one = game.setup_player_one
        expect(player_one.name).to eq('Cathy')
      end
    end

    context 'when player two is set up' do
      before do
        allow(game).to receive(:puts)
        allow(game).to receive(:gets).and_return('Alex')
      end
      it 'should get a name for player one' do
        player_two = game.setup_player_two
        expect(player_two.name).to eq('Alex')
      end
    end
  end

  describe '#switch_player' do
    subject(:game_switch_player) { described_class.new }
    context 'when it is the next players turn' do
      it 'should switch from player 1 to player 2' do
        current_player = game_switch_player.switch_player

        expect(current_player).to eq(game_switch_player.player_two)
      end
      it 'should switch from player 2 to player 1' do

      end
    end
  end


  describe '#game_over' do
    let(:board) { instance_double(GameBoard)}
    subject(:game) { described_class.new(board) }

    context 'when the game is over' do
      it 'should return true when someone wins' do
        expect(board).to receive(:check_winner).and_return(true).twice

        game_over = game.game_over?
        win_phrase = "Congratulations! Player 1 wins!\n"

        expect(game_over).to be(true)
        expect { game.game_over? }.to output(win_phrase).to_stdout
      end
      it 'should return true when there is a tie' do
        expect(board).to receive(:check_winner).and_return(false).twice
        expect(game).to receive(:check_if_full?).and_return(true).twice

        game_over = game.game_over?
        tie_phrase = "It's a tie!\n"

        expect(game_over).to be(true)
        expect { game.game_over? }.to output(tie_phrase).to_stdout
      end
      it 'should return false when there is no tie or winner' do
      end
    end
  end

  describe '#check_if_full?' do
    context 'when the board is full' do
      subject(:game) { described_class.new(nil, 42) }
      it 'should return true' do
        expect(game.check_if_full?).to be(true)
      end
    end

    context 'when the board is not full' do
      subject(:game) { described_class.new(nil, 41) }
      it 'should return false' do
        expect(game.check_if_full?).to be(false)
      end
    end
  end
end


  # describe '#start_game' do
  #   context "when it's the first turn" do
  #     it "prints that it's player one's turn" do
  #       allow(game).to receive(:gets).and_return('Cathy', 'Alex')

  #       expect(game).to receive(:puts).with("Cathy's turn: ")

  #       game.start_game
  #     end

  #     it 'prints the empty board and asks for their move' do
  #       allow(game).to receive(:gets).and_return('Cathy', 'Alex')

  #       expect(game).to receive(:puts).with("⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n")

  #       expect(game).to receive(:puts).with('Please enter a column: ')

  #       game.start_game
  #     end
  #   end
  # end



  # describe '#make_move' do
  #   context 'when a player makes a move' do
  #     before do
  #       allow(game).to receive(:gets).and_return('Cathy', 'Alex')
  #     end
  #     it 'updates the board first position in a row' do
  #       expect(game).to receive(:puts).with("⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚫ ⚬  ⚬  \n")

  #       game.start_game
  #       game.make_move('Cathy', 5)
  #     end

  #     it 'updates the board when there is already a chip in the selected row' do
  #       expect(game).to receive(:puts).with("⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚪ ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚫ ⚬  ⚬  \n")

  #       game.start_game
  #       game.make_move('Cathy', 5)
  #       game.make_move('Alex', 5)
  #     end
  #   end
  # end

