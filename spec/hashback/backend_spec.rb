require File.join(File.dirname(__FILE__), %w[ .. spec_helper ])

describe HashBack::Backend do
  before do
    @mock_moneta = mock('moneta')
    @mock_moneta.stubs(:keys).returns(['keyname'])
    @moneta_klass = "Moneta::Memory"
    @b = HashBack::Backend.new('foo', @moneta_klass, { })
    @b.instance_variable_set(:@moneta, @mock_moneta)
    @b.stubs(:key_name_for).returns('keyname')
  end
  
  describe "methods proxied to backend" do
    describe "#[]" do
      it "should call the backend with the key name" do
        @mock_moneta.expects(:[]).with('keyname')
        @b['keyname']
      end
    end

    describe "#[]=" do
      it "should call the backend with the key name and value" do
        @mock_moneta.expects(:[]=).with('keyname', 'value')
        @b['keyname'] = 'value'
      end
    end

    describe "#delete" do
      it "should call delete for this key name on the backend" do
        @mock_moneta.expects(:delete).with('keyname')
        @b.delete('foo')
      end
    end
  end  
  
  describe "#initialize_moneta_klass" do
    it "should call require_moneta_library_for and load_moneta_klass" do
      b = HashBack::Backend.new('foo', @moneta_klass, { })
      b.expects(:require_moneta_library_for).with(@moneta_klass)
      b.expects(:load_moneta_klass).with(@moneta_klass)
      b.__send__(:initialize_moneta_klass, @moneta_klass)
    end
  end
  
  describe "#require_moneta_library_for" do
    it "should require the class given" do
      @b.expects(:require_klass).with('moneta/memory')
      @b.__send__(:require_moneta_library_for, "Moneta::Memory")
    end
  end
  
  describe "#load_moneta_klass" do
    it "should load the klass without error" do
      require 'moneta/memory'
      
      lambda {
        @b.__send__(:load_moneta_klass, "Moneta::Memory")      
      }.should_not raise_error
    end
  end
end
