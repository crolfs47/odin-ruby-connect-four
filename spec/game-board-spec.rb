require './lib/game-board'

describe GameBoard do
  describe '#check_if_winner' do
    context 'when someone wins with four in a row' do
      subject(:board) { described_class.new }
      it 'declares a winner' do
        board.place_chip(board.black, 1)
        board.place_chip(board.black, 2)
        board.place_chip(board.black, 3)
        board.place_chip(board.black, 4)
        winner = board.check_if_row_winner

        expect(winner).to eq(board.black)
      end
    end

    context 'when someone wins with four in a column' do
      subject(:board) { described_class.new }
      it 'declares a winner' do
        board.place_chip(board.black, 2)
        board.place_chip(board.black, 2)
        board.place_chip(board.black, 2)
        board.place_chip(board.black, 2)
        winner = board.check_if_column_winner

        expect(winner).to eq(board.black)
      end
    end

    context 'when there is not column winner' do
      subject(:board) { described_class.new }
      it 'winner is nil' do
        board.place_chip(board.white, 1)
        board.place_chip(board.black, 1)
        board.place_chip(board.white, 1)
        board.place_chip(board.black, 1)
        board.place_chip(board.white, 2)
        board.place_chip(board.black, 2)
        board.place_chip(board.white, 2)
        board.place_chip(board.black, 3)
        board.place_chip(board.white, 3)
        board.place_chip(board.black, 4)

        winner = board.check_if_column_winner

        expect(winner).to eq(nil)
      end
    end

    context 'when someone wins with four in a diagonal forward' do
      subject(:board) { described_class.new }
      it 'declares a winner forwards' do
        board.place_chip(board.white, 1)
        board.place_chip(board.black, 2)
        board.place_chip(board.white, 2)
        board.place_chip(board.black, 3)
        board.place_chip(board.white, 3)
        board.place_chip(board.black, 3)
        board.place_chip(board.white, 4)
        board.place_chip(board.black, 4)
        board.place_chip(board.white, 4)
        board.place_chip(board.black, 4)
        board.place_chip(board.black, 1)
        board.place_chip(board.black, 2)
        board.place_chip(board.black, 3)
        board.place_chip(board.black, 4)
        winner = board.check_if_diagonal_winner

        expect(winner).to eq(board.black)
      end
    end
    context 'when someone wins with four in a diagonal backward' do
      subject(:board) { described_class.new }
      it 'declares a winner backwards' do
        board.place_chip(board.white, 1)
        board.place_chip(board.black, 1)
        board.place_chip(board.white, 1)
        board.place_chip(board.black, 1)
        board.place_chip(board.white, 2)
        board.place_chip(board.black, 2)
        board.place_chip(board.white, 2)
        board.place_chip(board.black, 3)
        board.place_chip(board.white, 3)
        board.place_chip(board.black, 4)

        board.place_chip(board.black, 1)
        board.place_chip(board.black, 2)
        board.place_chip(board.black, 3)
        board.place_chip(board.black, 4)

        winner = board.check_if_diagonal_winner

        expect(winner).to eq(board.black)
      end
    end

    context 'when someone has random colors there is no winner' do
      subject(:board) { described_class.new }
      it 'winner is nil' do
        board.place_chip(board.white, 1)
        board.place_chip(board.black, 1)
        board.place_chip(board.white, 1)
        board.place_chip(board.black, 1)
        board.place_chip(board.white, 2)
        board.place_chip(board.black, 2)
        board.place_chip(board.white, 2)
        board.place_chip(board.black, 3)
        board.place_chip(board.white, 3)
        board.place_chip(board.black, 4)

        winner = board.check_if_diagonal_winner

        expect(winner).to eq(nil)
      end
    end
  end
end
