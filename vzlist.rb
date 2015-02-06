require 'logger'
require 'open3'
require 'json'

class Vzlist
	$LOG = Logger.new('log/app.log', 'daily')
	@ssh_string
	@remote
	def initialize (ssh = false, *ssh_cred)
		@options = options
		@remote = ssh 
		if not (ssh)
		    $LOG.debug('Use local vzlist') 
		elsif ssh_cred.count == 3
			$LOG.debug('Use remote vzlist via ssh')
			@ssh_string = 'ssh '+ssh_cred[0].to_s+'@'+ssh_cred[1].to_s+' -p '+ssh_cred[2].to_s
			$LOG.debug("initial line for ssh connection: '#{@ssh_string}'")
        else
        	$LOG.fatal("initialization fault")
        	abort
        end
        self.execute_command
	end
	
    def execute_command ()
    	runtime = @ssh_string+' "sudo vzlist '+@options.to_s+' "' if @remote
    	runtime = '"sudo vzlist '+@options.to_s+' "' if not(@remote)

    	$LOG.debug("excute: #{runtime}")
    	
    	Open3.popen3(runtime) do | stdin, stdout, stderr, wait_thr |
    		if wait_thr.value == 0 
    			result = stdout.read
    			$LOG.debug("Json from vzlist took. All normal")
    		else 
    			erro_return = stderr.read
    			$LOG.fatal("Take error. Error - #{erro_return}")
    		end
    	end
    	return 
    end
 

end


test = Vzlist.new("-jo ctid",true,"apanovich","88.85.72.50","21222")
#test = Vzlist.new()
#test.parse_result