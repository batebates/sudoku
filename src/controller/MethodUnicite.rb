class MethodUnicite < Methode


	def textMethod
    case @step
		 when nil
		 	@type = "textMethod"
			@step = 0
		 	SudokuAPI.API.hideMenu(true)
		 	SudokuAPI.API.sudokuEditable(true)
		   SudokuAPI.API.assistantMessage=("Cette méthode repose sur le principe\nqu'un sudoku possède une unique solution")
		 when 1
		   SudokuAPI.API.assistantMessage=("Ainsi si quatre cellules dans deux régions différentes\forment un rectangle comporte une paire de candidats identiques\n sur trois de ces cellules ")
		 when 2
		   SudokuAPI.API.assistantMessage=("Et que la quatrième comporte cette paire ainsi\nque d'autres candidats")
		 when 3
		   SudokuAPI.API.assistantMessage=("Alors la solution de cette cellule est forcement\nparmis ces candidats en plus.")
		 when 4
		   SudokuAPI.API.assistantMessage=("En effet la grille possède une solution unique, il ne peut pas y avoir\n4 paires identiques formant un rectangle sur deux regions differentes")
		 when 5
		 	SudokuAPI.API.assistantMessage=("");
		  	SudokuAPI.API.hideMenu(false)
			SudokuAPI.API.sudokuEditable(false)
    end
		@step+=1
	end

	def demoMethod
		@type = "demoMethod"
  	case @step
	  	when nil
				@step = 0
	  			SudokuAPI.API.hideMenu(true)
	  			SudokuAPI.API.sudokuEditable(true)
				SudokuAPI.API.saveSudoku("old");
				gridDemo = "375648129010925070200371000732089060400267000060034792020453917147896235953712648"
				SudokuAPI.API.setSudoku(Sudoku.create(gridDemo),Sudoku.create(gridDemo),Sudoku.create(gridDemo));
				SudokuAPI.API.assistantMessage=("Bienvenue dans la démo (cliquez sur suivant pour continuer)");
		when 1
			SudokuAPI.API.cazeAt(0,1).color=Colors::CL_NUMBER_LOCKED;
			SudokuAPI.API.cazeAt(2,1).color=Colors::CL_HIGHLIGHT_METHOD;
			SudokuAPI.API.cazeAt(0,6).color=Colors::CL_NUMBER_LOCKED;
			SudokuAPI.API.cazeAt(2,6).color=Colors::CL_NUMBER_LOCKED;

			0.upto(8) do |i|
				0.upto(8) do |j|
					SudokuAPI.API.setHintAt(i,j,true)
				end
			end
			SudokuAPI.API.assistantMessage=("Les quatres cases colorées possèdent la même paire\nde candidats 6 et 8 ");
		 when 2
		   SudokuAPI.API.assistantMessage=("Comme la solution d'un sudoku est unique,\nla case grisé qui possède des candidats en plus de\nla paire n'a pour solution que ces candidats");
		 when 3
		   SudokuAPI.API.assistantMessage=("On peut donc éliminer la paire de candidat de cette cellule");
		 when 4
				SudokuAPI.API.loadSudoku("old");
				SudokuAPI.API.assistantMessage=("Bonjour, je suis l'assistant, je suis là pour vous aider");
				SudokuAPI.API.hideMenu(false)
				SudokuAPI.API.sudokuEditable(false)
		 end
		@step+=1
	end

	def onSudokuMethod
		@type = "onSudokuMethod"
		case @step
			when nil
				@step = 0
				SudokuAPI.API.hideMenu(true)
				SudokuAPI.API.sudokuEditable(true)
				tab = regionPaireCandidats
				if(tab != nil)
				puts("Affichage de tab")
				tab.each do |elt|
					puts(elt)
				end
					SudokuAPI.API.assistantMessage=("On recherche quatres cellules composées d'une paire de candidats identiques formant un rectangle sur deux régions différentes");
					tab.each do |elt|
						SudokuAPI.API.cazeAt(elt.x,elt.y).color=Colors::CL_NUMBER_LOCKED
					end
					SudokuAPI.API.cazeAt(tab.first.x,tab.first.y).color=Colors::CL_HIGHLIGHT_METHOD
				else
					SudokuAPI.API.assistantMessage=("La Méthode choisi n'est pas applicable\nsur cette grille pour le moment ");
				end
			when 1
					SudokuAPI.API.getInclude(tab.first.x,tab.first.y) - SudokuAPI.API.getInclude(tab.last.x,tab.last.y).each {|n| SudokuAPI.API.addExclude(tab.first.x, tab.first.y, n)}
					SudokuAPI.API.hideMenu(false)
					SudokuAPI.API.sudokuEditable(false)
		
		end
		@step+=1
	end

	#===Renvoie un tableau contenant les 4 cellules permettant d'appliquer la méthode ou nil si la méthode ne peut pas être utilisé
	#
	def regionPaireCandidats
		0.upto(8).each{|i|
			elt = SudokuAPI.API.getUnite(2,i)
			if elt.count{ |caze| 
			SudokuAPI.API.getInclude(caze.x,caze.y).count == 2 } >= 2 
				puts ("Region possedant plus de deux pair de candidats")
				puts(i)
				elt.each{ |c1|
					if c1.value == 0
						res = searchSquare(c1,elt)
						if (res != nil)
							puts ("Tableau de resultat trouver")
							return res
						end
					end
				}
			end
		}
		return nil
	end

	#===Determine si deux cases ont la même pair d'indice
	#
	#===Paramètres :
	#* <b>x</b> : int : indique la coordonnée de l'axe des abscisses d'une case
	#* <b>y</b> : int : indique la coordonnée de l'axe des ordonnées d'une case
	#* <b>c</b> : Caze : deuxième case
	def samePairHint?(x,y,c)
		return SudokuAPI.API.cazeAt(x,y).value == 0 && SudokuAPI.API.getInclude(x,y) == SudokuAPI.API.getInclude(c.x,c.y)
	end
	
	#===Determine si deux cases contiennent la même pair d'indice
	#
	#===Paramètres :
	#* <b>h1</b> : int : indique la coordonnée de l'axe des abscisses d'une case
	#* <b>h2</b> : int : indique la coordonnée de l'axe des ordonnées d'une case
	#* <b>c</b> : Caze : deuxième case
	def containPairHint?(h1,h2,c)
		return c.value == 0 && SudokuAPI.API.getInclude(c.x,c.y).include?(h1) && SudokuAPI.API.getInclude(c.x,c.y).include?(h2)
	end

	#===Renvoie un tableau de case contenant les mêmes indices qu'une case
	#
	#===Paramètres :
	#* <b>lst</b> : ArrayList : Liste de case
	#* <b>y</b> : c1 : case contenant les indices a comparé
	def getHintEquals(lst,c1)
		return lst.delete_if{|c2| !samePairHint?(c2.x,c2.y,c1)}
	end



	def rowCaseParallel(pair,square)
		row1 = SudokuAPI.API.row(pair[0].y).delete_if{|c| square.include?(c) || c.value !=0}
		row2 = SudokuAPI.API.row(pair[1].y).delete_if{|c| square.include?(c) || c.value !=0}
		lstC3 = getHintEquals(row1,pair[0])
		lstC3.each{ |c3|
			if( containPairHint?(SudokuAPI.API.getInclude(pair[0].x,pair[0].y)[0],SudokuAPI.API.getInclude(pair[0].x,pair[0].y)[1],SudokuAPI.API.cazeAt(c3.x,pair[1].y)))
				puts ("Case 3 trouver R1")
				pair.push(c3)
				pair.unshift(SudokuAPI.API.cazeAt(c3.x,pair[1].y))
				return pair
			end
		}
		lstC3 = getHintEquals(row2,pair[0])
		lstC3.each{ |c3|
			if(containPairHint?(SudokuAPI.API.getInclude(pair[0].x,pair[0].y)[0],SudokuAPI.API.getInclude(pair[0].x,pair[0].y)[1],SudokuAPI.API.cazeAt(c3.x,pair[0].y)))
				puts ("Case 3 trouver R2")
				pair.push(c3)
				pair.unshift(SudokuAPI.API.cazeAt(c3.x,pair[0].y))
				return pair
			end
		}
		return nil
	end

	def columnCaseParallel(pair,square)
		column1 = SudokuAPI.API.column(pair[0].x).delete_if{|c| square.include?(c) || c.value !=0}
		puts("Column1")
		puts(column1.count)
		column2 = SudokuAPI.API.column(pair[1].x).delete_if{|c| square.include?(c) || c.value !=0}
		puts("column2")
		puts(column2.count)
		lstC3 = getHintEquals(column1,pair[0])
		puts("lstC3 C1")
		puts(lstC3.count)
		lstC3.each{ |c3|
			if(containPairHint?(SudokuAPI.API.getInclude(pair[0].x,pair[0].y)[0],SudokuAPI.API.getInclude(pair[0].x,pair[0].y)[1],SudokuAPI.API.cazeAt(pair[1].x,c3.y)))
				puts ("Case 3 trouver C1")
				pair.push(c3)
				pair.unshift(SudokuAPI.API.cazeAt(c3.x,pair[1].y))
				return pair
			end
		}
		
		lstC3 = getHintEquals(column2,pair[0])
		puts("lstC3 C2")
		puts(lstC3.count)
		lstC3.each{ |c3|
			if(containPairHint?(SudokuAPI.API.getInclude(pair[0].x,pair[0].y)[0],SudokuAPI.API.getInclude(pair[0].x,pair[0].y)[1],SudokuAPI.API.cazeAt(pair[0].x,c3.y)))
				puts ("Case 3 trouver C2")
				pair.push(c3)
				pair.unshift(SudokuAPI.API.cazeAt(c3.x,pair[0].y))
				return pair
			end
		}
		return nil
	end

	def searchSquare(c1,square)
		if (SudokuAPI.API.getInclude(c1.x,c1.y).count == 2)
				puts ("Case 1 possedant une pair de candidats")
					pair = Array.new
					pair.push(c1)
					puts("Caracteristique de c1")
					puts("value",c1.value)
					puts("candidats",SudokuAPI.API.getInclude(c1.x,c1.y))
					c2lst = square.select{|c|
					puts("Caracteristique de c")
					puts("value",c.value)
					#puts("candidats",SudokuAPI.API.getInclude(c.x,c.y))
					#puts("((c1.x == c.x && c1.y != c.y) || (c1.x != c.x && c1.y == c.y))",((c1.x == c.x && c1.y != c.y) || (c1.x != c.x && c1.y == c.y)))
					#puts("SudokuAPI.API.getInclude(c1.x,c1.y) == SudokuAPI.API.getInclude(c.x,c.y)",SudokuAPI.API.getInclude(c1.x,c1.y) == SudokuAPI.API.getInclude(c.x,c.y))
					#puts("(c1.x == c.x || c1.y == c.y)",(c1.x == c.x || c1.y == c.y))
					
					 c.value == 0  && SudokuAPI.API.getInclude(c1.x,c1.y) == SudokuAPI.API.getInclude(c.x,c.y) && ((c1.x == c.x && c1.y != c.y) || (c1.x != c.x && c1.y == c.y))}
					if !c2lst.empty?
						c2lst.each{ |c2|
							puts ("Case 2  possedant la même pair de candidat")
							pair.push(c2)
						
							puts(pair[0].x)
							puts(pair[0].y)
							puts(pair[1].x)
							puts(pair[1].y)
							#Pair contient 2 case aligné de la même région
								if pair[0].x == pair[1].x
									puts ("Pair contient 2 case aligné de la même région R")
									res = rowCaseParallel(pair,square)
								else
									puts ("Pair contient 2 case aligné de la même région C")
									res =	columnCaseParallel(pair,square)
								end
								if res != nil
									puts ("Pair ne contient pas 2 case aligné de la même région")
									return res
								end
						}
					end
			end
		return nil
	end


end
