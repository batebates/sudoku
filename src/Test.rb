require "gtk3"
require "gio2"
require "gdk3"
require "pango"
require "test/unit"

require "./view/GridView.rb"
require "./view/SquareView.rb"
require "./view/AssistantView.rb"
require "./view/CSSStyle.rb"
require "./view/Colors.rb"
require "./view/OverlayManager.rb"
require "./view/Header.rb"
require "./view/Menu.rb"

require "./model/AssetManager.rb"
require "./model/Generator.rb"
require "./model/Caze.rb"
require "./model/Sudoku.rb"

=begin
require "./controller/SudokuAPI.rb"
require "./controller/Method.rb"
require "./controller/MethodCrossReduce.rb"
require "./controller/MethodGroupIsolated.rb"
require "./controller/MethodInteractionsRegion.rb"
require "./controller/MethodTwinsAndTriplets.rb"
require "./controller/MethodUniqueCandidate.rb"
=end

class TestSudoku < Test::Unit::TestCase

   def test_caze
 		c = Caze.create(5,4,3)
     	assert_equal(3, c.getValue(),"Verification de la valeur de la case")
     	assert_equal(true,c.candidats['4'],"Test de l'initialisation des candidats n1")
     	assert_equal(true,c.candidats['5'],"Test de l'initialisation des candidats n1")
   end

 	def test_sudoku
 		grid = Sudoku.create("000000083004800070000000250500090060310700805068010007400901000890563000000407509")
 		assert_equal(0,grid.cazeAt(0,5).getValue(),"Test de la valeur d'une case d'un grille")
 		assert_equal(3,grid.setValue(0,5,3),"Test du changement de valeur d'une case")
 		assert_equal(true,grid.valueCheck?(0,5),"Test si une case contient une valeur")
 		assert_equal(false,grid.gridFull(),"Test gridFull")
 	end

 	def test_sudokuAPI
 		grid = Sudoku.create("000000083004800070000000250500090060310700805068010007400901000890563000000407509")
 		s = SudokuAPI.API();
        SudokuAPI.API.initSudoku(grid)

 		#assert_equal(0,s.setColor(0,5,color))
 		#assert_equal(3,s.execMethod(0,5,3))
 		tab = Array.new
 		s.row(3).each do |elt|
 			tab.push(elt.getValue)
 		end

 		assert_equal([5,0,0,0,9,0,0,6,0],tab,"Test row()")

 		tab = Array.new
 		s.column(3).each do |elt|
 			tab.push(elt.getValue)
 		end

 		assert_equal([0,8,0,0,7,0,9,5,4],tab,"Test column")

 		tab = Array.new
 		s.rowColumn(2,3).each do |elt|
 			   tab.push(elt.getValue)
 		end

 		assert_equal([5,0,0,0,9,0,0,6,0,0,4,0,0,0,8,0,0,0],tab,"Test row column")

 		tab = Array.new
 		s.square(0,5).each do |elt|
 			tab.push(elt.getValue)
 		end
 		assert_equal([5,0,0,3,1,0,0,6,8	],tab,"test square()")

 		tab = Array.new
 		s.squareRowColumn(2,3).each do |elt|
 			tab.push(elt.getValue)
 		end

 		assert_equal([5,0,0,3,1,0,0,6,8,0,0,0,0,0,0,2,5,0,0,8,0,0,7,0,9,5,4],tab,"test squareRowColumn")

 		assert_equal(nil,s.assistantMessage("Zbeub\n"))

 		puts s.sudoku
 	end
  grid = Sudoku.create("000000083004800070000000250500090060310700805068010007400901000890563000000407509")
  s= SudokuAPI.API();
  SudokuAPI.API.initSudoku(grid);

  puts s.sudoku
end
