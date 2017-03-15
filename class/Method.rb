load 'SudokuAPI.rb'

class Method

	@sudokuAPI
	@grid
	attr_reader :sudokuAPI
	attr_reader :grid
	private_class_method :new

	def initialize(sudokuAPI)
		self.sudokuAPI = sudokuAPI
		self.grid = sudokuAPI.sudoku.tcaze
	end

	def textMethod
		raise "Ceci est une méthode abstraite. This is an abstact method."
	end

	def demoMethod
		raise "Ceci est une méthode abstraite. This is an abstact method."
	end

	def onSudokuMethod
		raise "Ceci est une méthode abstraite. This is an abstact method."
	end

end
