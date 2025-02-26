WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]


def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end


def input_to_index(user_input)
  user_input.to_i - 1
end


def move(board, index, current_player)
  board[index] = current_player
end


def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end


def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
      turn(board)
  end
end


def play(board)
  
  amount_turns = 9
  the_turn = 0
  
  while !over?(board) 
    turn(board)
    the_turn += 1
  end 
    
  if won?(board)
    who_won = winner(board)
    puts "Congratulations #{who_won}!"
  elsif full?(board)
    puts "Cat's Game!"
  end
end


def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end


def won?(board)
  WIN_COMBINATIONS.detect do |i|
    board[i[0]] == board[i[1]] && 
    board[i[1]] == board[i[2]] && 
    position_taken?(board, i[0])
  end
end


def full?(board)
  board.all?{|i| i=="X" || i =="O"}
end


def draw?(board)
  if full?(board) && !won?(board)
    true
  end
end


def over?(board)
  if won?(board) || full?(board) || draw?(board)
    true
  elsif won?(board) && !full?(board)
    true
  else 
    
  end
end


def turn_count(board)
  number_turns = 0
  board.each do |box|
    if box == "X" || box == "O"
      number_turns += 1
    end
  end
  number_turns
end


def current_player(board)
  if turn_count(board) == 0 || turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end


def winner(board)
  if combo = won?(board)
    board[combo[0]]
  end
end