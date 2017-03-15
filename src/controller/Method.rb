class Method

	@sudokuAPI
	@grid
	attr_reader :sudokuAPI
	attr_reader :grid

	def initialize(sudokuAPI)
		self.sudokuAPI = sudokuAPI
		self.grid = sudokuAPI.sudoku.tcaze
	end

	def textMethod
		raise "Ceci est une methode abstraite. This is an abstact method.";
	end

	def demoMethod
		raise "Ceci est une methode abstraite. This is an abstact method.";
	end

	def onSudokuMethod
		raise "Ceci est une methode abstraite. This is an abstact method.";
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
            		tab[elt]+=1
            	end
            end
        }
        return tab
	end

	#===Indique si une unite comprend un candidat présent une seule fois
	#
	#===Paramètres :
	#* <b>unite</b> : unité à traiter
	def uniqueCandidate(unite)
		tab = nbCandidate(unite)
		tab.each{ |c|
			if(c == 1)
				return true
			end
		}
		return false
	end
end
