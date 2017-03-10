load 'SudokuAPI.rb'
load 'Sudoku.rb'
load 'Caze.rb'


require "test/unit"
class TestSudoku < Test::Unit::TestCase

 
  grid = Sudoku.create("300060000050000000106000050000040000000100030200000000000007006080000090900050010")
  s= SudokuAPI.create(grid)
  puts s.sudoku
end
