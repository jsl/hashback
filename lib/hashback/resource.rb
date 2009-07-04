module HashBack
  
  # HashBack::Resource is an Object-Hash Mapping (OHM) tool for Ruby.  It uses a Hash-like object
  # as the persistent resource, which can be given on HashBack::Resource initialization.
  class Resource
    
    # Configures the persistent backend for this object.  Configuration options:
    #
    # * +source+ - the class to be persisted
    # * +key_method+ - a symbol representing the method that will return a unique identifier 
    #   for this object when called on the instance
    # * +backend+ - a Hash-like Object (Moneta works well) for persisting this resource.
    def self.setup(source, key_method_sym, backend)
      source.__send__(:class_variable_set, :@@_backend, backend)
      source.__send__(:class_variable_set, :@@_key_method_sym, key_method_sym)

      source.__send__(:include, InstanceMethods)
      source.extend(ClassMethods)
    end
    
    module InstanceMethods
      
      # Saves the serialized form of this object to the configured backend store.
      def save
        hashback_backend[_hashback_id_key] = self
      end
      
      # Destroy the persisted copy of this object.
      def destroy
        hashback_backend.delete(_hashback_id_key)
      end

      # Convenience method for accessing the backend without having to get to the 
      # obscurely-named class variable in which it's stored.
      def hashback_backend
        self.class.__send__(:class_variable_get, :@@_backend)        
      end

      ## Methods we try to hide, because we're just sneaky like that.
            
      def _hashback_id_key
        self.__send__(self.class.__send__(:class_variable_get, :@@_key_method_sym))
      end
      
      private :_hashback_id_key
    end
    
    module ClassMethods
      
      # Fetches the object identified by +key+ from the storage backend.
      def fetch(key)
        backend = self.__send__(:class_variable_get, :@@_backend)
        backend[key]
      end
    end
  end
end