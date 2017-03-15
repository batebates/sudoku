class MethodInteractionsRegion < Method

	def textMethod
		return "Dans le cas où un candidat est unique dans une unité, on peut en déduire que la case où il est présent contient bien ce candidat car il ne peut être nul part ailleurs."
	end

	def demoMethod
		#TODO
		fileName = "DeathStar"
		@sudoku.saveSudoku(fileName)
		gridDemo = "005000070400000400000000000000404000000000000000000000000000000000000000000000000"
			
		#load grille demo
		#grisation des cases non importantes
		#Assistant dit on va s'occuper de cette ligne
		#Mise en valeur de la case
		#"On peut remarquer que sur cette case machin truc"
		#affichage du chiffre
		#"Et voilà le résultat"
		#Rechargement de la grille normale
	end

	def onSudokuMethod
		#TODO
		#Detection d'un endroit où appliquer la méthode
		#Coloration de la case + explication de l'assistant
	end
end