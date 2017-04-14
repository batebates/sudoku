#<b>Auteur  :</b> Laville Martin
#
#<b>Version :</b> 1.0
#
#<b>Date    :</b> 04/04/2017
#
#=== Contient les Methodes permettant d'applique la méthode du candidat unique
#* textMethod
#* demoMethod
#* onSudokuMethod
#</b>


class MethodUniqueCandidate < Methode

	@@caze = nil
	@@candidat = nil

	#===Lance une explication textuelle de la methode
	def textMethod
		if(@step == nil)
			statutMethod(false)
			@step = 0
			@type = "textMethod"
			SudokuAPI.API.assistantMessage=("Dans le cas où un candidat est unique dans une unité, on peut en\ndéduire que la case où il est présent contient bien ce candidat car\nil ne peut être nul part ailleurs. (Appuyez sur Suivant)")
		elsif(@step == 1)
			SudokuAPI.API.assistantMessage=("Bonjour, je suis l'assistant, je suis là pour vous aider")
			statutMethod(false)
		end
		@step+=1
	end

	#===Lance la methode sur une grille de demonstration
	def demoMethod
		if(@step == nil)
			statutMethod(true)

			@step = 0

			@type = "demoMethod"

			SudokuAPI.API.saveSudoku("old");

			#Assistant dit "Voici une démonstration"
			gridDemo = "005000070400000400000000000000404000000000000000000000000000000000000000000000000"

			SudokuAPI.API.setSudoku(Sudoku.create(gridDemo),Sudoku.create(gridDemo),Sudoku.create(gridDemo));


			SudokuAPI.API.sudokuEditable(true)

			SudokuAPI.API.assistantMessage=("Voici une démonstration de la méthode du candidat unique. \n(Appuyez sur Suivant)")

			#grisage des cases non importantes
			0.upto(8) do |x|
				1.upto(8) do |y|
			 		#SudokuAPI.API.setCazeInvisble(x,y)
			 		SudokuAPI.API.cazeAt(x,y).color=Colors::CL_NUMBER_LOCKED;
				end
			end

			0.upto(8) do |x|
				SudokuAPI.API.setHintAt(x,0,true)
			end

				#Assistant dit on va s'occuper de cette ligne
				SudokuAPI.API.assistantMessage=("Nous allons effectuer la méthode sur cette ligne. \n(Appuyez sur Suivant)")

		elsif(@step == 1)
			#Mise en valeur de la case
			SudokuAPI.API.cazeAt(4,0).color=Colors::CL_HIGHLIGHT_METHOD;

			#"On peut remarquer que sur cette case machin truc"
			SudokuAPI.API.assistantMessage=("On peut remarquer que 4 est candidat dans cette case et\nqu'il n'est présent nul par ailleurs dans l'unité. \n(Appuyez sur Suivant)")

		elsif(@step == 2)
			#affichage du chiffre
			SudokuAPI.API.cazeAt(4,0).value=(4)
			SudokuAPI.API.assistantMessage=("On en déduit donc que 4 est le chiffre présent dans cette case. \n(Appuyez sur Suivant)")

		elsif(@step == 3)
			#Chargement de la grille précédente
			SudokuAPI.API.loadSudoku("old");
			statutMethod(false)
			SudokuAPI.API.assistantMessage=("Bonjour, je suis l'assistant, je suis là pour vous aider.")

		end

		@step+=1

	end

	def onSudokuMethod


		if(@step == nil)
			statutMethod(true)

			@step = 0
			@type = "onSudokuMethod"

			unite = nil
			candidatTmp = 0
			i = 0
			#Detection d'une unité où appliquer la méthode
			while(i < 26 && candidatTmp == 0) do
				uniteTmp = SudokuAPI.API.getUnite(i/9,i%9)
				candidatTmp = SudokuAPI.API.uniqueCandidate(SudokuAPI.API.nbCandidate(uniteTmp))
				i+=1
			end

			if candidatTmp != 0
				@@candidat = candidatTmp
				unite = uniteTmp
			end

			if unite == nil
				SudokuAPI.API.assistantMessage=("On ne peut pas appliquer cette méthode sur la grille. \n(Appuyez sur Suivant)")
				@step = 2
			else

				@@caze = SudokuAPI.API.cazeUniqueCandidate(unite, @@candidat)
				SudokuAPI.API.assistantMessage=("On applique la méthode sur cette unité. \n(Appuyez sur Suivant)")
				SudokuAPI.API.highlightUnite(unite)
			end

		elsif(@step == 1)
			SudokuAPI.API.resetColors()
			SudokuAPI.API.cazeAt(@@caze.x,@@caze.y).color=Colors::CL_HIGHLIGHT_METHOD;
			SudokuAPI.API.cazeAt(@@caze.x,@@caze.y).value=(@@candidat)

			SudokuAPI.API.assistantMessage=("Cette case possède un candidat qui n'est présent\nqu'une seule fois dans l'unité. \n(Appuyez sur Suivant)")

		elsif(@step == 2)
			SudokuAPI.API.resetColors()
			SudokuAPI.API.assistantMessage=("Bonjour, je suis l'assistant, je suis là pour vous aider")
			statutMethod(false)
		end

		@step+=1

	end

end
