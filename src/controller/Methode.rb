class Methode

	attr_accessor :step, :type

	def update()
		self.send(@type);
	end

	#===Lance une explication textuelle de la methode
	def textMethod
		raise "Ceci est une methode abstraite. This is an abstact method.";
	end

	#===Lance la methode sur une grille de demonstration
	def demoMethod
		raise "Ceci est une methode abstraite. This is an abstact method.";
	end

	#===Lance la methode sur la grille actuelle
	def onSudokuMethod
		raise "Ceci est une methode abstraite. This is an abstact method.";
	end

	#===Permet d'activer/désactiver le statut Methode qui bloque l'edition de la grille et l'utilisation du menu par l'utilisateur
	#
	# Params:
	# @param b [boolean] true/false active/desactive le statut
	def statutMethod(b)
		SudokuAPI.API.hideMenu(b)
		SudokuAPI.API.sudokuEditable(b)
	end

end
