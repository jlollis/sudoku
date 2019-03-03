# sudoku.rb - by Julie Lollis 

# Description: Loads a text file containing a sudoku puzzle and allows user to solve
# the puzzle by entering a value for each row and column.

# At this stage, it just records the entry, and prints the board with the updated values until
# there are no remaining squares on the board. Does not check if the entry is the correct value.
# In that sense, it is the digital equivalent to the puzzle book you might purchase in the supermarket checkout. 
# (but with less puzzles, lol) You can add additional text files, there is a lot of room for expansion on this one.

# But at least it works, and comes with instructions in case anyone would like to use this, or build upon it.

# How to Play:
# Open your terminal and type:
# ruby sudoku.rb
# Then, follow the prompts. Have fun! ;)

require 'colorize'
require 'terminal-table'

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
    
    puts "Please enter the row, column and value for your selection."
    print "row: "
    row = gets.chomp.to_i
    print "column: "
    col = gets.chomp.to_i
    print "value: "
    val = gets.chomp.to_s
    puts

    @grid[row-1][col-1] = val
    #return "#{@grid[col][row]}"
    
  end

  # render current board state
  def render
    values = @grid

    # table = Terminal::Table.new :headings => [' ', 1, 2, 3, 4, 5, 6, 7, 8, 9 ], :rows => rows
    table = Terminal::Table.new do |t|
  
      t << [' ', 1, 2, 3, 4, 5, 6, 7, 8, 9 ]
      t << :separator
      
      values.each do |row|

        row.each do |cell|
          if "#{cell}".match?(/[0]/)
            print " #{cell} ".light_black
          else
            print " #{cell} ".blue
          end
        end
        puts  # adds newline at end of row
      end
    puts  # adds newline at end of board
  end
  

  def solved?
    # are there any tiles on the board that are not equal to zero?
    if grid.flatten.each.include?(0)
      return false
    else
      puts "You solved the puzzle! :)"
      return true
    end
  end

  def welcome
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

  def self.to_s
    # if tile is equal to zero, then it is not given
    # also color color code starting values (givens) and the correct guesses

  end


end

class Game < Board
  # Game should have an instance variable for the Board
  @grid = []

  # methods for managing the Board-Player interaction
  def play

    # loop that runs until puzzle is solved
    b = Board.new
    
    # ascii title splash
    b.welcome 

    b.populate_array("sudoku1.txt")

    # inside loop:
        until b.solved?
          # render board
          b.render
          # get position and value from the player, update position and value
          b.update_position
        end

  end

end



game = Game.new

game.play
