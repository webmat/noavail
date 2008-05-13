TEST_DIR = File.dirname(__FILE__)

require 'rubygems'
require 'spec'

require 'pp'

require "#{TEST_DIR}/helpers/capture_stdout"

require File.join( TEST_DIR, '..', 'lib', 'noavail' )
