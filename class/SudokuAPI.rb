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

require "./Caze.rb"
require "./Sudoku.rb"

class SudokuAPI
#== Variables d'instance ==
	@sudoku
	@sudokuCompleted
	
	attr_reader :sudoku
	attr_reader :sudokuCompleted

#==========================

	@@API = SudokuAPI.new();

	def SudokuAPI.API()
		return @@API;
	end

	def initialize(sudoku, sudokuCompleted)
		@sudoku = sudoku
		@sudokuCompleted = sudokuCompleted
        y=0
        x=0
        9.times do |x|
            9.times do |y|
                candidate_unite(x,y,column(x))
                candidate_unite(x,y,row(y))
                candidate_unite(x,y,square(x,y))
            end
        end
	end

    #===Met les candidats impossible à false selon l'unite
    #
    #===Paramètres :
    #* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
    #* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
    #* <b>unite</b> : tab : contient le tableau de l'unité
    def candidate_unite(x,y,unite)
        unite.each{ |g|
            @sudoku.tcaze[x][y].candidats[g.value.to_s]=false
        }

    end

    def candidateCaze(x,y)
        candidate_unite(x,y,column(y))
        candidate_unite(x,y,row(x))
        candidate_unite(x,y,square(y,x))
    end


	#===Modifie la couleur d'une case
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	#* <b>color</b> : int : indique la nouvelle couleur de la case à modifier
	def setColor(x,y,color)
		@sudoku.cazeAt(x,y).color=color;
	end

	def getColor(x,y)
		return @sudoku.cazeAt(x,y).color;
	end


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
			tab<<@sudoku.cazeAt(y,i)
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
			tab<<@sudoku.cazeAt(i,x)
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
		x -= x%3
		y -= y%3
		tab = Array.new()
		0.upto(2) do |i|
			0.upto(2) do |j|
                tab<<@sudoku.cazeAt(y+i,x+j)
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
		return square(x,y) + row(x) + column(y)
	end

	#===Affiche le message de l'assistant
	#
	#===Paramètres :
	#* <b>str</b> : string : contient le message a afficher
	def assistantMessage(str)
		print str
	end
	
	#===Sauvegarde des deux grilles
	#
	#===Paramètres :
	#* <b>fileName</b> : string : nom du fichier de sauvegarde
	
	def saveSudoku(fileName)
		saveFile = File.open("save_files/" + fileName, "w")
		
		if(!saveFile.closed?)
			print "Fichier de sauvegarde ouvert\n"
		end
		
		for i in 0..80
			saveFile.write self.sudoku[i].getValue()
		end
		
		saveFile.write "\n"
		
		for i in 0..80
			saveFile.write self.sudokuCompleted[i].getValue()
		end
		
		saveFile.write "\n"
		
		saveFile.close
		
		if(saveFile.closed?)
			print "Sauvegarde terminée !\n"
		end
	end
	
	
	#===Chargement des deux grilles à partir d'un fichier
	#
	#===Paramètres :
	#* <b>fileName</b> : string : nom du fichier à charger

	def loadSudoku(fileName)
		loadFile = File.open(fileName, "r")
		
		if(!loadFile.closed?)
			print "Fichier à charger ouvert\n"
		end
		
		fileContent = IO.readlines(fileName)
		
		# Grids
		sudoku = fileContent[0]
		sudokuCompleted = fileContent[1]
		
		self.gridModify(sudoku)
		self.completedModify(sudokuCompleted)
		
		loadFile.close

		if(loadFile.closed?)
			print "Chargement terminé !\n"
		end
	end
end