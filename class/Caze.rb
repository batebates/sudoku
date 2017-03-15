#<b>Auteur  :</b> Decrand Baptiste,Zerbane Mehdi
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
    attr_accessor :value, :candidats, :color :x,:y
#==========================

	def initialize(x,y,value)
		@x = x.to_i
        @y = y.to_i
        @value = value.to_i
        @color =nil
        @candidats = Hash.new
        1.upto(9) do |elt|
            @candidats[elt.to_s]=true
        end
	end

	private_class_method :new

	def Caze.create(x,y,value)
		new(x,y,value)
	end

    def getValue()
        return @value
    end
#===Affiche la valeur de la case
    def to_s()
        return "\n"
    end
end
