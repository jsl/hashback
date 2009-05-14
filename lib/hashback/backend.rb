module HashBack
  
  # Delegates methods to Moneta (a unified interface to key-value storage systems) after adding
  # a key for proper namespacing.  Initializes and loads the proper Moneta class based on input
  # options, and delegates setting and retrieval to the Moneta class responsible for storage.
  class Backend
    
    def initialize(namespace, moneta_klass, options = { })
      @namespace = namespace
      @options   = options
      @cache     = initialize_cache_klass(moneta_klass)
    end
    
    def [](key)
      @cache[key_name_for(key)]
    end
    
    def []=(key, value)
      @cache[key_name_for(key)] = value
    end

    def delete(key)
      @cache.delete(key_name_for(key))
    end

    private

    def initialize_cache_klass(cache_klass)
      require_moneta_library_for(cache_klass)
      load_moneta_klass(klass_const)
    end
    
    def load_moneta_klass(klass)
      klass_const = klass.respond_to?(:constantize) ? klass.constantize : klass      
      klass_const.new(@options)
    end
    
    def require_moneta_library_for(cache_klass)
      require_klass(cache_klass.to_s.gsub(/::/, '/').downcase)
    end

    def require_klass(klass)
      require klass
    end

    def key_name_for(key)
      [ @namespace, key ].join('-')
    end
    
    def table_name_from(archived_attribute)
      archived_attribute.instance.class.table_name
    end
  end
end