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
require "observer"
require "./model/AssetManager.rb"
require "./model/Generator.rb"
require "./model/Caze.rb"
require "./model/Sudoku.rb"

require "./controller/SudokuAPI.rb"
=begin
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
     	assert_equal(5, c.x(),"Verification de la valeur de la case")
     	assert_equal(4, c.y(),"Verification de la valeur de la case")
     	assert_equal(3, c.value(),"Verification de la valeur de la case")
     	assert_equal(Colors::CL_BLANK, c.color(),"Verification de la valeur de la case")
     	assert_equal(Colors::CL_BLANK, c.lastColor(),"Verification de la valeur de la case")
     	assert_equal(3, c.getValue(),"Verification de la valeur de la case")
	c.insertValue(6)
     	assert_equal(6,c.getValue(),"Test de l'insertion d'une valeur")
	color=(Colors::CL_NUMBER)
     	assert_equal(Colors::CL_BLANK, c.color(),"Verification de la valeur de la case")
   end

 	def test_sudoku
 		grid = Sudoku.create("000000083004800070000000250500090060310700805068010007400901000890563000000407509")
 		assert_equal(0,grid.cazeAt(0,5).getValue(),"Test de la valeur d'une case d'un grille")
 		assert_equal(3,grid.setValueAt(0,5,3),"Test du changement de valeur d'une case")
 		assert_equal(true,grid.hasValue?(0,5),"Test si une case contient une valeur")
 		assert_equal(false,grid.gridFull(),"Test gridFull")
 	end

 	def test_sudokuAPI
 		grid = Sudoku.create("000000083004800070000000250500090060310700805068010007400901000890563000000407509")
 		s = SudokuAPI.API();
        SudokuAPI.API.setSudoku(grid)

 		#assert_equal(0,s.setColor(0,5,color))
 		#assert_equal(3,s.execMethod(0,5,3))
 		tab = Array.new
 		s.row(3).each do |elt|
 			tab.push(elt.getValue)
 		end

 		assert_equal([0,8,0,0,7,0,9,5,4],tab,"Test row()")

 		tab = Array.new
 		s.column(3).each do |elt|
 			tab.push(elt.getValue)
 		end

 		assert_equal([5,0,0,0,9,0,0,6,0],tab,"Test column")

 		tab = Array.new
 		s.rowColumn(2,3).each do |elt|
 			   tab.push(elt.getValue)
 		end

 		assert_equal([0,8,0,0,7,0,9,5,4,5,0,0,0,9,0,0,6,0],tab,"Test row column")

 		tab = Array.new
 		s.square(0,5).each do |elt|
 			tab.push(elt.getValue)
 		end
 		assert_equal([5,3,0,0,1,6,0,0,8	],tab,"test square()")

 		tab = Array.new
 		s.squareRowColumn(2,3).each do |elt|
 			tab.push(elt.getValue)
 		end

 		assert_equal([5,3,0,0,1,6,0,0,8,0,4,0,0,0,8,0,0,0,5,0,0,0,9,0,0,6,0],tab,"test squareRowColumn")

 		assert_equal(nil,s.assistantMessage("Zbeub\n"))

 		puts s.sudoku
 	end
  grid = Sudoku.create("000000083004800070000000250500090060310700805068010007400901000890563000000407509")
  s= SudokuAPI.API();
  SudokuAPI.API.setSudoku(grid);

  puts s.sudoku
end
