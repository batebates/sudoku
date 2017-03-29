
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
    include Observable
#== Variables d'instance ==
    @x
    @y
    @value
    @color
    @locked
    @lastColor
    attr_reader :x, :y, :value, :color, :locked
    attr_accessor :lastColor

#==========================

	def initialize(x,y,value)
		@x = x.to_i
        @y = y.to_i
        @value = value.to_i
        @color = Colors::CL_BLANK
        @lastColor = @color
        @locked = @value != 0;
	end

	private_class_method :new

	def Caze.create(x,y,value)
		new(x,y,value)
	end

    def getValue()
        return @value
    end

    def color=(color)
        @color = color
        changed(true);
        notify_observers("color", @color);
    end

    def value=(value)
        @value = value
        changed(true);
        notify_observers("value", @value);
    end

    def insertValue(value)
        self.value = value == self.value ? 0 : value;
    end
end
