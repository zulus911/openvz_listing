class Vzlist
	attr_reader :json_res, :command
	def initialize (command = 'vzlist')
		@command = command
	end
    def execute_command ()
    	@json_res = exec(@command)
    	
    	puts @json_res
    end    
end


test = Vzlist.new("")
