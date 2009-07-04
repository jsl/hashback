Gem::Specification.new do |s|
  s.name     = "hashback"
  s.version  = "0.0.3"
  s.date     = "2009-05-13"
  
  s.summary  = "Ruby Object-Hash Mapping system (OHM)"
  
  s.description = <<-EOF
    HashBack makes your ruby class persistent by adding methods which will save and retrieve it from a 
    backend key-value store.  Useful when you have objects that should respond to #save and #fetch (as
    a class method).  Works well with the Moneta gem, which automatically serializes objects before they
    are saved and after they are retrieved, but functions with any key-value storage system.
  EOF
    
  s.email    = "justin@phq.org"
  s.homepage = "http://github.com/jsl/hashback"
  s.description = "HashBack"
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
    "lib/hashback/backend.rb",
    "lib/hashback/resource.rb"
  ]
  s.test_files = [
    "spec/hashback/backend_spec.rb",
    "spec/hashback_spec.rb",
    "spec/spec_helper.rb"
  ]
  
  s.extra_rdoc_files = [ "README.rdoc" ]
  
  s.rdoc_options += [
    '--title', 'HashBack',
    '--main', 'README.rdoc',
    '--line-numbers',
    '--inline-source'
   ]   
end
