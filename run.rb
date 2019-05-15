require_relative "board"

board = Board.new
current_player = Board::TOKEN_1
winner = nil

# Game Play
until board.full?
  puts "\033c" # Clear the screen

  board.print_board
  puts "(Current Player: #{current_player}) What column would you like to put your token in?"

  col, row = -1
  begin
    col = gets.chomp
    raise ArgumentError, "#{col} is not a column" unless col =~ /\d+/
    col = col.to_i - 1

    row, col = board.place_token(current_player, col)
  rescue ArgumentError => e
    puts "=" * 20
    puts e
    puts "Please try again Player #{current_player}"
    puts "=" * 20
    retry
  end

  if board.won?(current_player, row, col)
    winner = current_player
    break
  end

  current_player = current_player == Board::TOKEN_1 ? Board::TOKEN_2 : Board::TOKEN_1
end

# End Game
puts "\033c" # Clear the screen
board.print_board
if board.full? && !won
  puts "It was a draw!"
else
  puts "Winner: #{winner}"
end
