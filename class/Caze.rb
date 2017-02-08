class Caze
	@x
	@y
	@value
	attr_accessor:value

	def initialize(x,y,value) 
		self.x,self.y,self.value = x.to_i, y.to_i, value.to_i
	end

	private_class_method :new
	
	def Caze.create(x,y,value)
		new(x,y,value)
	end
	
end
