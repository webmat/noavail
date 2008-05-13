require 'thread' 

require 'rubygems'
require 'whois'
#require 'ruby-debug'

require File.dirname(__FILE__) + '/lib'

module NoAvail
  DEFAULT_EXTENSIONS = ['.com', '.net', '.org']

  VERIFICATION_STRATEGY = Naive.new
  #VERIFICATION_STRATEGY = MultiThreaded.new
end
