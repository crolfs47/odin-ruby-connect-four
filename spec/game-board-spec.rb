require './lib/game-board'

describe GameBoard do

  describe '#place_chip' do
    context 'when a player places a chip' do
      subject(:board_move) { described_class.new('⚫', '⚪') }
      it 'should put a chip in the correct column' do
        board_move.place_chip('⚪', 4)
        expect(board_move.board[5]).to eq([nil, nil, nil, '⚪', nil, nil, nil])
      end

      it 'should put a chip on top of an already placed chip' do
        board_move.place_chip('⚪', 2)
        board_move.place_chip('⚫', 2)
        expect(board_move.board[5]).to eq([nil, '⚪', nil, nil, nil, nil, nil])
        expect(board_move.board[4]).to eq([nil, '⚫', nil, nil, nil, nil, nil])
      end
    end
  end

  describe '#check_valid_move' do
    subject(:board) { described_class.new('⚫', '⚪') }
    context 'when a player selects an invalid column' do
      it 'should return false' do
        expect(board).to receive(:puts)

        result = board.check_valid_move?(8)

        expect(result).to eq(false)
      end
    end
    context "when a player selects a column that's already full" do
      it 'should return false' do
        expect(board).to receive(:puts)

        board.place_chip('⚪', 2)
        board.place_chip('⚪', 2)
        board.place_chip('⚪', 2)
        board.place_chip('⚪', 2)
        board.place_chip('⚪', 2)
        board.place_chip('⚪', 2)
        result = board.check_valid_move?(2)

        expect(result).to eq(false)
      end
    end
    context 'when a player selects a valid column' do
      it 'should return true' do
        result = board.check_valid_move?(6)

        expect(result).to eq(true)
      end
    end
  end

  describe '#check_if_winner' do
    context 'when someone wins with four in a row' do
      subject(:board) { described_class.new('⚫', '⚪') }
      it 'returns true' do
        board.place_chip(board.black, 1)
        board.place_chip(board.black, 2)
        board.place_chip(board.black, 3)
        board.place_chip(board.black, 4)

        row_winner = board.check_row_winner
        winner = board.check_winner

        expect(row_winner).to eq(true)
        expect(winner).to eq(true)
      end
    end

    context 'when someone wins with four in a column' do
      subject(:board) { described_class.new('⚫', '⚪') }
      it 'returns true' do
        board.place_chip(board.black, 2)
        board.place_chip(board.black, 2)
        board.place_chip(board.black, 2)
        board.place_chip(board.black, 2)

        column_winner = board.check_column_winner
        winner = board.check_winner

        expect(column_winner).to eq(true)
        expect(winner).to eq(true)
      end
    end

    context 'when there is not a column winner' do
      subject(:board) { described_class.new('⚫', '⚪') }
      it 'returns false' do
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

        column_winner = board.check_column_winner
        winner = board.check_winner

        expect(column_winner).to eq(false)
        expect(winner).to eq(false)
      end
    end

    context 'when someone wins with four in a forward diagonal' do
      subject(:board) { described_class.new('⚫', '⚪') }
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

        diagonal_winner = board.check_forward_diagonal_winner
        winner = board.check_winner
        
        expect(diagonal_winner).to eq(true)
        expect(winner).to eq(true)
      end
    end
    context 'when someone wins with four in a backward diagonal' do
      subject(:board) { described_class.new('⚫', '⚪') }
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

        diagonal_winner = board.check_backward_diagonal_winner
        winner = board.check_winner

        expect(diagonal_winner).to eq(true)
        expect(winner).to eq(true)
      end
    end

    context 'when someone has random colors there is no winner' do
      subject(:board) { described_class.new('⚫', '⚪') }
      it 'returns false' do
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

        row_winner = board.check_row_winner
        winner = board.check_winner

        expect(row_winner).to eq(false)
        expect(winner).to eq(false)
      end
    end
  end
end
