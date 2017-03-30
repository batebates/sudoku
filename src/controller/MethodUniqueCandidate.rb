class MethodUniqueCandidate
	def textMethod
		return "Dans le cas où un candidat est unique dans une unité, on peut en déduire que la case où il est présent contient bien ce candidat car il ne peut être nul part ailleurs."
	end

	def demoMethod
		#TODO
		#Assistant dit "Voici une démonstration"
		gridDemo = "005000070400000400000000000000404000000000000000000000000000000000000000000000000"

		s=SudokuAPI.API
		s.setSudoku(Sudoku.create(gridDemo));
		s.assistantMessage

		s.enableHint(true)
		
		s.assistantMessage=("Voici une démonstration de la méthode du candidat unique")

		#grisage des cases non importantes
		# 0.upto(8) do |x|
		# 	1.upto(8) do |y|
		# 		s.cazeAt(x,y).color=Colors::CL_NUMBER;
		# 	end
		# end

		0.upto(26) do |u|
			candidat = s.uniqueCandidate(s.nbCandidate(s.getUnite(u/9,u%9)))
			if(candidat != 0)
				unite = u
			end
		end

		setColorUnite(unite, CL_NUMBER_LOCKED)
		#Assistant dit on va s'occuper de cette ligne
		s.assistantMessage=("Nous allons effectuer la méthode sur cette ligne")

		#Mise en valeur de la case
		#s.cazeAt(4,0).color=Colors::CL_HIGHLIGHT;

		#"On peut remarquer que sur cette case machin truc"
		s.assistantMessage=("On peut remarquer que 4 est candidat dans cette case et qu'il n'est présent nul par ailleurs dans l'unité.")

		#affichage du chiffre
		#s.cazeAt(4,0).value=(4)

		s.assistantMessage=("On en déduit donc que 4 est le chiffre présent dans cette case.")

		Window.init();

		#fermeture de la fenetre
	end

	def onSudokuMethod
		#TODO
		unite = nil
		#Detection de l'unité où appliquer la méthode
		0.upto(26) do |u|
			candidat = uniqueCandidate(nbCandidate(unite(u/9,u%9)))
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
