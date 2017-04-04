class Methode

	attr_accessor :step, :type

	def update()
		self.send(@type);
	end

	def textMethod
		raise "Ceci est une methode abstraite. This is an abstact method.";
	end

	def demoMethod
		raise "Ceci est une methode abstraite. This is an abstact method.";
	end

	def onSudokuMethod
		raise "Ceci est une methode abstraite. This is an abstact method.";
	end

	
end
