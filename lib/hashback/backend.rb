module HashBack
  
  # Proxy class over a key-value storage object which adds a namespace to keys.  Useful if you
  # have a number of different things that are saving to the same object space.  Of course, then
  # you may want to consider just opening up new key-value stores.  This class may safely be 
  # ignored if not needed by your application.
  class Backend
    
    # Backend accepts a namespace which will be added to all keys on retrieval and 
    # setting, and a backend that responds to Hash-like methods.  Moneta classes
    # see the Moneta gem) work well as the backends to this class.
    def initialize(namespace, backend)
      @namespace = namespace
      @backend   = backend
    end
    
    def [](key)
      @backend[key_name_for(key)]
    end
    
    def []=(key, value)
      @backend[key_name_for(key)] = value
    end

    def delete(key)
      @backend.delete(key_name_for(key))
    end

    private

    def key_name_for(key)
      [ @namespace, key ].join('-')
    end
  end
end