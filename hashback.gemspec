Gem::Specification.new do |s|
  s.name     = "hashback"
  s.version  = "0.0.1.1"
  s.date     = "2009-05-13"
  s.summary  = "Generic tool for writing namespaced key-value data to a variety of hash-type systems"
  s.email    = "justin@phq.org"
  s.homepage = "http://github.com/jsl/hashback"
  s.description = "Wrapper around Moneta that facilitates using the key-value store as a backend for applications requiring namespacing"
  s.has_rdoc = true
  s.authors  = ["Justin Leitgeb"]
  s.files    = [
    "Rakefile",
    "hashback.gemspec",
    "init.rb",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "lib/hashback.rb",
    "lib/hashback/backend.rb"
  ]
  s.test_files = [
    "spec/hashback/backend_spec.rb",
    "spec/hashback_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.add_dependency("wycats-moneta", ["> 0.0.0"])
end
