class MethodUniqueCandidate < Methode

	def textMethod
		return "Dans le cas où un candidat est unique dans une unité, on peut en déduire que la case où il est présent contient bien ce candidat car il ne peut être nul part ailleurs."
	end

	def demoMethod
		#TODO
		#Assistant dit "Voici une démonstration"
		assistantMessage("Voici une démonstration de la méthode du candidat unique")
		gridDemo = "005000070400000400000000000000404000000000000000000000000000000000000000000000000"

		SudokuAPI.API.initSudoku(gridDemo);
		
		#grisage des cases non importantes
		1.upto(8) do |x|
			0.upto(8) do |y|
				sudoku.cazeAt(x,y).color=CL_NUMBER_LOCKED;
			end
		end

		#Assistant dit on va s'occuper de cette ligne
		assistantMessage("Nous allons effectuer la méthode sur cette ligne")

		#Mise en valeur de la case
		sudoku.cazeAt(0,5).color=CL_NUMBER_LOCKED;

		#"On peut remarquer que sur cette case machin truc"
		assistantMessage("On peut remarquer que 4 est candidat dans cette case et qu'il n'est présent nul par ailleurs dans l'unité.")

		#affichage du chiffre
		sudoku.caseAt(0,5).value=(4)

		assistantMessage("On en déduit donc que 4 est le chiffre présent dans cette case.")

		#fermeture de la fenetre
	end

	def onSudokuMethod
		#TODO
		#Detection d'un endroit où appliquer la méthode
		#Coloration de la case + explication de l'assistant
	end

end
