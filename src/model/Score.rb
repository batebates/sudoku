# Un score contient le nom du joueur,
class Score
    include Comparable
    #@nom_Joueur
    #@scores
    #@temps


    #Nom du joueur
    attr_reader :nom_Joueur
    #Score
    attr_reader :scores
    #temps réalisé

	#====Methode de construction====

  private_class_method:new

    def Score.creer(nom_Joueur, scores)
      new(nom_Joueur,scores)
    end
    
    def initialize(nom_Joueur,scores)
      @nom_Joueur = nom_Joueur
      @scores = scores
    end

	#====Methode de manipulation====
	
    #
    #return le score du joueur avec son nom
    #
    def getScore()
      return @scores
    end

    #
    #return le nom du joueur
    #
    def getNom()
      return @nom_Joueur
    end



     #PRINT
     # Affichage du score
     def to_s()
       return "pseudo #{@nom_Joueur} | #{@scores}"
     end

    
    def <=>(other)
        self.scores <=> other.scores
    end


end #end class
