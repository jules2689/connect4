require "byebug"

class Board
  TOKEN_1 = "\033[33m●\033[0m" # Yellow
  TOKEN_2 = "\033[31m●\033[0m" # Red
  DEFAULT_BOARD = [
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
    [nil, nil, nil, nil, nil, nil, nil],
  ]
  private_constant :DEFAULT_BOARD

  def initialize(board = DEFAULT_BOARD)
    @board = board
  end

  def place_token(token, column)
    row_idx = -1

    if column < 0 || column > @board[0].length - 1
      raise ArgumentError, "There is no column #{column + 1}"
    end

    @board.each.with_index do |row, idx|
      if row[column].nil? && idx == @board.length - 1
        row_idx = idx
        break
      elsif !row[column].nil?
        row_idx = idx - 1
        break
      end
    end

    raise ArgumentError, "Column #{column + 1} is full" if row_idx == -1
    @board[row_idx][column] = token
    [row_idx, column]
  end

  def won?(token, row, column)
    #####
    # down
    #####
    if row <= 2
      d_acc = 1
      d_acc += 1 if @board[row + 1][column] == token
      d_acc += 1 if @board[row + 2][column] == token
      d_acc += 1 if @board[row + 3][column] == token
      return true if d_acc == 4
    end

    #####
    # left/right
    #####
    lr_acc = 1

    col = column - 1
    while col >= column - 3 && col >= 0
      break unless @board[row][col] == token
      lr_acc += 1
      col -= 1
    end

    col = column + 1
    while col <= column + 3 && col < @board[row].length
      break unless @board[row][col] == token
      lr_acc += 1
      col += 1
    end

    return true if lr_acc >= 4

    #####
    # up left / down right
    #####
    ul_dr_acc = 1

    # up left
    col = column - 1
    r = row - 1
    while col >= 0 && r >= 0
      break unless @board[r][col] == token
      ul_dr_acc += 1
      col -= 1
      r -= 1
    end

    # down right
    col = column + 1
    r = row + 1
    while col < @board[row].length && r < @board.length
      break unless @board[r][col] == token
      ul_dr_acc += 1
      col += 1
      r += 1
    end

    return true if ul_dr_acc >= 4

    #####
    # down left / up right
    #####
    dl_ur_acc = 1

    # down left
    col = column - 1
    r = row + 1
    while col >= 0 && r < @board.length
      break unless @board[r][col] == token
      dl_ur_acc += 1
      col -= 1
      r += 1
    end

    # up right
    col = column + 1
    r = row - 1
    while col < @board[row].length && r >= 0
      break unless @board[r][col] == token
      dl_ur_acc += 1
      col += 1
      r -= 1
    end

    return true if dl_ur_acc >= 4

    false
  end

  def full?
    @board.all? do |row|
      !row.any?(&:nil?)
    end
  end

  def print_board
    puts (1..@board[0].length).to_a.join(" ")
    @board.each do |row|
      row.each do |token|
        if token.nil?
          print "_ "
        else
          print "#{token} "
        end
      end
      print "\n"
    end
  end
end
