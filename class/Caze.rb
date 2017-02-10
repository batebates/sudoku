

class Caze
    @x
    @y
    @value
	attr_accessor :value
	def initialize(x,y,value) 
		@x = x.to_i
        @y = y.to_i
        @value = value.to_i
	end

	private_class_method :new
	
	def Caze.create(x,y,value)
		new(x,y,value)
	end
	
    def to_s()
        return @value.to_s
    end
end
