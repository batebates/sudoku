load 'Caze.rb'
load 'SudokuAPI.rb'
class Sudoku

	@tcaze

	attr_reader :tcaze

	def initialize(str)
        @tcaze = Array.new()
        tab = str.split("")
		cpt=0
		tab.each_index do |i|
			@tcaze << Caze.create(i-10*cpt,cpt,tab[i])
			if(i%9 == 0) 
				cpt+=1
			end
		end
		  
	end

	private_class_method :new
	
	def Sudoku.create(caze)
		new(caze)
	end
	
	def cazeAt(x,y)
		return @tcaze[x][y]
	end

	def setValue(x,y,val)
		 return @tcaze[x][y].value=(val)
	end

	def valueCheck?(x,y)
		return @tcaze[x][y].value!=nil
	end
	
	def gridFull()
		res = true
		@tcaze.each do |elt|
			if elt.value==nil
				res = false
			end
		end
		return res
	end

    def to_s
        return ""
    end
end
