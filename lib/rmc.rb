#!/usr/bin/env ruby

module RMC

  require 'rest-client'

  require 'rmc/connection'

  class Exception < ::RuntimeError
  end

  class LoginError < Exception
  end

end