require 'hashback'
require 'uuid'

class Elephant
  HashBack::Resource.setup(self, :uuid, 'Moneta::Memory')
  
  attr_accessor :uuid, :name
  
  def initialize(name)
    @name = name
    @uuid = UUID.new.generate
  end
end

dumbo = Elephant.new('Dumbo')
dumbo.save

# And later, when you want to bring Dumbo back...
new_dumbo = Elephant.fetch(dumbo.uuid)

# When you're sick of Dumbo and just want him gone:
new_dumbo.destroy
