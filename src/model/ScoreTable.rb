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
		self.scoreAff()
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


	def scoreSave()
		scoreFile = File.new "scoreTable.txt"


		File.open(scoreFile, 'w') { |file| file.write("your text") }

	end

end

tableScore = ScoreTable.build()

scoreTest1 = Score.creer("Dimitri", 1250)
tableScore.scoreInsertTab(scoreTest1)
		
		


