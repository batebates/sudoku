load 'SudokuAPI.rb'

class Method

	@grid

	private_class_method :new

	def initialize(grid)
		self.grid = grid
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

