module HashBack
  
  # +HashBack::Resource+ is an Object-Hash Mapping (OHM) tool for Ruby.  It is able to map Ruby objects
  # to any of the backends supported by Moneta, a unified interface to key-value storage systems.
  class Resource
    
    # Configures the persistent backend for this object.  Configuration options:
    #
    # * source - the class to be persisted
    # * key_method - a symbol representing the method that will return a unique identifier 
    #   for this object when called on the instance
    # * moneta_klass - a String representation or class constant of the Moneta class used to store this object
    # * moneta_options - an (optional) hash which is passed directly to the moneta backend for configuration
    def self.setup(source, key_method_sym, moneta_klass, moneta_options = {})
      source.__send__(:class_variable_set, :@@_backend, HashBack::Backend.new(source.to_s, moneta_klass, moneta_options))
      source.__send__(:class_variable_set, :@@_key_method_sym, key_method_sym)

      source.__send__(:include, InstanceMethods)
      source.extend(ClassMethods)
    end
    
    module InstanceMethods
      
      # Saves the serialized form of this object to the configured backend store.
      def save
        _hashback_backend[_hashback_id_key] = self
      end
      
      # Destroy the persisted copy of this object.
      def destroy
        _hashback_backend.delete(_hashback_id_key)
      end

      ## Methods we try to hide, because we're just sneaky like that.
      
      def _hashback_backend
        self.class.__send__(:class_variable_get, :@@_backend)        
      end
      
      def _hashback_id_key
        self.__send__(self.class.__send__(:class_variable_get, :@@_key_method_sym))
      end
      
      private :_hashback_backend, :_hashback_id_key
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