#<b>Auteur  :</b> Decrand Baptiste,Zerbane Mehdi
#
#<b>Version :</b> 1.0
#
#<b>Date    :</b> 08/02/2017
#
#=== Contient les Methodes permettant d'extraire des informations précises d'un sudoku
#<b>Liste des méthodes
#* setColor
#* execMethod
#*row
#*column
#*rowColumn
#*square
#*squareRowColumn
#*assistantMessage
#</b>
class SudokuAPI
	include Observable
#== Variables d'instance ==
	@sudoku
	@sudokuCompleted
	@assistantMessage
	@timerPaused
	@timer

	attr_reader :sudoku
	attr_reader :sudokuCompleted
	attr_reader :sudokuStart
	attr_reader :assistantMessage
	attr_accessor :timerPaused, :timer

#==========================

	@@API = SudokuAPI.new();

	def SudokuAPI.API()
		return @@API;
	end

	def setSudoku(sudoku)
		@timer = 0
		@sudoku = sudoku
		@sudokuStart = sudoku
		@sudokuCompleted = sudoku;

		changed(true);
		notify_observers("newgrid", sudoku);
	end

#    def candidateCaze(x,y)
#        candidats = [1,2,3,4,5,6,7,8,9];
#        row(y).each{ |caze|
#            candidats.delete(caze.value);
#        }

#        column(x).each{ |caze|
#            candidats.delete(caze.value);
#        }
#
#        square(x, y).each{ |caze|
#            candidats.delete(caze.value);
#        }
#
#        return candidats;
#    end


	#===Modifie la couleur d'une case
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	#* <b>color</b> : int : indique la nouvelle couleur de la case à modifier
	def setColor(x,y,color)
		@sudoku.cazeAt(x,y).color=color;
	end

#	def getColor(x,y)
#		return @sudoku.cazeAt(x,y).color;
#	end


	#===Execute la methode
	#
	#===Paramètres :
	#* <b>meth</b> : Methode : indique la methode à executer
	def execMethod(meth)

	end

	#===Renvoie une ligne du Sudoku dans un tableau
	#
	#===Paramètres :
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la ligne
	def row(y)
		tab = Array.new()
		9.times do |i|
			tab<<@sudoku.cazeAt(i,y)
		end
		return tab
	end

	#===Renvoie une colonne du sudoku dans un tableau
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la colonne
	def column(x)
		tab = Array.new()
		9.times do |i|
			tab<<@sudoku.cazeAt(x,i)
		end
		return tab
	end

	#===Renvoie une colonne suivi d'une ligne de la case d'un sudoku dans un tableau
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	def rowColumn(x,y)
		return self.row(y) + self.column(x)
	end

	#===Renvoie la région d'une case d'un sudoku dans un tableau
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	#* <b>val</b> : int : indique la nouvelle valeur de la case à modifier
	def square(x,y)
		x = (x / 3).to_i * 3
		y = (y / 3).to_i * 3
		tab = Array.new()
		0.upto(2) do |i|
			0.upto(2) do |j|
                tab<<@sudoku.cazeAt(x+i,y+j)
			end
		end
        return tab
	end

	#===Renvoie la region,la colonne suivi de la ligne d'un case du sudoku dans un tableau
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	def squareRowColumn(x,y)
		return square(x,y) + row(y) + column(x)
	end

	#===Affiche le message de l'assistant
	#
	#===Paramètres :
	#* <b>str</b> : string : contient le message a afficher
	def assistantMessage=(str)
		@assistantMessage = str;
		changed(true);
		notify_observers("assistant", @assistantMessage);
	end

	#===Sauvegarde des deux grilles
	#
	#===Paramètres :
	#* <b>fileName</b> : string : nom du fichier de sauvegarde

#	def saveSudoku(fileName)
#		saveFile = File.open("save_files/" + fileName, "w")
#
#		if(!saveFile.closed?)
#			print "Fichier de sauvegarde ouvert\n"
#		end
#
#		for i in 0..80
#			saveFile.write self.sudokuStart[i].getValue()
#		end

#		saveFile.write "\n"
#
#		for i in 0..80
#			saveFile.write self.sudoku[i].getValue()
#		end
#
#		saveFile.write "\n"
#
#		for i in 0..80
#			saveFile.write self.sudokuCompleted[i].getValue()
#		end
#
#		saveFile.write "\n"
#
#		saveFile.close
#
#		if(saveFile.closed?)
#			print "Sauvegarde terminée !\n"
#		end
#	end


	#===Chargement des deux grilles à partir d'un fichier
	#
	#===Paramètres :
	#* <b>fileName</b> : string : nom du fichier à charger

=begin
	def loadSudoku(fileName)
		loadFile = File.open(fileName, "r")

		if(!loadFile.closed?)
			print "Fichier à charger ouvert\n"
		end

		fileContent = IO.readlines(fileName)

		# Grids
		sudoku = fileContent[0]
		sudokuCompleted = fileContent[1]

		@sudoku = sudoku
		@sudokuStart = sudoku
		@sudokuCompleted = sudokuCompleted

		loadFile.close

		if(loadFile.closed?)
			print "Chargement terminé !\n"
		end
	end
=end

    #===Renvoie la case correspondant aux coordonnées
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
=begin
    def cazeAt(x,y)
        return @sudoku.cazeAt(x,y);
    end
=end
	#===Modifie la valeur de la case correspondant aux coordonnées
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	#* <b>val</b> : int : indique la nouvelle valeur de la case à modifier
=begin
	def setValue(x,y,val)
		 return cazeAt(x, y).value=(val)
	end
=end
end
