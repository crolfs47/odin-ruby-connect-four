require './lib/connect-four'

describe ConnectFour do
  subject(:game) { described_class.new }

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
        expect(board).to receive(:check_winner).and_return(true).once

        game_over = game.game_over?

        expect(game_over).to be(true)
      end

      it 'should return true when there is a tie' do
        expect(board).to receive(:check_winner).and_return(false).once
        expect(game).to receive(:check_if_full?).and_return(true).once

        game_over = game.game_over?

        expect(game_over).to be(true)
      end

      it 'should return false when there is no tie or winner' do
        expect(board).to receive(:check_winner).and_return(false)
        expect(game).to receive(:check_if_full?).and_return(false)

        game_over = game.game_over?

        expect(game_over).to be(false)
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
