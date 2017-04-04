#<b>Auteur  :</b> Decrand Baptiste,Zerbane Mehdi,Laville Martin
#
#<b>Version :</b> 1.0
#
#<b>Date    :</b> 08/02/2017
#
#=== Contient les Methodes permettant d'extraire des informations précises d'un sudoku
#<b>Liste des méthodes
#* setColor
#* execMethod
#* row
#* column
#* rowColumn
#* square
#* squareRowColumn
#* assistantMessage=
#* candidateCaze
#* squareN
#* saveSudoku
#* loadSudoku
#* getUnite
#* nbCandidate
#* cazeUniqueCandidate
#* uniqueCandidate
#* setValue
#* cazeAt
#* username=
#* setCazeInvisible
#* setHintAt
#* setEditable
#* sudokuEditable
#* showNumber
#* resetColors
#* addExclude
#* removeExclude
#* getExclude
#* hideMenu
#</b>
class SudokuAPI
	include Observable
#== Variables d'instance ==
	@sudoku
	@sudokuCompleted
	@sudokuStart
	@assistantMessage
	@timerPaused
	@timer
	@username
	@hintenable
	@methode

	attr_reader :sudoku
	attr_reader :sudokuCompleted
	attr_reader :sudokuStart
	attr_reader :assistantMessage
	attr_reader :username
	attr_accessor :timerPaused, :timer, :methode

