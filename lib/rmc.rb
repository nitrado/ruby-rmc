#!/usr/bin/env ruby

module RMC

  require 'rest-client'
  require 'timeout'

  require 'rmc/connection'
  require 'rmc/scheduler'
  require 'rmc/recovery_sets'
  require 'rmc/snapshot_sets'
  require 'rmc/express_protects'
  require 'rmc/volumes'
  require 'rmc/storage_systems'
  require 'rmc/backup_systems'
  require 'rmc/backup_policies'
  require 'rmc/item/schedule'
  require 'rmc/item/recovery_set'
  require 'rmc/item/express_protect'
  require 'rmc/item/storage_pool'
  require 'rmc/item/volume'
  require 'rmc/item/storage_system'
  require 'rmc/item/backup_system'
  require 'rmc/item/snapshot_set'
  require 'rmc/item/backup_policy'
  require 'rmc/item/host'

  class Exception < ::RuntimeError
  end

  class LoginError < Exception
  end

end