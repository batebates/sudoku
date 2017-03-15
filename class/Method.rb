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

	#===Retourne un tableau de 9 cases indiquant le nombre de fois où chaque candidat est présent dans l'unité
	#
	#===Paramètres :
	#* <b>unite</b> : unité à traiter
	def nbCandidate(unite)
		tab = Array.new()
		unite.each{ |g|
            1.upto(9) do |elt|
            if(g[elt.to_s])
            	tab[elt]++
            end
        }
        return tab
	end
	
end