#==========================

	@@API = SudokuAPI.new();

	def SudokuAPI.API()
		return @@API;
	end

	def setSudoku(sudoku, sudokuStart = nil, sudokuCompleted = nil)
		@timer = 0
		@sudoku = sudoku
		@sudokuStart = sudokuStart
		@sudokuCompleted = sudokuCompleted;
		if(@sudokuStart != nil)
			lockSudoku()
		end
		changed(true);
		notify_observers("newgrid", sudoku);
	end

	def lockSudoku()
		for i in 0...9
			for j in 0...9
				if(@sudokuStart.hasValue?(i,j))
					@sudoku.cazeAt(i,j).locked=true
				end
			end
		end
	end

	#===Renvoie un tableau comprenant les candidats de la case
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
    def candidateCaze(x,y)
        candidats = [1,2,3,4,5,6,7,8,9];
        row(y).each{ |caze|
            candidats.delete(caze.value);
        }
        column(x).each{ |caze|
            candidats.delete(caze.value);
        }

        square(x, y).each{ |caze|
            candidats.delete(caze.value);
        }

        return candidats;
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


	def highlightUnite(unite)
		unite.each{ |caze|
			cazeAt(caze.x,caze.y).color=Colors::CL_HIGHLIGHT_METHOD;
		}
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

	#===Renvoie la Nème région d'un sudoku dans un tableau
	#
	#===Paramètres :
	#* <b>n</b> : int : indique la région voulue (de 0 à 8)
	def squareN(n)
		square(n*3%9, n/3*3)
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
	def saveSudoku(fileName)
		saveFile = File.new("save_files/"+fileName, "w")

		if(!saveFile.closed?)
			print "Fichier de sauvegarde ouvert\n"
		end

		# Grids
		for i in 0..80
			saveFile.write self.sudoku.cazeAt(i%9,i/9).getValue()
		end
		saveFile.write "\n"

		for i in 0..80
			saveFile.write self.sudokuCompleted.cazeAt(i%9,i/9).getValue()
		end

		saveFile.write "\n"

		for i in 0..80
			saveFile.write self.sudokuStart.cazeAt(i%9,i/9).getValue()
		end

		saveFile.write "\n"

		# Timer
		saveFile.write self.timer

		saveFile.write "\n"

		# Excluded hints
		for i in 0..80
			caze = self.sudoku.cazeAt(i%9,i/9)
			if(!(caze.excludedHint.empty?)) # If there is at least one excluded hints
				saveFile.write (i%9).to_s + " " +  (i/9).to_s + " "
				for j in 0..caze.excludedHint.size
					saveFile.write caze.excludedHint[j].to_s + " "
				end
				saveFile.write "\n"
			end
		end

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
		filePath = "save_files/#{fileName}"
		if(File.file?(filePath))
			loadFile = File.new(filePath, "r")

			if(!loadFile.closed?)
				print "Fichier à charger ouvert\n"
			else
				print "Fichier non existant"
			end

			fileContent = IO.readlines(loadFile)

			# Grids
			sudoku = fileContent[0]
			sudokuCompleted = fileContent[1]
			sudokuStart = fileContent[2]

			self.setSudoku(Sudoku.create(sudoku), Sudoku.create(sudokuStart), Sudoku.create(sudokuCompleted))

			# Attributes
			@timer = fileContent[3].to_i

			ligneActu = 4

			while(ligneActu < fileContent.size)
				ligne = fileContent[ligneActu]
				tabLigne = ligne.gsub(/\s+/m, ' ').strip.split(" ")

				for nb in 2..tabLigne.size
					addExclude((tabLigne[0].to_i)%9, (tabLigne[1].to_i)/9, (tabLigne[nb].to_i))
				end
				ligneActu += 1
			end

			loadFile.close

			if(loadFile.closed?)
				print "Chargement terminé !\n"
			end

			return true
		else
			print("Fichier à charger non existant")
			return false
		end
	end

	#===Retourne l'unité demandée sous forme de tableau
	#
	#===Paramètres :
	#* <b>type</b> : type d'unité, 0 pour une ligne, 1 pour une colonne, 2 pour une région
	#* <b>numero</b> : numero de la region dans l'ordre logique
	def getUnite(type, numero)
		if type == 0
			tmp = row(numero)
		elsif type == 1
			tmp = column(numero)
		else
			tmp = squareN(numero)
		end
		return tmp
	end

	#===Retourne le nombre de fois où un candidat est présent dans une unité
	#
	#===Paramètres :
	# <b>unite</b> : tableau d'une unité
	def nbCandidate(unite)
		nbCandid = Array.new(9,0);
		unite.each{ |caze|
			candidats = candidateCaze(caze.x, caze.y)
			candidats.each{ |candid|
				nbCandid[candid-1]+=1
			}
		}
		return nbCandid
	end

	#===Retourne la case de l'unité où le candidat est présent
	#
	#===Paramètres :
	#* <b>unite</b> : Unite où on cherche la case
	#* <b>candidate</b> : Candidat, normalement unique
	def cazeUniqueCandidate(unite, candidate)
		unite.each{ |caze|
				if(candidateCaze(caze.x, caze.y).include?(candidate))
					return caze
				end
		}
	end


	#===Regarde si une unité possède un candidat présent une seule fois
	#
	#===Paramètres :
	#* <b>nbCandid</b> : prend un tableau retourné par nbCandidate
	def uniqueCandidate(nbCandid)
		res = 0
		i = 0
		nbCandid.each{ |nb|
			i+=1
			if nb == 1
				res = i
			end
		}
		return res
	end
    #===Renvoie la case correspondant aux coordonnées
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
    def cazeAt(x,y)
        return @sudoku.cazeAt(x,y);
    end

	#===Modifie la valeur de la case correspondant aux coordonnées
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	#* <b>val</b> : int : indique la nouvelle valeur de la case à modifier
	def setValue(x,y,val)
		 return cazeAt(x, y).value=(val)
	end
	

	#===Permet de modifier l'username
	#
	#* <b>username</b> : String : nouvel username
	def username=(username)
		@username = username;

		changed(true);
		notify_observers("username", @username);
	end

	#===Permet d'activer le mode invisible d'une case
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	#* <b>invisible</b> : boolean : true pour activer, false sinon
	def setCazeInvisible(x,y,invisible)
		cazeAt(x, y).invisible=(invisible)
	end

	#===Permet d'activer la visibilité des indices d'une case
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	#* <b>hintEnabled</b> : boolean : true pour activer, false sinon
	def setHintAt(x,y,hintEnabled)
		cazeAt(x, y).hint=(hintEnabled)
	end
	
	

	#===Permet d'activer la visibilité des indices d'une unité
	#
	#===Paramètres :
	#* <b>unite</b> : tableau d'une unité
	#* <b>hintEnabled</b> : boolean : true pour activer, false sinon
	def setHintUnite(unite, hintEnabled)
		unite.each{ |caze|
			SudokuAPI.API.setHintAt(caze.x,caze.y,hintEnabled)
		}
	end

	#===Permet de rendre une case éditable
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	#* <b>locked</b> : boolean : true pour activer, false sinon
	def setEditable(x,y, locked)
		cazeAt(x, y).locked=(locked)
	end

	#===Permet de rendre une unité éditable
	#
	#===Paramètres :
	#* <b>unite</b> : tableau d'une unité
	#* <b>locked</b> : boolean : true pour activer, false sinon
	def sudokuEditable(locked)
		0.upto(8) do |x|
			0.upto(8) do |y|
				if(!locked && @sudokuStart.hasValue?(x,y) == false)
			 		setEditable(x,y,locked)
			 	elsif(locked)
			 		setEditable(x,y,locked)
			 	end
			end
		end
	end

	#===Met en avant les cases possédant un numéro en candidat
	#
	#===Paramètres :
	# <b>number</b> : int : number que l'on veut mettre en avant
	def showNumber(number)
		for x in 0...9
			for y in 0...9
				candidats = candidateCaze(x,y);
				if(candidats.include?(number) && !cazeAt(x, y).locked)
					cazeAt(x, y).color=Colors::CL_HIGHLIGHT_NUMBER_HINT;
				end
			end
		end
	end

	#===Remet toutes les case à leur couleur par défaut (blanc)
	def resetColors()
		for x in 0...9
			for y in 0...9
				cazeAt(x, y).color=Colors::CL_BLANK;
			end
		end
	end

	#===Permet d'exclure des indices d'une case
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	#* <b>number</b> : int : indice a exclure
	def addExclude(x, y, number)
		cazeAt(x, y).excludedHint.push(number);
	end

	#===Permet de réactiver des indices d'une case
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	#* <b>number</b> : int : indice a exclure
	def removeExclude(x, y, number)
		cazeAt(x, y).excludedHint.delete(number);
	end

	#===Permet de connaitre les indices exclus d'une case
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses de la case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées de la case
	def getExclude(x, y)
		cazeAt(x, y).excludedHint;
	end
	
	def getInclude(x,y)
		return [1,2,3,4,5,6,7,8,9] - getExclude(x,y)
	end

	#===Permet d'activer/désactiver le menu
	#
	#===Paramètres :
	#* <b>hidden</b> : boolean : true pour cacher le menu, false sinon
	def hideMenu(hidden)
		changed(true);
		notify_observers("hideMenu", hidden);
	end
end

