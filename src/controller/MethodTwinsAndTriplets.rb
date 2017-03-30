class MethodTwinsAndTriplets
	
	def textMethod
		SudokuAPI.API.assistantMessage("Cette méthode nous permet de déduire dans quelle partie d'une région peut se trouver un symbole. En effet il n'est pas toujours évident de découvrir dès le début l'emplacement final et définitif. Si un candidat se trouve uniquement par exemple dans la dernière ligne d'une région il se trouvera donc obligatoirement dans cette ligne.")
	end

	def demoMethod
		gridDemo = "375648129010925070200371000732089060000267000060034792020453917147896235953712648"	

		new_=SudokuAPI.API
		new_.setSudoku(Sudoku.create(gridDemo));

		new_.assistantMessage=("Bienvenue dans la démo");
		sleep(0.5);

		new_.cazeAt(0,4).color=Colors::CL_NUMBER_LOCKED;
		new_.cazeAt(2,4).color=Colors::CL_NUMBER_LOCKED;
		new_.cazeAt(6,4).color=Colors::CL_NUMBER;
		new_.cazeAt(8,4).color=Colors::CL_NUMBER;

		new_.enableHint(true);

		new_.assistantMessage=("Les 2 candidats 4, alignés dans cette région (en rouge), donnent la possibilité de supprimer les 4 dans les autres régions de cette ligne (en gris)");
		sleep(2);

		Window.init();

	end

	def onSudokuMethod(sudokuAPI)
		sudokuAPI.assistantMessage=("Nous commençons par rechercher un candidat présent uniquement peut importe le nombre de fois dans une ligne dans une région");
		
	end

	
end


