# sudoku.rb - by Julie Lollis 

# Description: Loads a text file containing a sudoku puzzle and allows user to solve
# the puzzle by entering a value for each row and column. 

# The values entered by the player are printed in yellow to distinguish it from the starting values.

# At this stage, the program just stores the values entered, and prints the board with the updated values until
# there are no remaining squares on the board. It does not check if the entry is the correct value. 

# In that sense, it is the digital equivalent to the puzzle book you might purchase in the supermarket checkout. 
# (but with less puzzles, lol) You can add additional text files, there is a lot of room for expansion on this one.

# But at least it works, and comes with instructions in case anyone would like to use this, or build upon it.

# How to Play:
# Open your terminal and type:
# ruby sudoku.rb
# Then, follow the prompts. Have fun! ;)

require 'colorize'

class Board 
  attr_accessor :grid

  def initialize
    @rows = 9
    @value = nil
    @grid = grid
  end

  def generate_board(rows, value)
    board = Array.new(rows)
    rows.times do |row_idx|
      board[row_idx] = Array.new(rows)
      rows.times do |col_idx|
        board[row_idx][col_idx] = value
      end
    end
    board
  end  

  def populate_array(file)
    @grid = []
    File.open(file).map do |line|
      @grid << line.chomp.split('').map(&:to_i)
    end
    @grid
  end

  # update the value of a Tile to the given postition
  def update_position
    # update selection for grid[col][row]
    #puts "#{@grid[2][0]}"
    
    puts "Please enter the and row, column for your selection."
    print "row: "
    row = gets.chomp.to_i
    print "column: "
    col = gets.chomp.to_i
    print "value: "
    val = gets.chomp.to_s
    puts

    @grid[row][col] = val

  end

  # render current board state
  def render
    # puts "\e[H\e[2J"

    values = @grid
    puts "       +---+---+---+---+---+---+---+---+---+".light_black
    values.each do |row|
      print "       |".light_black
      row.each_with_index do |value, idx|
        if idx >= 1
          print "|".light_black
        end
        # color coding output to cells
        if " #{value} ".match?(/[0]/)  # open spaces are printed in black
          print " #{value} ".black   
        elsif value.is_a? String   # values changed by player are printed in yellow
          print " #{value} ".light_yellow
        else
          print " #{value} ".light_blue  # OG values are printed in blue
        end
      end
      print "|\n".light_black
      puts "       +---+---+---+---+---+---+---+---+---+".light_black
    end
    puts  # adds newline at end of board
  end
  

  def solved?
    # are there any tiles on the board that are not equal to zero?
    if grid.flatten.each.include?(0)
      return false
    else
      puts "          You completed the puzzle! Yay!!".light_green
      puts
      puts "                  ※\\( ﾟᴗﾟ)/※       ".green
      puts
      return true
    end
  end

  def splash
    title = %q{
                         __     __       
            ___ __ _____/ /__  / /____ __
           (_-</ // / _  / _ \/  '_/ // /
          /___/\_,_/\_,_/\___/_/\_\\\_,_/ 
          
}.light_blue

    print title

  end

end

class Tile < Board
  attr_accessor :value, :given

  def initialize
    @value = 0
    @given = false
  end

  def values
    @values
  end 

end

class Game < Board
  # Game should have an instance variable for the Board
  @grid = []

  # methods for managing the Board-Player interaction
  def play

    # loop that runs until puzzle is solved
    b = Board.new

    b.populate_array("sudoku1.txt")

    # inside loop:
        until b.solved?
          # clear screen
          system "clear"
          # ascii title splash
          b.splash 
          # render board
          b.render
          # get position and value from the player, update position and value
          b.update_position
        end

  end

end



game = Game.new

game.play
