class MethodTwinsAndTriplets < Method

	def textMethod
		return "Cette méthode nous permet de déduire dans quelle partie d'une région peut se trouver un symbole. En effet il n'est pas toujours évident de découvrir dès le début l'emplacement final et définitif. Si un candidat se trouve uniquement par exemple dans la dernière ligne d'une région il se trouvera donc obligatoirement dans cette ligne."
	end

	def demoMethod
		print "coucou"
		fileName = "DeathStar"
		@sudoku.saveSudoku(fileName)
		gridDemo = "005000070400000400000000000000404000000000000000000000000000000000000000000000000"	

		new_ = SudokuAPI.API.initSudoku(gridDemo);
		#grisation des cases non importantes

		0.upto(8) do |x|
			3.upto(8) do |y|
				#new_.sudoku.cazeAt(x,y).color=CL_NUMBER_LOCKED;
			end
		end
		#Assistant dit on va s'occuper de cette ligne
		new_assistantMessage=("nous allons nous occuper de cette ligne");

		#Mise en valeur de la case
		#"On peut remarquer que sur cette case machin truc"
		new_assistantMessage=("nous allons nous occuper de cette ligne");

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


