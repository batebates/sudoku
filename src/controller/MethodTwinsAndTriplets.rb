class MethodTwinsAndTriplets



	def textMethod
		SudokuAPI.API.assistantMessage("Cette méthode nous permet de déduire dans quelle partie d'une région peut se trouver un symbole. En effet il n'est pas toujours évident de découvrir dès le début l'emplacement final et définitif. Si un candidat se trouve uniquement par exemple dans la dernière ligne d'une région il se trouvera donc obligatoirement dans cette ligne.")
	end

	def demoMethod
		fileName = "DeathStar"
		#@sudoku.saveSudoku(fileName)
		gridDemo = "375648129010925070200371000732089060000267000060034792020453917147896235953712648"	

		#new_ = SudokuAPI.API.setSudoku(gridDemo);
		new_=SudokuAPI.API.setSudoku(Sudoku.create(gridDemo));
		Window.init();
		#grisation des cases non importantes

		0.upto(8) do |x|
			3.upto(8) do |y|
				new_.sudoku.cazeAt(x,y).color=CL_NUMBER_LOCKED;
			end
		end
		bite 
		#Assistant dit on va s'occuper de cette ligne
		new_.assistantMessage=("nous allons nous occuper de cette ligne");

		#Mise en valeur de la case
		#"On peut remarquer que sur cette case machin truc"
		new_.assistantMessage=("nous allons nous occuper de cette ligne");

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


