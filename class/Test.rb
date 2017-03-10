load 'SudokuAPI.rb'
load 'Sudoku.rb'
load 'Caze.rb'


require "test/unit"
class TestSudoku < Test::Unit::TestCase

 
  grid = Sudoku.create("005000070400000400000000000000404000000000000000000000000000000000000000000000000")
  s= SudokuAPI.create(grid)
  puts s.sudoku
end
