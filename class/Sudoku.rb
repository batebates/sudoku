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
load 'Caze.rb'
load 'SudokuAPI.rb'
class Sudoku
#== Variables d'instance ==
	@tcaze
	attr_reader :tcaze
#==========================

	def initialize(str)
        x_length = 9
        y_length = 9
        @tcaze=[]
        tab = str.split("")
        i=0
        x_length.times do |x|
            @tcaze[x] ||= []
            y_length.times do |y|
                @tcaze[x][y] = Caze.create(x,y,tab[i])
                i=i+1
            end
        end

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
	def setValue(x,y,val)
		 return @tcaze[x][y].value=(val)
	end

	#===Vérifie si une case contient bien une valeur
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	def valueCheck?(x,y)
		return @tcaze[x][y].value!=0
	end

    #===Retourne l'unité demandée sous forme de tableau
    #
    # <b>type</b> : type d'unité, 0 pour une ligne, 1 pour une colonne, 2 pour une région
    # <b>numero</b> : numero de la regoin dans l'ordre logique
    #def getUnite(type, numero)
        #if type == 0
            #tmp = @tcaze(numero,:)
            #elsif type == 1
            #tmp = @tcaze(:,numero)
           # else
          #  i = 0
         #   while(i < 9)
       #         i+=1
      #      end
     #   end
        #        tmp << @tcaze[i/3+(numero/3)*3][i%3+(numero%3)*3]
    #end
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
end
