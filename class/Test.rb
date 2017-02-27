load 'SudokuAPI.rb'
load 'Sudoku.rb'
load 'Caze.rb'


require "test/unit"
 
class TestSudoku < Test::Unit::TestCase
 
  def test_caze
		c = Caze.create(5,4,3)
    assert_equal(3, c.getValue() )
    c.candidats.each do |elt|
			assert_equal(true,elt[1])
		end
  end

	def test_sudoku
		grid = Sudoku.create("000000083004800070000000250500090060310700805068010007400901000890563000000407509")
		assert_equal(0,grid.cazeAt(0,5).getValue())
		assert_equal(3,grid.setValue(0,5,3))
		assert_equal(true,grid.valueCheck?(0,5))
		assert_equal(false,grid.gridFull())
	end

	def test_sudokuAPI
		grid = Sudoku.create("000000083004800070000000250500090060310700805068010007400901000890563000000407509")
		s= SudokuAPI.create(grid)

		#assert_equal(0,s.setColor(0,5,color))
		#assert_equal(3,s.execMethod(0,5,3))
		tab = Array.new
		s.row(3).each do |elt|
			tab.push(elt.value)
		end
		assert_equal([5,0,0,0,9,0,0,6,0],tab)

		tab = Array.new
		s.column(3).each do |elt|
			tab.push(elt.value)
		end
		assert_equal([0,8,0,0,7,0,9,5,4],tab)
		
		tab = Array.new
		s.rowColumn(2,3).each do |elt|
			tab.push(elt.value)
		end
		assert_equal([5,0,0,0,9,0,0,6,0,0,4,0,0,0,8,0,0,0],tab)
		
		tab = Array.new
		s.square(0,5).each do |elt|
			tab.push(elt.value)
		end
		assert_equal([5,0,0,3,1,0,0,6,8	],tab)
		
		tab = Array.new
		s.squareRowColumn(2,3).each do |elt|
			tab.push(elt.value)
		end
		assert_equal([5,0,0,0,9,0,0,6,0,0,4,0,0,0,8,0,0,0,5,0,0,3,1,0,0,6,8],tab)

		assert_equal(nil,s.assistantMessage("Zbeub\n"))
		
		puts s.sudoku
	end
grid = Sudoku.create("000000083004800070000000250500090060310700805068010007400901000890563000000407509")
s= SudokuAPI.create(grid)
 puts s.sudoku
end







