load "Score.rb"

#== Utilisation :
#
#== scoreAInserer = Score.creer("nomJoueur", scoreJoueur)
#== tableauOuInserer.scoreInsertTab(scoreAInserer)


class ScoreTable

	#tableau contenant 10 valeur Score
	@score_tableau

	attr_accessor :score_tableau
	private_class_method :new

	#====Methode de construction====

	def ScoreTable.build()
		new()
	end

	def initialize()
		cpt=0
		@score_tableau = Array.new()
		@@instance = self

		while cpt < 10  do
  			@score_tableau.insert(cpt, Score.creer("Valentin", 10+10*cpt))
  			cpt+=1
		end
	end

	#====Methode de manipulation====

	#===Renvoi l'index a laquelle le score voulu doit s'inserer
	#
	#===Paramètre
	# <b>scoreCompare</b> Score : Score que l'on désire inserer
	def scoreTableGetIndex(scoreCompare)
		cpt = 0

		while cpt<10 do
			if(self.score_tableau[cpt].getScore > scoreCompare.getScore()) then
				return cpt-1
			end
			cpt+=1
		end
		return cpt
	end


	#===Insert un score sur une ligne donnée dans le tableau
	#
	#===Paramètre
	# <b>scoreToInsert</b> Score : Score que l'on souhaite inserer
	# <b>index</b> int : Position du tableau où inserer le score
	def scoreInsert(scoreToInsert, index)
		self.score_tableau.insert(index, scoreToInsert)
		self.score_tableau.shift()
	end

	#===cherche et insert un score dans le tableau, à sa place
	#
	#===Paramètre
	# <b>scoreToInsert</b> Score : Score a inserer
	def scoreInsertTab(scoreToInsert)
		index = self.scoreTableGetIndex(scoreToInsert)
		if(index > -1) then
			self.scoreInsert(scoreToInsert, index)
		end
	end

	#===Affiche le tableau de score en ordre décroissant
	#
	def scoreAff()
		cpt=9

		while cpt >= 0 do
			puts self.score_tableau[cpt]
			cpt-=1
		end
		puts
	end

	#===Enregistre le tableau des scores dans un fichier texte
	#
	def scoreSave()
		scoreFile = File.new("save_score", "w") 
	
		if(!scoreFile.closed?)
			print "Sauvegarde du tableau de score...\n"
		end

		for cpt in 0...10
			scoreFile.write (self.score_tableau[cpt].getNom()+":"+self.score_tableau[cpt].getScore().to_s()+"\n")
		end		
		
		scoreFile.close()
		if(scoreFile.closed?)
			print "Sauvegarde du tableau de score terminée !\n"
		end

	end

	#===Charge et affiche le tableau des scores à partir d'un fichier texte
	#
	def scoreLoad()
		scoreLoad = File.open("save_score", "r")
		cpt=0

		if(!scoreLoad.closed?)
			print "Chargement du tableau de score...\n"
		end

		scoreLoad.each_line{ |ligne|
			score = []
			score = ligne.gsub(/:+/m, ':').strip.split(":")
			self.score_tableau[cpt] = Score.creer(score[0], score[1].to_i())
			cpt+=1
		}	
		
		scoreLoad.close()
		if(scoreLoad.closed?)
			print "Tableau de score chargé !\n"
		end
		self.scoreAff()
	end

end

#test = ScoreTable.build()
#test.scoreAff()

#scoreTest1 = Score.creer("Dimitri", 2500)
#test.scoreInsertTab(scoreTest1)
#test.scoreSave()

#scoreTest2 = Score.creer("DarkVador", 2000)
#test.scoreInsertTab(scoreTest2)
#test.scoreAff()

#test.scoreLoad()
