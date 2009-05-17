module HashBack
  
  # Delegates methods to Moneta (a unified interface to key-value storage systems) after adding
  # a key for proper namespacing.  Initializes and loads the proper Moneta class based on input
  # options, and delegates setting and retrieval to the Moneta class responsible for storage.
  class Backend
    
    def initialize(namespace, moneta_klass, options = { })
      @namespace = namespace
      @options   = options
      @moneta    = initialize_moneta_klass(moneta_klass)
    end
    
    def [](key)
      @moneta[key_name_for(key)]
    end
    
    def []=(key, value)
      @moneta[key_name_for(key)] = value
    end

    def delete(key)
      @moneta.delete(key_name_for(key))
    end

    private

    def initialize_moneta_klass(klass)
      require_moneta_library_for(klass)
      load_moneta_klass(klass)
    end
    
    def require_moneta_library_for(klass)
      require_klass(klass.to_s.gsub(/::/, '/').downcase)
    end

    def load_moneta_klass(klass)
      klass_const = klass.respond_to?(:constantize) ? klass.constantize : klass      
      moneta = klass_const.new(@options)
      
      # The options hash would have messed up default Hash initialization to return an empty hash
      # when the key was not found.  Revert this case by setting the default to nil if the object 
      # responds to this method.
      moneta.default = nil if moneta.respond_to?(:default)
      moneta
    end
    
    def require_klass(klass)
      require klass
    end

    def key_name_for(key)
      [ @namespace, key ].join('-')
    end
  end
end