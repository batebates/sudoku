class MethodTwinsAndTriplets


	
	def textMethod
		SudokuAPI.API.assistantMessage("Cette méthode nous permet de déduire dans quelle partie d'une région peut se trouver un symbole. En effet il n'est pas toujours évident de découvrir dès le début l'emplacement final et définitif. Si un candidat se trouve uniquement par exemple dans la dernière ligne d'une région il se trouvera donc obligatoirement dans cette ligne.")
	end

	def demoMethod
		gridDemo = "375648129010925070200371000732089060000267000060034792020453917147896235953712648"	

		#new_ = SudokuAPI.API.setSudoku(gridDemo);
		new_=SudokuAPI.API
		new_.setSudoku(Sudoku.create(gridDemo));
		new_.assistantMessage



		#grisation des cases non importantes


		new_.cazeAt(0,4).color=Colors::CL_NUMBER_LOCKED;
		new_.cazeAt(2,4).color=Colors::CL_NUMBER_LOCKED;
		new_.cazeAt(6,4).color=Colors::CL_NUMBER;
		new_.cazeAt(8,4).color=Colors::CL_NUMBER;

		new_.assistantMessage=("Les 2 candidats 4, alignés dans cette région (jumeaux), donnent la possibilité de supprimer les 4 dans les autres régions de cette ligne");
		Window.init();
		 
		#Assistant dit on va s'occuper de cette ligne
		#new_.assistantMessage=("nous allons nous occuper de cette ligne");

		#Mise en valeur de la case
		#"On peut remarquer que sur cette case machin truc"
		#new_.assistantMessage=("nous allons nous occuper de cette ligne");

		#affichage du chiffre
		#"Et voilà le résultat"
		#Rechargement de la grille normale
	end

	def onSudokuMethod
		
		#Detection d'un endroit où appliquer la méthode
		#Coloration de la case + explication de l'assistant
	end
end


