load 'SudokuAPI.rb'
load 'Sudoku.rb'
load 'Caze.rb'
grid = Sudoku.create("000000083004800070000000250500090060310700805068010007400901000890563000000407509")

s= SudokuAPI.create(grid)


puts s.sudoku



