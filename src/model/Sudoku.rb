#<b>Auteur  :</b> Decrand Baptiste,Zerbane Mehdi
#
#<b>Version :</b> 1.0
#
#<b>Date    :</b> 08/02/2017
#
#=== Permet la création d'une grille de sudoku composé de case ainsi que les méthodes associées
#<b>Liste des méthodes
#*cazeAt
#*setValue
#*valueCheck
#gridFull
#</b>
class Sudoku
#== Variables d'instance ==
	@tcaze
	attr_reader :tcaze
#==========================

	def initialize(str)
		x_length = 9
        y_length = 9

		@tcaze = Array.new(x_length);
		@tcaze.each_with_index { |value, index|
			@tcaze[index] = Array.new(y_length);
		}

		str.split("").each_with_index { |value, index|
			x = index % x_length;
			y = index / x_length;
			@tcaze[x][y] = Caze.create(x, y, value.to_i, false);
		}
	end

	private_class_method :new

	def Sudoku.create(caze)
		new(caze)
	end

	#===Renvoie la case correspondant aux coordonnées
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	def cazeAt(x,y)
		return @tcaze[x][y]
	end

	#===Modifie la valeur de la case correspondant aux coordonnées
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	#* <b>val</b> : int : indique la nouvelle valeur de la case à modifier
	def setValueAt(x,y,val)
		 return @tcaze[x][y].value=(val)
	end

	#===Vérifie si une case contient bien une valeur
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	def hasValue?(x,y)
		return @tcaze[x][y].value!=0
	end

	#===Vérifie si la grille est remplie
	#
	def gridFull()
		res = true
		@tcaze.each do |tab|
			tab.each do |elt|
				if elt.value==0
					res = false
				end
			end
		end
		return res
	end

#===Affiche le sudoku
#
    def to_s
        cpt=0
        @tcaze.each do |tab|
            tab.each do |elt|
                print elt.value().to_s + " "
                cpt += 1
                if cpt%9==0
                    print "\n"
                end
            end
        end
    end


	def rowValue(y)
		values = [];
		SudokuAPI.API.row(y).each { |caze|
			values.push(caze.value);
		}
		return values;
	end

	def columnValue(x)
		values = [];
		SudokuAPI.API.column(x).each { |caze|
			values.push(caze.value);
		}

		return values;
	end

	def squareValue(x,y)
		values = [];
		SudokuAPI.API.square(x,y).each { |caze|
			values.push(caze.value);
		}

		return values;
	end

#===Verifie Validité de la grille
#
	def valid?()
		cptX = 0
		cptY = 0
		if(gridFull()) #Verifie si grille pleine
			for i in 0...9
				if rowValue(i).uniq.length != rowValue(i).length
					return false
				elsif columnValue(i).uniq.length != columnValue(i).length
					return false
				elsif squareValue((x%3),(y/3).floor).uniq.length != squareValue((x%3),(y/3).floor).length
					return false;
				end
			end

			return true
		end
		return true
	end
end
