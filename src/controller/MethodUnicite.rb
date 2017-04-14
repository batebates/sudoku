class MethodUnicite < Methode
	@tab
	#===Lance une explication textuelle de la methode
	def textMethod
    case @step
			when nil
			@type = "textMethod"
			@step = 0
			statutMethod(true)
		  SudokuAPI.API.assistantMessage=("Cette méthode repose sur le principe\nqu'un sudoku possède une unique solution")
		 when 1
		  SudokuAPI.API.assistantMessage=("Ainsi si quatre cellules dans deux régions différentes\nforment un rectangle comporte une paire de candidats identiques\n sur trois de ces cellules ")
		 when 2
		  SudokuAPI.API.assistantMessage=("Et que la quatrième comporte cette paire ainsi\nque d'autres candidats")
		 when 3
		  SudokuAPI.API.assistantMessage=("Alors la solution de cette cellule est forcement\nparmis ces candidats en plus.")
		 when 4
		  SudokuAPI.API.assistantMessage=("En effet la grille possède une solution unique, il ne peut pas y avoir\n4 paires identiques formant un rectangle sur deux regions differentes")
			when 5
		 	SudokuAPI.API.assistantMessage=("");
		  statutMethod(false)
    end
		@step+=1
	end

	#===Lance la methode sur une grille de demonstration
	def demoMethod
		@type = "demoMethod"
  	case @step
	  	when nil
				@step = 0
	  		statutMethod(true)
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
				statutMethod(false)
		 end
		@step+=1
	end

	#===Lance la methode sur la grille actuelle
	def onSudokuMethod
		@type = "onSudokuMethod"
		case @step
			when nil
				@step = 0
				@tab = regionPaireCandidats
				puts("Contenu du tableau")
				puts(@tab)
				statutMethod(true)
				if(!@tab.empty?)
					SudokuAPI.API.assistantMessage=("On recherche quatres cellules composées d'une paire de candidats identiques formant un rectangle sur deux régions différentes");
					@tab.each do |elt|
						SudokuAPI.API.cazeAt(elt.x,elt.y).color=Colors::CL_NUMBER_LOCKED
					end
					SudokuAPI.API.cazeAt(@tab.first.x,@tab.first.y).color=Colors::CL_HIGHLIGHT_METHOD
				else
					SudokuAPI.API.assistantMessage=("La Méthode choisi n'est pas applicable\nsur cette grille pour le moment ");
				end
			when 1
				if !@tab.empty?
					SudokuAPI.API.getInclude(@tab.first.x,@tab.first.y) - SudokuAPI.API.getInclude(@tab.last.x,@tab.last.y).each {|n| SudokuAPI.API.addExclude(@tab.first.x, @tab.first.y, n)}
				end
				statutMethod(false)
		end

			@step+=1
	end

	#===Renvoie un tableau contenant les 4 cellules permettant d'appliquer la méthode ou nil si la méthode ne peut pas être utilisé
	#
	def regionPaireCandidats
		squareTab = Array.new
		0.upto(8).each do |i|
			elt = SudokuAPI.API.getUnite(2,i)
 			if elt.count{ |caze| SudokuAPI.API.getInclude(caze.x,caze.y).count == 2 } >= 2
				squareTab.push(elt.delete_if{|caze| SudokuAPI.API.getInclude(caze.x,caze.y).count != 2 })
			end
		end
		tabCouple = Array.new
		squareTab.each do |square|
			square.each do |caze|
				searchCouple(caze,square).each do |elt|
						tabCouple.push(elt)
				end
			end
		end
		solutionTab = Array.new
		tabCouple.each do |couple|
			if(couple[0].x == couple[1].x)
				solutionTab.push(casesParallel(couple,'r'))
			else
				solutionTab.push(casesParallel(couple,'c'))
			end
		end

		return solutionTab.flatten.take(4)
	end

	#===Determine si deux cases ont la même pair d'indice
	#
	# Params:
	# @param x [int] indique la coordonnée de l'axe des abscisses d'une case
	# @param y [int] indique la coordonnée de l'axe des ordonnées d'une case
	# @param c [Caze] deuxième case
	def samePairHint?(x,y,c)
		return SudokuAPI.API.cazeAt(x,y).value == 0 && SudokuAPI.API.getInclude(x,y) == SudokuAPI.API.getInclude(c.x,c.y)
	end

	#===Determine si deux cases contiennent la même pair d'indice
	#
	# Params:
	# @param h1 [int] indique la coordonnée de l'axe des abscisses d'une case
	# @param h2 [int] indique la coordonnée de l'axe des ordonnées d'une case
	# @param c [Caze] deuxième case
	def containPairHint?(h1,h2,c)
		return c.value == 0 && SudokuAPI.API.getInclude(c.x,c.y).include?(h1) && SudokuAPI.API.getInclude(c.x,c.y).include?(h2)
	end

	#===Renvoie un tableau de case contenant les mêmes indices qu'une case
	#
	# Params:
	# @param lst [ArrayList] Liste de case
	# @param y [c1] case contenant les indices a comparé
	def getHintEquals(lst,c1)
		return lst.delete_if{|c2| !samePairHint?(c2.x,c2.y,c1)}
	end


	#=== Renvoi les quatres cases de la methode en fonction de la paire de cases en parametres
	#
	# Params:
	# @param paire [ArrayList] Paire de cases appartenant à la meme region et possedant la meme paire de candidats
	# @param u [Char] case contenant les indices a comparé
	def casesParallel(paire,u)
		if(u=='r')
			tab1 = SudokuAPI.API.row(paire[0].y).delete_if{|c| SudokuAPI.API.square(paire[0].x,paire[0].y).include?(c) || c.value !=0}
			tab2 = SudokuAPI.API.row(paire[1].y).delete_if{|c| SudokuAPI.API.square(paire[1].x,paire[1].y).include?(c) || c.value !=0}
		else
			tab1 = SudokuAPI.API.column(paire[0].x).delete_if{|c| SudokuAPI.API.square(paire[0].x,paire[0].y).include?(c) || c.value !=0}
			tab2 = SudokuAPI.API.column(paire[1].x).delete_if{|c| SudokuAPI.API.square(paire[1].x,paire[1].y).include?(c) || c.value !=0}
		end
		fourCornerTab = Array.new
		fourCornerTab.push(lastCorner(getHintEquals(tab1,paire[0]),paire,u))
		fourCornerTab.push(lastCorner(getHintEquals(tab2,paire[0]),paire,u))
		return fourCornerTab
	end

	#===Recherche parmis une liste la troisieme case de la methode et en deduit si possible la quatrieme case
	#
	# Params:
	# @param lst [ArrayList]
	# @param paire [ArrayList] Paire de cases appartenant à la meme region et possedant la meme paire de candidats
	# @param u [Char] case contenant les indices a comparé
	def lastCorner(lst,pair,u)
		lst.each{ |c3|
			if(u=='r')
				x = [c3.x,c3.x]
				y = [pair[0].y,pair[1].y]
			else
				y = [c3.y,c3.y]
				x = [pair[0].x,pair[1].x]
			end
			if(containPairHint?(SudokuAPI.API.getInclude(pair[0].x,pair[0].y)[0],SudokuAPI.API.getInclude(pair[0].x,pair[0].y)[1],SudokuAPI.API.cazeAt(x[0],y[0])))
				pair.push(c3)
				pair.unshift(SudokuAPI.API.cazeAt(c3.x,pair[0].y))
				return pair
			end
		}
		return []
	end
	def searchCouple(c1,square)
			pair = Array.new
			c2lst = square.select{|c| c.value == 0  && SudokuAPI.API.getInclude(c1.x,c1.y) == SudokuAPI.API.getInclude(c.x,c.y) && ((c1.x == c.x && c1.y != c.y) || (c1.x != c.x && c1.y == c.y))}
			c2lst.each do |c2|
				pair.push([c1,c2])
			end
			return pair
	end


end
