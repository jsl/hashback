require File.join(File.dirname(__FILE__), %w[ .. spec_helper ])

require 'uuid'

class Orange
  HashBack::Resource.setup(self, :uuid, {  })

  attr_accessor :uuid
  
  def initialize
    @uuid = UUID.new.generate
  end
end

describe HashBack::Resource do
  before do
    @o = Orange.new
    @o.save
  end
  
  describe "#fetch" do
    it "should retrieve a persisted object" do
      fetched = Orange.fetch(@o.uuid)
      fetched.should == @o
    end
  end
  
  describe "#destroy" do
    it "should be able to be destroyed" do
      @o.destroy
      Orange.fetch(@o.uuid).should be_nil
    end
  end
  
end