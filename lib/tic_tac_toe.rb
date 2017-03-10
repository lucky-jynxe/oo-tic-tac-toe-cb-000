class TicTacToe
  def initialize
    @board = Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], # Bottom row
    [0,3,6], # Left column
    [1,4,7], # Middle column
    [2,5,8], # Right column
    [0,4,8], # Top-left diagonal
    [6,4,2]  # Bottom-left diagonal
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, char)
    @board[index] = char
    @board
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0, 8) && !position_taken?(index)
  end

  def turn_count
    @board.count{|cell| cell == "X" || cell == "O"}
  end

  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end

  def turn
    loop do
      puts "Please enter 1-9:"
      user_input = gets
      index = input_to_index(user_input)
      if valid_move?(index)
        move(index, current_player)
        display_board
        break
      end
    end
  end

  def won?
      WIN_COMBINATIONS.any? do |combination|
        if combination.all?{|position| @board[position] == "X"} || combination.all?{|position| @board[position] == "O"}
          return combination
        end
      end
  end

  def full?
    !(@board.include?(" ") || @board.include?(nil))
  end

  def draw?
    !won? && full?
  end

  def over?
    draw? || won?
  end

  def winner
    winning_combo = won?
    @board[winning_combo[0]] if winning_combo 
  end

  def play
    turn until over?
    winner ? (puts "Congratulations #{winner}!") : (puts "Cat's Game!")
  end
end
