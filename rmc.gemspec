
Gem::Specification.new do |s|
  s.name = "rmc"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Alexander Birkner"]
  s.description = "Ruby Library for HPE Recovery Manager Central."
  s.email = ["alexander.birkner@marbis.net"]
  s.extra_rdoc_files = [
      "README.md",
      "LICENSE",
  ]
  s.files = [
      "lib/rmc.rb",
      "lib/rmc/item/backup_policy.rb",
      "lib/rmc/item/backup_system.rb",
      "lib/rmc/item/express_protect.rb",
      "lib/rmc/item/host.rb",
      "lib/rmc/item/recovery_set.rb",
      "lib/rmc/item/schedule.rb",
      "lib/rmc/item/snapshot_set.rb",
      "lib/rmc/item/storage_pool.rb",
      "lib/rmc/item/storage_system.rb",
      "lib/rmc/item/task.rb",
      "lib/rmc/item/volume.rb",
      "lib/rmc/backup_policies.rb",
      "lib/rmc/backup_systems.rb",
      "lib/rmc/connection.rb",
      "lib/rmc/express_protects.rb",
      "lib/rmc/recovery_sets.rb",
      "lib/rmc/scheduler.rb",
      "lib/rmc/snapshot_sets.rb",
      "lib/rmc/storage_systems.rb",
      "lib/rmc/tasks.rb",
      "lib/rmc/volumes.rb",
  ]
  s.homepage = "https://github.com/nitrado/ruby-rmc"
  s.rubygems_version = "2.4.8"
  s.summary = "HPE RMC Ruby API"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<mocha>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_runtime_dependency(%q<oj>, [">= 0"])
      s.add_runtime_dependency(%q<rest-client>, [">= 1.8"])
    else
      s.add_dependency(%q<mocha>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<oj>, [">= 0"])
      s.add_dependency(%q<rest-client>, [">= 1.8"])
    end
  else
    s.add_dependency(%q<mocha>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<oj>, [">= 0"])
    s.add_dependency(%q<rest-client>, [">= 1.8"])
  end
end

