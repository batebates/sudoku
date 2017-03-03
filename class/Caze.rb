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
    @x
    @y
    @value
    @candidats
    attr_accessor :value, :candidats

#==========================

	def initialize(x,y,value)
		@x = x.to_i
        @y = y.to_i
        @value = value.to_i
        @candidats = Hash.new
        1.upto(9) do |elt|
            if(elt!=@value)
                @candidats[elt.to_s]=true
            else
                @candidats[elt.to_s]=false
            end
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
        return ""
    end
end
