class MethodUnicite


	@type = "textMethod"
	@step = 0

	def initialize()
		@step,@type=0,"textMethod"

	end
	def textMethod
		@type = "textMethod"
    case step
    when 0
      SudokuAPI.API.assistantMessage=("Cette méthode repose sur le principe qu'un sudoku possède une unique Solution")
    when 1
      SudokuAPI.API.assistantMessage=("Ainsi si Quatres cellules dans deux régions différentes forme un rectangle comporte une paire de candidats identique sur trois de ces cellules ")
    when 2
      SudokuAPI.API.assistantMessage=("Et que la quatrième comporte cette paire ainsi que d'autres candidats")
    when 3
      SudokuAPI.API.assistantMessage=("Alors la solution de cette cellule est forcement parmis ces candidats en plus.")
    when 4
      SudokuAPI.API.assistantMessage=("En effet la grille possède une solution unique, il ne peut pas y avoir 4 paires identiques formant un rectangle sur deux regions differentes")
    end
		@step+=1
	end

	def demoMethod
		@type = "demoMethod"
  case @step
  when 0
			SudokuAPI.API.saveSudoku("old");
			gridDemo = "375648129010925070200371000732089060400267000060034792020453917147896235953712648"
			SudokuAPI.API.setSudoku(Sudoku.create(gridDemo),Sudoku.create(gridDemo),Sudoku.create(gridDemo));
			SudokuAPI.API.assistantMessage=("Bienvenue dans la démo (cliquez sur suivant pour continuer");
	when 1
			SudokuAPI.API.cazeAt(0,1).color=Colors::CL_NUMBER_LOCKED;
			SudokuAPI.API.cazeAt(2,1).color=Colors::CL_NUMBER;
			SudokuAPI.API.cazeAt(0,6).color=Colors::CL_NUMBER_LOCKED;
			SudokuAPI.API.cazeAt(2,6).color=Colors::CL_NUMBER_LOCKED;

			SudokuAPI.API.enableHint(true);

			SudokuAPI.API.assistantMessage=("Les quatres cases colorées possèdent la même paire de candidats 6 et 8 ");
    when 2
      SudokuAPI.API.assistantMessage=("Comme la solution d'un sudoku est unique, la case grisé qui possède des candidats en plus de la paire n'a pour solution que ces candidats");
    when 3
      SudokuAPI.API.assistantMessage=("On peut donc éliminer la paire de candidat de cette cellule");
    when 4
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
