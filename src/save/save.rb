class Cell
	attr_reader :x
	attr_reader :y
	attr_reader :value
	
	private_class_method :new
	
	def Cell.create(*args)
		new(*args)
	end
	
	def initialize(*args)
		if args.length == 2 then
			@x = args[0]%9
			@y = args[0]/9
			@value = args[1]
		elsif args.length == 3 then
			@x = args[0]
			@y = args[1]
			@value = args[2]
		end
	end
	
	def getX()
		return @x
	end
	
	def getY()
		return @y
	end
	
	def getValue()
		return @value
	end
	
	def setValue(i)
		@value = i
		return self
	end
end

class Grid < Array
	def new()
		super(81, nil)
	end
	
	def initialize()
		for i in 0..81
			self[i] = Cell.create(i, i, 0)
		end
	end
	
	# Put the content of a string into the grid, as values
	def stringToGrid(chaine)
		for i in 0..81
			changeValue(i, chaine[i].to_i)
		end
	end
	
	# Change the value of a specified cell
	def changeValue(*args)
		if args.length == 2 then
			self[args[0]].setValue(args[1])
		elsif args.length == 3 then
			cellX = args[0]
			cellY = args[1]
			self[cellX + cellY * 9].setValue(args[2])
		end
	end
	
	# Returns the value of a specified cell
	def getValue(*args)
		if args.length == 1 then
			return self[args[0]].getValue()
		elsif args.length == 2 then
			cellX = args[0]
			cellY = args[1]
			return self[cellX + cellY * 9].getValue()
		end
	end
	
	# Converts the values of the grid into a single string
	def toString()
		str = ""
		for i in 0..81
			chaine += getValue(i)
		end
		
		return str
	end
	
	def afficher()
		for i in 0..80
			if i>0 && i%9==0
				print "\n"
			end
			print getValue(i)
		end
		print "\n"
	end
end

class Sudoku
	attr_reader :grille_courante
	attr_reader :grille_resolue
	
	private_class_method :new
	
	# Create two sudoku grids (the one to solve and the one already solved) from a single file)
	def Sudoku.lire(fileName)
		new(fileName)
	end
	
	def initialize(fileName)
		@grille_courante = Grid.new()
		@grille_resolue = Grid.new()
		
		loadSudoku(fileName)
	end
	
	# Puts the content of a string into the grid to be solved
	def gridModify(sudokuString)
		@grille_courante.stringToGrid(sudokuString)
	end
	
	# Puts the content of a string into the solved grid
	def completedModify(sudokuString)
		@grille_resolue.stringToGrid(sudokuString)
	end
	
	def afficher()
		@grille_courante.afficher()
		@grille_resolue.afficher()
	end
	
	# Checks if the sent value would be the correct one in the specified cell
	def isCorrectValue?(x, y, value)
		return @grille_resolue.getValue(x, y) == value
	end
	
	# Checks if the specified cell is either correct or left blank
	def isCorrectCell?(*args)
		if args.length == 1 then
			cellX = args[0]%9
			cellY = args[0]/9
		elsif args.length == 2 then
			cellX = args[0]
			cellY = args[1]
		end
		
		return @grille_resolue.getValue(cellX, cellY) == @grille_courante.getValue(cellX, cellY) || @grille_courante.getValue(cellX, cellY) == 0
	end
	
	# Checks if each cell of the first grid is either correct or left blank
	def isCorrectGrid?()
		for i in 0..81
			if(!isCorrectCell?(i)) then
				return false
			end
		end
		
		return true
	end
	
	### SAVE AND LOAD
	 
	# Saves the two grids into a save file
	def saveSudoku(fileName)
		saveFile = File.open("save_files/" + fileName, "w")
		
		if(!saveFile.closed?)
			print "Fichier de sauvegarde ouvert\n"
		end
		
		for i in 0..80
			saveFile.write self.grille_courante[i].getValue()
		end
		
		saveFile.write "\n\n"
		
		for i in 0..80
			saveFile.write self.grille_resolue[i].getValue()
		end
		
		saveFile.close
		
		if(saveFile.closed?)
			print "Sauvegarde terminée !\n"
		end
	end
	
	# Loads two grids from a specified save file
	def loadSudoku(fileName)
		loadFile = File.open(fileName, "r")
		
		if(!loadFile.closed?)
			print "Fichier à charger ouvert\n"
		end
		
		sudokuToBeCompleted = IO.read(loadFile, 81)
		sudokuCompleted = IO.read(loadFile, 81, 85)
		#contents = loadFile.read(
		self.gridModify(sudokuToBeCompleted)
		self.completedModify(sudokuCompleted)
		
		loadFile.close

		if(loadFile.closed?)
			print "Chargement terminé !\n"
		end
	end
	
	### TESTS
	def Sudoku.test()
		sudokuFile = "./save_files/sudoku.txt"
		
		if system('save_files/sudoku_generator.exe', sudokuFile) == false then
			print "Error during the sudoku generation process"
		end

		###Saves
		#Read
		sudokuRead = Sudoku.lire(sudokuFile)
		print "Grille courante : \n"
		sudokuRead.grille_courante.afficher()

		print "\nGrille résolue : \n"
		sudokuRead.grille_resolue.afficher()
		print "\n"

		### Tests
		print "\nValeur en 3, 5 : 9 ?\n"
		print sudokuRead.grille_resolue.getValue(3,5), " - ", sudokuRead.isCorrectValue?(3, 5, 9),  "\n"

		print "\nFirst grid correct ? (Should be TRUE)\n"
		print sudokuRead.isCorrectGrid?(), "\n"

		print "\nSauvegarde du sudoku actuel sous le nom 'profil_test.txt' :\n"
		sudokuRead.saveSudoku("profil_test.txt")
	end
end


Sudoku.test()