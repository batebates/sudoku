#<b>Auteur  :</b> Decrand Baptiste,Medhi Zerbane
#
#<b>Version :</b> 1.0
#
#<b>Date    :</b> 08/02/2017
#
#===Définit une case d'un sudoku
#<b>Liste des méthodes
#* to_s
#* Caze.create
#</b>
class Caze
#== Variables d'instance ==
    @x
    @y
    @value
	attr_accessor :value
#==========================
	
	def initialize(x,y,value) 
		@x = x.to_i
        @y = y.to_i
        @value = value.to_i
	end

	private_class_method :new
	
	def Caze.create(x,y,value)
		new(x,y,value)
	end

#===Affiche la valeur de la case	
    def to_s()
        return @value.to_s
    end
end
