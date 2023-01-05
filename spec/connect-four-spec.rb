require './lib/connect-four'

describe ConnectFour do
  describe '#setup_players' do
    subject(:game) { described_class.new }

    context 'player setup' do
      it 'prompts for player names' do
        player_one = 'Enter player one name:'
        player_two = 'Enter player two name:'

        expect(game).to receive(:puts).with(player_one)
        expect(game).to receive(:puts).with(player_two)

        game.setup_players
      end

      describe '#setup_player_one' do
        it 'receives player one' do
          expected_player_name = 'cathy'
          allow(game).to receive(:gets).and_return(expected_player_name)

          actual_player_name = game.setup_player_one

          expect(actual_player_name).to eq(expected_player_name)
        end
      end

      describe '#setup_player_two' do
        it 'receives player two' do
          expected_player_name = 'alex'
          allow(game).to receive(:gets).and_return(expected_player_name)

          actual_player_name = game.setup_player_two

          expect(actual_player_name).to eq(expected_player_name)
        end
      end
    end
  end
end
