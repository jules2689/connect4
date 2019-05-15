require "minitest/autorun"
require_relative "board"

class BoardTest < Minitest::Test
  FULL_TEST = [
    ["a", "a", "a", "a"],
    ["a", "a", "a", "a"],
    ["a", "a", "a", "a"],
  ]

  DOWN_TEST = [
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, Board::TOKEN_1, nil, nil, nil, nil],
    [nil, nil, Board::TOKEN_1, nil, nil, nil, nil],
    [nil, nil, Board::TOKEN_1, nil, nil, nil, nil],
    [nil, nil, Board::TOKEN_1, nil, nil, nil, nil],
  ]

  LEFT_RIGHT_TEST = [
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [Board::TOKEN_1, Board::TOKEN_1, Board::TOKEN_1, Board::TOKEN_1, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
  ]

  LEFT_RIGHT_TEST_GAP = [
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [Board::TOKEN_1, nil, Board::TOKEN_1, Board::TOKEN_1, Board::TOKEN_1, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
  ]

  UPLEFT_DOWNRIGHT_TEST = [
    [Board::TOKEN_1, nil, nil, nil, nil, nil, nil],
    [nil, Board::TOKEN_1, nil, nil, nil, nil, nil],
    [nil, nil, Board::TOKEN_1, nil, nil, nil, nil],
    [nil, nil, nil, Board::TOKEN_1, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
  ]

  UPLEFT_DOWNRIGHT_TEST_GAP = [
    [Board::TOKEN_1, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, Board::TOKEN_1, nil, nil, nil, nil],
    [nil, nil, nil, Board::TOKEN_1, nil, nil, nil],
    [nil, nil, nil, nil, Board::TOKEN_1, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
  ]

  DOWNLEFT_UPRIGHT_TEST = [
    [nil, nil, nil, nil, Board::TOKEN_1, nil, nil],
    [nil, nil, nil, Board::TOKEN_1, nil, nil, nil],
    [nil, nil, Board::TOKEN_1, nil, nil, nil, nil],
    [nil, Board::TOKEN_1, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
  ]

  DOWNLEFT_UPRIGHT_TEST_GAP = [
    [nil, nil, nil, nil, Board::TOKEN_1, nil, nil],
    [nil, nil, nil, Board::TOKEN_1, nil, nil, nil],
    [nil, nil, Board::TOKEN_1, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [Board::TOKEN_1, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
  ]

  def test_down
    b = Board.new(DOWN_TEST)
    assert b.won?(Board::TOKEN_1, 2, 2)
  end

  def test_left
    b = Board.new(LEFT_RIGHT_TEST)
    assert b.won?(Board::TOKEN_1, 2, 3)
  end

  def test_right
    b = Board.new(LEFT_RIGHT_TEST)
    assert b.won?(Board::TOKEN_1, 2, 0)
  end

  def test_left_right
    b = Board.new(LEFT_RIGHT_TEST)
    assert b.won?(Board::TOKEN_1, 2, 1)
  end

  def test_left_right_with_gaps
    b = Board.new(LEFT_RIGHT_TEST_GAP)
    refute b.won?(Board::TOKEN_1, 2, 2)
  end

  def test_up_left
    b = Board.new(UPLEFT_DOWNRIGHT_TEST)
    assert b.won?(Board::TOKEN_1, 3, 3)
  end

  def test_down_right
    b = Board.new(UPLEFT_DOWNRIGHT_TEST)
    assert b.won?(Board::TOKEN_1, 0, 0)
  end

  def test_up_left_down_right
    b = Board.new(UPLEFT_DOWNRIGHT_TEST)
    assert b.won?(Board::TOKEN_1, 1, 1)
  end

  def test_up_left_down_right_gap
    b = Board.new(UPLEFT_DOWNRIGHT_TEST_GAP)
    refute b.won?(Board::TOKEN_1, 2, 2)
  end

  def test_down_left
    b = Board.new(DOWNLEFT_UPRIGHT_TEST)
    assert b.won?(Board::TOKEN_1, 0, 4)
  end

  def test_up_right
    b = Board.new(DOWNLEFT_UPRIGHT_TEST)
    assert b.won?(Board::TOKEN_1, 3, 1)
  end

  def test_down_left_up_right
    b = Board.new(DOWNLEFT_UPRIGHT_TEST)
    assert b.won?(Board::TOKEN_1, 2, 2)
  end

  def test_down_left_up_right_gap
    b = Board.new(DOWNLEFT_UPRIGHT_TEST_GAP)
    refute b.won?(Board::TOKEN_1, 2, 2)
  end

  def test_no_win
    b = Board.new(DOWNLEFT_UPRIGHT_TEST)
    refute b.won?(Board::TOKEN_1, 2, 5)

    b = Board.new(UPLEFT_DOWNRIGHT_TEST)
    refute b.won?(Board::TOKEN_1, 2, 5)

    b = Board.new(DOWN_TEST)
    refute b.won?(Board::TOKEN_1, 2, 5)

    b = Board.new(LEFT_RIGHT_TEST)
    refute b.won?(Board::TOKEN_1, 2, 5)
  end

  def test_full
    b = Board.new(FULL_TEST)
    assert_predicate b, :full?
  end
end
