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
	attr_reader :gridToComplete
	attr_reader :gridCompleted
	attr_reader :colorList
	
	private_class_method :new
	
	# Create two sudoku grids (the one to solve and the one already solved) from a single file)
	def Sudoku.lire(fileName)
		new(fileName)
	end
	
	def initialize(fileName)
		@gridToComplete = Grid.new()
		@gridCompleted = Grid.new()
		@colorList = Array.new(4)
		@grilleCouleurs = Grid.new()
		
		loadSudoku(fileName)
	end
	
	# Puts the content of a string into the grid to be solved
	def gridModify(sudokuString)
		@gridToComplete.stringToGrid(sudokuString)
	end
	
	# Puts the content of a string into the solved grid
	def completedModify(sudokuString)
		@gridCompleted.stringToGrid(sudokuString)
	end
	
	# Returns the color list, in RGB
	def getColorList()
		return @colorList
	end
	
	# Returns a color in particular, in RGB
	def getColor(colorNb)
		return @colorList[colorNb]
	end
	
	# Returns the amount of red in a color
	def getRed(colorNb)
		return getColor(colorNb)[0]
	end
	
	# Returns the amount of red in a color
	def getGreen(colorNb)
		return getColor(colorNb)[1]
	end
	
	# Returns the amount of red in a color
	def getBlue(colorNb)
		return getColor(colorNb)[2]
	end
	
	def setColor(*args)
		if args.length == 3 then # i, couleur, quantite
			if args[1].to_i == 0 then
				setRed(args[0], args[2].to_i)
			elsif args[1].to_i == 1 then
				setGreen(args[0], args[2])
			elsif args[1].to_i == 2 then
				setBlue(args[0], args[2])
			end
		elsif args.length == 4 then # i, rouge, vert, bleu
			setRed(args[0],args[1])
			setGreen(args[0],args[2])
			setBlue(args[0],args[3])
		end
	end
	
	def setRed(i,r)
		@colorList[i][0] = r
		
		return self
	end
	
	def setGreen(i,g)
		@colorList[i][1] = g.to_i
		
		return self
	end
	
	def setBlue(i,b)
		@colorList[i][2] = b.to_i
		
		return self
	end
	
	# Checks if the sent value would be the correct one in the specified cell
	def isCorrectValue?(x, y, value)
		return @gridCompleted.getValue(x, y) == value
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
		
		return @gridCompleted.getValue(cellX, cellY) == @gridToComplete.getValue(cellX, cellY) || @gridToComplete.getValue(cellX, cellY) == 0
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
			saveFile.write self.gridToComplete[i].getValue()
		end
		
		saveFile.write "\n"
		
		for i in 0..80
			saveFile.write self.gridCompleted[i].getValue()
		end
		
		saveFile.write "\n"
		
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
		
		fileContent = IO.readlines(fileName)
		
		# Grids
		sudokuToBeCompleted = fileContent[0]
		sudokuCompleted = fileContent[1]
		
		colorListBuffer = Array.new(4,Array.new(3,0))
		
		# Color code
		for i in 0..3
			colorList = fileContent[3+i]
			colors = colorList.gsub(/,+/m, ',').strip.split(",")
			
			@colorList[i] = Array.new(3)
			
			for j in 0..2
				@colorList[i][j] = (colors[j].to_i / 255.0).round(2)
			end
		end
		
		self.gridModify(sudokuToBeCompleted)
		self.completedModify(sudokuCompleted)
		
		loadFile.close

		if(loadFile.closed?)
			print "Chargement terminé !\n"
		end
	end
	
	### PRINT
	def colorPrint()
		for i in 0..3
			print "Couleur " + i.to_s + " : " + getColor(i).to_s + "\n"
		end
	end
	
	def afficher()
		#@gridToComplete.afficher()
		print "\n"
		#@gridCompleted.afficher()
		print "\n"
		colorPrint()
	end
	
	### TESTS
	def Sudoku.test()
		sudokuFile = "./save_files/sudoku.txt"
		
=begin
		if system('save_files/sudoku_generator.exe', sudokuFile) == false then
			print "Error during the sudoku generation process"
		end
=end

		###Saves
		#Read
		sudokuRead = Sudoku.lire(sudokuFile)
		sudokuRead.afficher()

		### Tests
		print "\nValeur en 3, 5 : 9 ?\n"
		print sudokuRead.gridCompleted.getValue(3,5), " - ", sudokuRead.isCorrectValue?(3, 5, 9),  "\n"

		print "\nFirst grid correct ? (Should be TRUE)\n"
		print sudokuRead.isCorrectGrid?(), "\n"

		print "\nSauvegarde du sudoku actuel sous le nom 'profil_test.txt' :\n"
		sudokuRead.saveSudoku("profil_test.txt")
	end
end


Sudoku.test()