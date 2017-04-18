
#<b>Auteur</b> Decrand Baptiste,Zerbane Mehdi
#
#<b>Version</b> 1.0
#
#<b>Date</b> 08/02/2017
#
#===Définit une case d'un sudoku
#<b>Liste des méthodes
#* to_s
#* Caze.create
#* getValue
#* color=
#* value=
#* invisible=
#* hint=
#* locked=
#* insertValue
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
    @invisible
    @hint
    @excludedHint
    attr_reader :x, :y, :value, :color, :invisible, :hint, :locked, :excludedHint
    attr_accessor :lastColor


  #===Initialise une case
  #
  # Params:
  # @param x [int] indique la coordonnée de l'axe des abscisses de la case
  # @param y [int] indique la coordonnée de l'axe des ordonnées de la case
  # @param value [int] indique la valeur de la case
  # @param locked [boolean] indique si la case est bloqué en lecture simple
	def initialize(x,y,value,locked)
		@x = x.to_i
        @y = y.to_i
        @value = value.to_i
        @color = Colors::CL_BLANK
        @lastColor = @color
        @locked = locked;
        @invisible = false;
        @hint = false;
        @excludedHint = [];
	end

	private_class_method :new

  #===Créé une case
  #
  # Params:
  # @param x [int] indique la coordonnée de l'axe des abscisses de la case
  # @param y [int] indique la coordonnée de l'axe des ordonnées de la case
  # @param value [int] indique la valeur de la case
  # @param locked [boolean] indique si la case est bloqué en lecture simple
	def Caze.create(x,y,value,locked)
		new(x,y,value,locked)
	end

    #===Retourne la valeur de la une case
    def getValue()
        return @value
    end

    #===Set de la couleur de la case
    #
    # Params:
    # @param color [Colors] indique la nouvelle couleur de la case
    def color=(color)
        @color = color
        changed(true);
        notify_observers("color", @color);
    end

    #===Set de la valeur de la case
    #
    # Params:
    # @param value [int] indique la nouvelle valeur de la case
    def value=(value)
        @value = value
        changed(true);
        notify_observers("value", @value);

		if (SudokuAPI.API.sudoku.valid?())
			SudokuAPI.API.won=(true)
		end
    end

    #===Set de l'invisibilité de la case
    #
    # Params:
    # @param invisible [boolean] indique si la case est invisible ou non
    def invisible=(invisible)
        @invisible = invisible
        changed(true);
        notify_observers("invisible", @invisible);
    end

    #===Set de l'apparition des candidats de la case
    #
    # Params:
    # @param hintEnabled [boolean] indique si les indices de la case sont visibles
    def hint=(hintEnabled)
        @hint = hintEnabled
        changed(true);
        notify_observers("hint", @hint);
    end

    #===Set de l'ecriture de la case
    #
    # Params:
    # @param hintEnabled [boolean] indique si la case peut être modifier ou non par l'utilisateur
    def locked=(locked)
        @locked = locked
        changed(true);
        notify_observers("locked", @locked);
    end

    #===Set de la valeur de la case
    #
    # Params:
    # @param value [int] indique la nouvelle valeur de la case
    def insertValue(value)
        self.value = value == self.value ? 0 : value;
    end
end
