require File.join(File.dirname(__FILE__), %w[ .. spec_helper ])

describe HashBack::Backend do
  before do
    @mock_moneta = mock('moneta')
    @mock_moneta.stubs(:keys).returns(['keyname'])
    @b = HashBack::Backend.new('foo', @mock_moneta)
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
end
