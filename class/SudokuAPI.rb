load 'Caze.rb'
class SudokuAPI
	@sudoku
	attr_reader :sudoku
	
	

	private_class_method :new
    
	def SudokuAPI.create(sudoku)
		new(sudoku)
	end
	
	def initialize(sudoku)
		@sudoku=sudoku
	end
	
	def setColor(x,y,color)
	end

	def execMethod(meth)
	end

	def row(y)
		tab = Array.new()
		0.upto(8) do |i|
			tab<<@sudoku.cazeAt(y,i)
		end
		return tab	
	end

	def column(x)
		tab = Array.new()
		0.upto(8) do |i|
			tab<<@sudoku.cazeAt(i,x)
		end
		return tab	
	end

	def rowColumn(x,y)
		return self.row(y) << self.column(x)
	end

	def square(x,y)
		x -=x%3
		y -=y%3
		res = Array.new()
		0.upto(2) do |i|
			0.upto(2) do |j|
                #tab<<@sudoku.cazeAt(y+i,x+j)
			end
		end
	end

	def squarerowcolumn(x,y)
		return square(x,y)<< row(x)<< column(y)
	end
	
	def assistantMessage(str)
		print str
	end
	
	
	def to_s()
		cpt=0
		@sudoku.tcaze().each do |elt|
			print elt.to_s + " "
			cpt += 1
			if cpt%9==0
				print "\n"
			end
		end
	end
	
end
