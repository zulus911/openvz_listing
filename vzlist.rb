require 'logger'


class Vzlist
	$LOG=Logger.new('log/app.log', 'daily')
	@json_res 
	@command
	def initialize (ssh = false, *ssh_credentials)
		if not (ssh)
		    $LOG.debug('Use local vzlist') 
			@command = 'vzlist'
		elsif ssh_credentials.count == 3
			$LOG.debug('Use remote vzlist via ssh')
			@command = 'ssh '+ssh_credentials[0].to_s+'@'+ssh_credentials[1].to_s+' -p '+ssh_credentials[2].to_s+' "sudo vzlist -jo ctid"'
			$LOG.debug("initial line for ssh connection: '#{@command}'")
        else
        	$LOG.fatal("initialization fault")
        end
	end
	
    def execute_command ()
    	#begin
    		@json_res = system(@command)
    	#rescue Exception => error
    		#$LOG.fatal(error)
    	#end
    	#puts @json_res
    	#puts $?.exitstatus

    end    
end


test = Vzlist.new(true,"apanovich","88.85.72.50","21223")
test.execute_command