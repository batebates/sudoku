#<b>Auteur</b> Zerbane Mehdi
#
#<b>Version</b> 1.0
#
#<b>Date</b> 18/03/2017
#
#=== Methode de la reduction par croix
#<b>Liste des méthodes
#*textMethod
#*demoMethod
#*onSudokuMethod
#*candidateOnSquareNumber
#*inOneTab
#*parcourBeetweenRow
#*traitementOnRow
#*squareNumber
#</b>

class MethodTwinsAndTriplets < Methode
	

	@compteur = 0
	@cand = nil

	#===Affiche le texte de description de la méthode
	def textMethod
		case @step
			when nil
			@type = "textMethod"
			@step = 0
			SudokuAPI.API.hideMenu(true)
			SudokuAPI.API.sudokuEditable(true)
			SudokuAPI.API.assistantMessage=("Cette méthode nous permet de déduire dans quelle partie d'une \nrégion peut se trouver un symbole. En effet il n'est pas toujours\névident de découvrir dès le début l'emplacement final et définitif.")
			when 1
			SudokuAPI.API.assistantMessage=("Si un candidat se trouve uniquement par exemple dans la dernière\n ligne d'une région il se trouvera donc obligatoirement\ndans cette ligne.")
			when 2
				SudokuAPI.API.assistantMessage=("Bonjour,je suis l'assistant, je suis là pour vous aider")
				SudokuAPI.API.hideMenu(false)
				SudokuAPI.API.sudokuEditable(false)
		end
		@step+=1
	end

	#===Affiche a la place de la grille actuelle une nouvelle grille sur laquelle on execute comme un tutoriel la technique
	def demoMethod
		@type = "demoMethod"
		if(@step==nil)
			@step = 0
			SudokuAPI.API.saveSudoku("old");
			SudokuAPI.API.hideMenu(true)
			SudokuAPI.API.sudokuEditable(true)
			gridDemo = "375648129010925070200371000732089060000267000060034792020453917147896235953712648"	
			SudokuAPI.API.setSudoku(Sudoku.create(gridDemo),Sudoku.create(gridDemo),Sudoku.create(gridDemo));
			SudokuAPI.API.assistantMessage=("Bienvenue dans la démo (Appuyez sur Suivant)");
		elsif(@step==1)
			SudokuAPI.API.cazeAt(0,4).color=Colors::CL_NUMBER_LOCKED;
			SudokuAPI.API.cazeAt(2,4).color=Colors::CL_NUMBER_LOCKED;
			SudokuAPI.API.cazeAt(6,4).color=Colors::CL_HIGHLIGHT_METHOD;
			SudokuAPI.API.cazeAt(8,4).color=Colors::CL_HIGHLIGHT_METHOD;
			SudokuAPI.API.assistantMessage=("Les 2 candidats 4, alignés dans cette région (en rouge),\n donnent la possibilité de supprimer les 4 dans les autres régions\n de cette ligne (en gris)");
		elsif(@step==2)	
			SudokuAPI.API.loadSudoku("old");
			SudokuAPI.API.hideMenu(false)
			SudokuAPI.API.sudokuEditable(false)
			SudokuAPI.API.assistantMessage=("Bonjour, je suis l'assistant, je suis là pour vous aider.")
		end
		@step+=1
	end

	#===Methode qui execute la methode Twins And Triplets sur la grille
	def onSudokuMethod
		@type = "onSudokuMethod"
		if(@step==nil)
			@step = 0
			SudokuAPI.API.hideMenu(true)
			SudokuAPI.API.sudokuEditable(true)
			SudokuAPI.API.assistantMessage=("Nous allons appliquer cette méthode sur la grille actuel \n(cliquez sur suivant pour continuer)");
		elsif(@step==1)
			@compteur=0
			0.upto(8) do |region|
				1.upto(3) do |n|
					traitementOnRow(region,1,n)
					traitementOnRow(region,0,n)
				end
			end
			if(@cand!=nil)
				SudokuAPI.API.assistantMessage=("Le candidat " + @cand.to_s + " n'est présent que sur ces deux cases,\n il est donc obligé de le placer ici.");
			else
				SudokuAPI.API.assistantMessage=("Il n'est pas possible d'appliquer cette méthode sur la grille.");
			end
		elsif(@step==2)
			SudokuAPI.API.hideMenu(false)
			SudokuAPI.API.sudokuEditable(false)
			SudokuAPI.API.resetColors()
			SudokuAPI.API.assistantMessage=("Bonjour, je suis l'assistant, je suis là pour vous aider.")
		end
		@step+=1
	end

    #===Renvoit un tableau contenant la liste des candidats d'une unite
    #
    # Params:
    # @param tab Le tableau d'unité
	def candidateOnSquareNumber(tab)
		candid=0
		tab_tmp=Array.new()
		tab.each do |elt|
			if(elt.value==0)
				tab_tmp<<SudokuAPI.API.candidateCaze(elt.x,elt.y)
				candid+=1
			end
		end
		return tab_tmp
	end

    #===Renvoit un tableau qui contient plus d'une fois le meme chiffre
    #
    # Params:
    # @param tab Le tableau des candidats d'une unite
	def inOneTab(tab)
		return tab.flatten.uniq.map { | e | [tab.flatten.count(e), e] }.select { | c, _ | c > 1 }.sort.reverse.map { | c, e | "#{e}" }
	end

    #===Renvoit un tableau contenant les candidats communs d'une unite
    #
    # Params:
    # @param start Le tableau de candidats de la case
    # @param compare Le tableau de candidats de la case suivante
	def parcourBeetweenRow(start,compare)
		end_ = Array.new()
		start.each{ |elt|	
			if((candidateOnSquareNumber(compare)).flatten.uniq.include?(elt.to_i)==false)	
					end_<<elt.to_i
			end
		}
		return end_
	end

    #===Traitement principal de la methode, on colorise les cases sur lesquelles il est possible d'appliquer la methode
    #
    # Params:
    # @param region Indique la region sur laquelle on se trouve
    # @param sens Indique le sens (Horizontal/Vertical)
    # @param ligne Le numero de la ligne dans la region
	def traitementOnRow(region,sens,ligne)
		if(ligne==1)
			tab = squareNumber(region,0,sens) #retourne case d'une ligne ou colonne
			tab2 = squareNumber(region,1,sens) #retourne case d'une ligne ou colonne
			tab3 = squareNumber(region,2,sens) #retourne case d'une ligne ou colonne
		elsif(ligne==2)
			tab = squareNumber(region,1,sens) #retourne case d'une ligne ou colonne
			tab2 = squareNumber(region,0,sens) #retourne case d'une ligne ou colonne
			tab3 = squareNumber(region,2,sens) #retourne case d'une ligne ou colonne
		elsif(ligne==3)
			tab = squareNumber(region,2,sens) #retourne case d'une ligne ou colonne
			tab2 = squareNumber(region,1,sens) #retourne case d'une ligne ou colonne
			tab3 = squareNumber(region,0,sens) #retourne case d'une ligne ou colonne
		end
		save = Array.new() 
		tmp = Array.new() 
		save = parcourBeetweenRow(inOneTab(candidateOnSquareNumber(tab)),tab2)
		tmp=parcourBeetweenRow(save,tab3)
		i,j=0,0
		tab.each{ |elt|
			i,j=elt.x,elt.y
			SudokuAPI.API.candidateCaze(i,j).each{ |el|
				if(el==tmp[0] && elt.value==0)
					if(@compteur<=1)
						SudokuAPI.API.cazeAt(elt.x,elt.y).color=Colors::CL_NUMBER_LOCKED;
						@compteur+=1
						@cand = tmp[0]
					end
				end
				
			}
		}
	end

    #===Renvoit un tableau contenant les cases d'une unite
    #
    # Params:
    # @param region Indique la region sur laquelle on se trouve
    # @param sens Indique le sens (Horizontal/Vertical)
    # @param number Le numero de la ligne dans la region
	def squareNumber(region,number,sens)
		tab_region = SudokuAPI.API.squareN(region)
		i = 0
		sous_region=Array.new()
		tab_region.each do |elt|
			if(sens==0)
				if(i/3==number)
					sous_region<<elt
				end
			elsif(sens==1)
				if(i%3==number)
					sous_region<<elt
				end

			end
			i+=1
		end
		return sous_region
	end
end

