load "Score.rb"

class ScoreTable
	
	@score_tableau = []
	
	attr_accessor :score_tableau
	private_class_method :new
	
	def ScoreTable.build()
		return new()
	end
	
	def initialize()
		cpt=0
		while cpt < 10  do
  			@score_tableau[cpt] = Score.creer("Michel", 10-cpt)
  			cpt+=1
		end
	end
	
	/* 
		Va comparer un a un les éléments du tableau de score avec le score actuel du joueur
		et renverra l'indice auxquel se trouve l'élément directement inférieur au score du joueur
		si celui-ci existe
	*/
	def scoreTableGetIndex(scoreCompare)
		cpt = 0
		
		while cpt<10 do
			if(self[cpt].getScore > scoreCompare.getScore() ) then
				return cpt-1
			end
			cpt+=1
		end
		return -1
	end
	
	/*
		Inserera l'élément scoreToInsert a l'endroit index du tableau @score_tableau
		fonctionnement : 
		echange une valeur tampon (dabord vide) avec @score_tableau[index] pour inserer scoreToInsert
		repète l'opération en descendant (jusqu'a index = 0) et supprime ainsi la dernière valeur
	*/
	def scoreInsert(scoreToInsert, index)
		if(index != -1) then
			tampon = Score.creer("",0);
			tampon = @score_tableau[index]
			@score_tableau[index] = scoreToInsert
			scoreInsert(tampon, index-1)
		end
	end
	
	

end