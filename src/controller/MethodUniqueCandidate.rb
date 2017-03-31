class MethodUniqueCandidate < Methode
	def textMethod
		SudokuAPI.API.assistantMessage=("Dans le cas où un candidat est unique dans une unité, on peut en déduire que la case où il est présent contient bien ce candidat car il ne peut être nul part ailleurs.")
	end

	def demoMethod
		if(@step == nil)
			@step = 0

			@type = "demoMethod"

			SudokuAPI.API.saveSudoku("old");

			#Assistant dit "Voici une démonstration"
			gridDemo = "005000070400000400000000000000404000000000000000000000000000000000000000000000000"

			SudokuAPI.API.setSudoku(Sudoku.create(gridDemo),Sudoku.create(gridDemo),Sudoku.create(gridDemo));
			SudokuAPI.API.enableHint(true)

			SudokuAPI.API.assistantMessage=("Voici une démonstration de la méthode du candidat unique")

			#grisage des cases non importantes
			0.upto(8) do |x|
			 	1.upto(8) do |y|
			 		#SudokuAPI.API.setCazeInvisble(x,y)
			 		SudokuAPI.API.cazeAt(x,y).color=Colors::CL_NUMBER_LOCKED;

				end
			end

			# unite = 0
			# 0.upto(26) do |u|
			# 	candidat = SudokuAPI.API.uniqueCandidate(SudokuAPI.API.nbCandidate(SudokuAPI.API.getUnite(u/9,u%9)))
			# 	if(candidat != 0)
			# 		unite = u
			# 	end
			# end


			#SudokuAPI.API.setColorUnite(unite, Colors::CL_HIGHLIGHT)
			#Assistant dit on va s'occuper de cette ligne
			SudokuAPI.API.assistantMessage=("Nous allons effectuer la méthode sur cette ligne")

		elsif(@step == 1)
			#Mise en valeur de la case
			SudokuAPI.API.cazeAt(4,0).color=Colors::CL_HIGHLIGHT_METHOD;

			#"On peut remarquer que sur cette case machin truc"
			SudokuAPI.API.assistantMessage=("On peut remarquer que 4 est candidat dans cette case et qu'il n'est présent nul par ailleurs dans l'unité.")

		elsif(@step == 2)
			#affichage du chiffre
			SudokuAPI.API.cazeAt(4,0).value=(4)

			SudokuAPI.API.assistantMessage=("On en déduit donc que 4 est le chiffre présent dans cette case.")
		elsif(@step == 3)
			SudokuAPI.API.loadSudoku("old");
			SudokuAPI.API.enableHint(false)
		end

		@step+=1

	end

	def onSudokuMethod
		#TODO
		unite = nil
		#Detection de l'unité où appliquer la méthode
		0.upto(26) do |u|
			candidat = uniqueCandidate(nbCandidate(getUnite(u/9,u%9)))
			if(candidat != 0)
				unite = u
			end
		end
		#dans le cas où rien n'a été détecté
		if unite == nil
			assistantMessage("On ne peut pas appliquer cette méthode sur la grille")
		else
			#Mise en valeur de l'unité où la méthode va s'appliquer
			assistantMessage("On peut appliquer la méthode sur cette unité")
			setColorUnite(unite, CL_NUMBER_LOCKED)

			caze = cazeUniqueCandidate

			#Mise en valeur de la case où le candidat est unique dans l'unité
			assistantMessage("Cette case possède un candidat qui n'est présent qu'une seule fois dans l'unité")
			setColor(caze.x, caze.y, CL_NUMBER)

			#Changement de la valeur de la case
			cazeAt(caze.x,caze.y).value=(candidat)
		end
		#Coloration de la case + explication de l'assistant
	end

end
