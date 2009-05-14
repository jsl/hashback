require File.join(File.dirname(__FILE__), %w[ .. spec_helper ])

describe HashBack::Backend do
  before do
    @moneta = mock('moneta')
    HashBack::Backend.any_instance.stubs(:initialize_cache_klass).returns(@moneta)
    @b = HashBack::Backend.new('foo', 'MonetaKlass', { })
    @b.stubs(:key_name_for).returns('keyname')
  end
  
  describe "methods proxied to backend" do
    describe "#[]" do
      it "should call the backend with the key name" do
        @moneta.expects(:[]).with('keyname')
        @b['keyname']
      end
    end

    describe "#[]=" do
      it "should call the backend with the key name and value" do
        @moneta.expects(:[]=).with('keyname', 'value')
        @b['keyname'] = 'value'
      end
    end

    describe "#delete" do
      it "should call delete for this key name on the backend" do
        @moneta.expects(:delete).with('keyname')
        @b.delete('foo')
      end
    end
  end  
end
