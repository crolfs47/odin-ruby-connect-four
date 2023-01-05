require './lib/connect-four'

describe ConnectFour do
  subject(:game) { described_class.new }

  before do
    allow(game).to receive(:puts)
  end

  describe '#setup_player_one' do
    context 'player one' do
      it 'it prompts for player one name and receives the player' do
        expected_player_name = 'cathy'
        allow(game).to receive(:gets).and_return(expected_player_name)
        player_one = 'Enter player one name:'

        expect(game).to receive(:puts).with(player_one)
        actual_player_name = game.setup_player_one

        expect(actual_player_name).to eq(expected_player_name)
      end
    end
  end

  describe '#setup_player_two' do
    context 'player two' do
      it 'it prompts for player two name and receives the player' do
        expected_player_name = 'alex'
        allow(game).to receive(:gets).and_return(expected_player_name)
        player_two = 'Enter player two name:'

        expect(game).to receive(:puts).with(player_two)
        actual_player_name = game.setup_player_two

        expect(actual_player_name).to eq(expected_player_name)
      end
    end
  end

  describe '#start_game' do
    context "when it's the first turn" do
      it "prints that it's player one's turn" do
        allow(game).to receive(:gets).and_return('Cathy', 'Alex')

        expect(game).to receive(:puts).with("Cathy's turn: ")

        game.start_game
      end

      it 'prints the empty board and asks for their move' do
        allow(game).to receive(:gets).and_return('Cathy', 'Alex')

        expect(game).to receive(:puts).with("⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n")

        expect(game).to receive(:puts).with('Please enter a column: ')

        game.start_game
      end
    end
  end

  describe '#make_move' do
    context 'when a player makes a move' do
      before do
        allow(game).to receive(:gets).and_return('Cathy', 'Alex')
      end
      it 'updates the board first position in a row' do
        expect(game).to receive(:puts).with("⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚫ ⚬  ⚬  \n")

        game.start_game
        game.make_move('Cathy', 5)
      end

      it 'updates the board when there is already a chip in the selected row' do
        expect(game).to receive(:puts).with("⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚬  ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚪ ⚬  ⚬  \n⚬  ⚬  ⚬  ⚬  ⚫ ⚬  ⚬  \n")

        game.start_game
        game.make_move('Cathy', 5)
        game.make_move('Alex', 5)
      end
    end
  end

  describe '#check_if_winner' do
    context 'when someone wins with four in a row' do
      before do
        allow(game).to receive(:gets).and_return('Cathy', 'Alex')
      end
      it 'declares a winner' do
        expect(game).to receive(:puts).with('Cathy wins!')

        game.start_game

        game.make_move('Cathy', 1)
        game.make_move('Cathy', 2)
        game.make_move('Cathy', 3)
        game.make_move('Cathy', 4)
        game.check_winner
      end
    end

    context 'when someone wins with four in a column' do
      before do
        allow(game).to receive(:gets).and_return('Cathy', 'Alex')
      end

      it 'declares a winner' do
        expect(game).to receive(:puts).with('Cathy wins!')

        game.start_game

        game.make_move('Cathy', 2)
        game.make_move('Cathy', 2)
        game.make_move('Cathy', 2)
        game.make_move('Cathy', 2)
        game.check_winner
      end
    end
  end
end
