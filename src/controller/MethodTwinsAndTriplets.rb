class MethodTwinsAndTriplets
	
	@type = "textMethod"
	@step = 0
	@compteur
	@cand = nil
	def initialize()
		@step,@type,@compteur=0,"textMethod",0

	end
	def textMethod
		@type = "textMethod"
		SudokuAPI.API.assistantMessage=("Cette méthode nous permet de déduire dans quelle partie d'une région peut se trouver un symbole. En effet il n'est pas toujours évident de découvrir dès le début l'emplacement final et définitif. Si un candidat se trouve uniquement par exemple dans la dernière ligne d'une région il se trouvera donc obligatoirement dans cette ligne.")
		@step+=1
	end

	def demoMethod
		@type = "demoMethod"
		if(@step==0)
			SudokuAPI.API.saveSudoku("old");
			gridDemo = "375648129010925070200371000732089060000267000060034792020453917147896235953712648"	
			SudokuAPI.API.setSudoku(Sudoku.create(gridDemo),Sudoku.create(gridDemo),Sudoku.create(gridDemo));
			SudokuAPI.API.assistantMessage=("Bienvenue dans la démo (cliquez sur suivant pour continuer)");
		elsif(@step==1)
			SudokuAPI.API.cazeAt(0,4).color=Colors::CL_NUMBER_LOCKED;
			SudokuAPI.API.cazeAt(2,4).color=Colors::CL_NUMBER_LOCKED;
			SudokuAPI.API.cazeAt(6,4).color=Colors::CL_NUMBER;
			SudokuAPI.API.cazeAt(8,4).color=Colors::CL_NUMBER;
			SudokuAPI.API.enableHint(true);
			SudokuAPI.API.assistantMessage=("Les 2 candidats 4, alignés dans cette région (en rouge), donnent la possibilité de supprimer les 4 dans les autres régions de cette ligne (en gris)");
		elsif(@step==2)	
			SudokuAPI.API.enableHint(true);
			SudokuAPI.API.loadSudoku("old");
			SudokuAPI.API.assistantMessage=("");
		end
		@step+=1
	end

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

	def inOneTab(tab)
		return tab.flatten.uniq.map { | e | [tab.flatten.count(e), e] }.select { | c, _ | c > 1 }.sort.reverse.map { | c, e | "#{e}" }
	end

	def parcourBeetweenRow(start,compare)
		end_ = Array.new()
		start.each{ |elt|	
			if((candidateOnSquareNumber(compare)).flatten.uniq.include?(elt.to_i)==false)	
					end_<<elt.to_i
			end
		}
		return end_
	end

	def onSudokuMethod
		@type = "onSudokuMethod"
		if(@step==0)
			SudokuAPI.API.assistantMessage=("Nous allons appliquer cette méthode sur la grille actuel (cliquez sur suivant pour continuer)");
		elsif(@step==1)
			@compteur=0
			0.upto(8) do |region|
				1.upto(3) do |n|
					traitementOnRow(region,1,n)
					traitementOnRow(region,0,n)
				end
			end
			if(@cand!=nil)
				SudokuAPI.API.assistantMessage=("Le candidat " + @cand.to_s + " n'est présent que sur ces deux cases, il est donc obliger de le placer ici.");
			else
				SudokuAPI.API.assistantMessage=("Il n'est pas possible d'appliquer cette méthode sur la grille.");
			end
		elsif(@step==3)
			
		end
		@step+=1
	end

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

	def update
		if(@type == "demoMethod")
			self.demoMethod()
		elsif(@type == "onSudokuMethod")
			self.onSudokuMethod()
		end
	end

	
end

