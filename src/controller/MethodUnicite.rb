class MethodUnicite


	@type = "textMethod"
	@step = 0

	def initialize()
		@step,@type=0,"textMethod"

	end
	def textMethod
		@type = "textMethod"
    case @step
    when 0
      SudokuAPI.API.assistantMessage=("Cette méthode repose sur le principe qu'un sudoku possède une unique Solution")
    when 1
      SudokuAPI.API.assistantMessage=("Ainsi si quatre cellules dans deux régions différentes forment un rectangle comporte une paire de candidats identiques sur trois de ces cellules ")
    when 2
      SudokuAPI.API.assistantMessage=("Et que la quatrième comporte cette paire ainsi que d'autres candidats")
    when 3
      SudokuAPI.API.assistantMessage=("Alors la solution de cette cellule est forcement parmis ces candidats en plus.")
    when 4
      SudokuAPI.API.assistantMessage=("En effet la grille possède une solution unique, il ne peut pas y avoir 4 paires identiques formant un rectangle sur deux regions differentes")
    end
		@step+=1
	end

	def demoMethod
		@type = "demoMethod"
  	case @step
	  	when 0
				SudokuAPI.API.saveSudoku("old");
				gridDemo = "375648129010925070200371000732089060400267000060034792020453917147896235953712648"
				SudokuAPI.API.setSudoku(Sudoku.create(gridDemo),Sudoku.create(gridDemo),Sudoku.create(gridDemo));
				tab = regionPaireCandidats
				if(tab != nil)
				SudokuAPI.API.assistantMessage=("On recherche quatres cellules composées d'une paire de candidats identiques formant un rectangle sur deux régions différentes");
				tab.each do |elt|
					print "case:"
					print elt.x
					print elt.y
					print "\n"
					SudokuAPI.API.cazeAt(elt.x,elt.y).color=Colors::CL_NUMBER_LOCKED
				end
				else
					print("La methode a renvoyer nul")
				end

				SudokuAPI.API.assistantMessage=("Bienvenue dans la démo (cliquez sur suivant pour continuer");
		when 1
				SudokuAPI.API.cazeAt(0,1).color=Colors::CL_NUMBER_LOCKED;
				SudokuAPI.API.cazeAt(2,1).color=Colors::CL_NUMBER;
				SudokuAPI.API.cazeAt(0,6).color=Colors::CL_NUMBER_LOCKED;
				SudokuAPI.API.cazeAt(2,6).color=Colors::CL_NUMBER_LOCKED;

				0.upto(8) do |i|
					0.upto(8) do |j|
						SudokuAPI.API.setHintAt(i,j,true)
					end
				end
				SudokuAPI.API.assistantMessage=("Les quatres cases colorées possèdent la même paire de candidats 6 et 8 ");
		 when 2
		   SudokuAPI.API.assistantMessage=("Comme la solution d'un sudoku est unique, la case grisé qui possède des candidats en plus de la paire n'a pour solution que ces candidats");
		 when 3
		   SudokuAPI.API.assistantMessage=("On peut donc éliminer la paire de candidat de cette cellule");
		 when 4
				SudokuAPI.API.loadSudoku("old");
				SudokuAPI.API.assistantMessage=("Bonjour, je suis l'assistant, je suis là pour vous aider");
		 end
		@step+=1
	end

	def onSudokuMethod
		@type = "onSudokuMethod"
		case @step
		when 0
			tab = regionPaireCandidats
			if(tab != nil)
				SudokuAPI.API.assistantMessage=("On recherche quatres cellules composées d'une paire de candidats identiques formant un rectangle sur deux régions différentes");
				tab.each do |elt|
					print "case:"
					print elt.x
					print elt.y
					print "\n"
					SudokuAPI.API.cazeAt(elt.x,elt.y).color=Colors::CL_NUMBER_LOCKED
				end
			else
				SudokuAPI.API.assistantMessage=("La Méthode choisi n'est pas applicable sur cette grille pour le moment ");
			end
		when 1

		end

		#TODO enableHint False

		@step+=1
	end

	def regionPaireCandidats
		squares = Array.new
		0.upto(8) do |i|
			squares.push(SudokuAPI.API.getUnite(2,i))
		end
		squares.each{|elt|
			if elt.count{ |caze| SudokuAPI.API.getInclude(caze.x,caze.y).count == 2 } >= 2
				elt.each{ |c1|
					res = searchSquare(c1)
					if (res != nil)
						return res
					end
				}
			end
		}

		return nil
	end
	def samePairHint?(x,y,c)
		return SudokuAPI.API.getInclude(x,y).include?(SudokuAPI.API.getInclude(c.x,c.y)[0]) && SudokuAPI.API.getInclude(x,y).include?(SudokuAPI.API.getInclude(c.x,c.y)[1])
	end

	def getHintEquals(lst,c1)
		return lst.keep_if{|c2| SudokuAPI.API.getInclude(c1.x,c1.y) == SudokuAPI.API.getInclude(c2.x,c2.y)}
	end


	def searchSquare(c1)
		if (SudokuAPI.API.getInclude(c1.x,c1.y).count == 2)
					pair = new Array
					pair.push(c1)
					c2 = elt.bsearch{|c2| c2!=c1 && SudokuAPI.API.getInclude(c1.x,c1.y) == SudokuAPI.API.getInclude(c2.x,c2.y) && (c1.x == c2.x || c1.y == c2.y)}
					if c2.class == Caze
						pair.push(c2)
						#Pair contient 2 case aligné de la même région
							if pair[0].x == pair[1].x
								row1 = SudokuAPI.API.row(pair[0].x,pair[0].y).delete_if{|c| elt.include?(c)}
								row2 = SudokuAPI.API.row(pair[1].x,pair[1].y).delete_if{|c| elt.include?(c)}
								lstC3 = getHintEquals(row1,c2)
								lstC3.each{ |c3|
									if( contientPair(c3.x,pair[1].y,c1))
									 	pair.push(c3)
									 	pair.unshift(SudokuAPI.API.caseAt(c3.x,pair[1].y))
									 	return pair
									end


								}
								lstC3 = getHintEquals(row2,c2)
								lstC3.each{ |c3|
									if(contientPair(c3.x,pair[0].y,c1))
									 	pair.push(c3)
									 	pair.unshift(SudokuAPI.API.caseAt(c3.x,pair[0].y))
									 	return pair
									end


								}



							else
								column1 = SudokuAPI.API.column(pair[0].x,pair[0].y).delete_if{|c| elt.include?(c)}
								column2 = SudokuAPI.API.column(pair[1].x,pair[1].y).delete_if{|c| elt.include?(c)}
								lstC3 = getHintEquals(column1,c2)
								lstC3.each{ |c3|
									if(contientPair(pair[1].x,c3.y,c1))
									 	pair.push(c3)
									 	pair.unshift(SudokuAPI.API.caseAt(c3.x,pair[1].y))
									 	return pair
									end


								}
								lstC3 = getHintEquals(column2,c2)
								lstC3.each{ |c3|
									if(contientPair(pair[0].x,c3.y,c1))
									 	pair.push(c3)
									 	pair.unshift(c3.x,pair[0].y)
									 	return pair
									end


								}
							end


					end
			end
		return nil
	end

	def update
		if(@type == "demoMethod")
			self.demoMethod()
		elsif(@type == "onSudokuMethod")
			self.onSudokuMethod()
		end
	end

	#===Test si le nombre de candidats d'une case correspond a un nombre
	#
	#===Paramètres :
	#* <b>caze</b> : Caze : case à tester
	#* <b>n</b> : nombre de candidats supposé
	def nbCandidats(caze,n)

	end

end