class MethodTwinsAndTriplets
	

	@type = "textMethod"
	@step = 0

	def initialize()
		@step,@type=0,"textMethod"

	end
	def textMethod
		@type = "textMethod"
		SudokuAPI.API.assistantMessage=("Cette méthode nous permet de déduire dans quelle partie d'une région peut se trouver un symbole. En effet il n'est pas toujours évident de découvrir dès le début l'emplacement final et définitif. Si un candidat se trouve uniquement par exemple dans la dernière ligne d'une région il se trouvera donc obligatoirement dans cette ligne.")
		@step+=1
	end

	def demoMethod
		@type = "demoMethod"
		if(@step==0)
			SudokuAPI.API.saveSudoku("old");
			gridDemo = "375648129010925070200371000732089060000267000060034792020453917147896235953712648"	
			SudokuAPI.API.setSudoku(Sudoku.create(gridDemo),Sudoku.create(gridDemo),Sudoku.create(gridDemo));
			SudokuAPI.API.assistantMessage=("Bienvenue dans la démo (cliquez sur suivant pour continuer");
		elsif(@step==1)
			SudokuAPI.API.cazeAt(0,4).color=Colors::CL_NUMBER_LOCKED;
			SudokuAPI.API.cazeAt(2,4).color=Colors::CL_NUMBER_LOCKED;
			SudokuAPI.API.cazeAt(6,4).color=Colors::CL_NUMBER;
			SudokuAPI.API.cazeAt(8,4).color=Colors::CL_NUMBER;

			SudokuAPI.API.enableHint(true);

			SudokuAPI.API.assistantMessage=("Les 2 candidats 4, alignés dans cette région (en rouge), donnent la possibilité de supprimer les 4 dans les autres régions de cette ligne (en gris)");
		elsif(@step==2)	
			SudokuAPI.API.loadSudoku("old");
			SudokuAPI.API.assistantMessage=("Bonjour, je suis l'assistant, je suis là pour vous aider");
		end
		@step+=1
	end

	def onSudokuMethod
		@type = "onSudokuMethod"
		if(@step ==0)
			SudokuAPI.API.assistantMessage=("Nous commençons par rechercher un candidat présent uniquement peut importe le nombre de fois dans une ligne dans une région");
		end
		SudokuAPI.API.enableHint(false);

		@step+=1
	end

	def update
		if(@type == "demoMethod")
			self.demoMethod()
		elsif(@type == "onSudokuMethod")
			self.onSudokuMethod()
		end
	end

	
end


