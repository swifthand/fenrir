module Bifrost
  module Persistence

    def self.included(descendant)
      descendant.send(:attr_accessor, :persistor)
    end

    def persist(*args, &block)
      result = persistor.persist(self, *args, &block)
      persistor.reciprocate_attributes(self)
      result
    end

    def persist!(*args, &block)
      result = persistor.persist!(self, *args, &block)
      persistor.reciprocate_attributes(self)
      result
    end

    def initialize(*args, persistor: NullPersistor.new, **kwargs, &block)
      self.persistor = persistor
      super(*args, **kwargs, &block)
    end

    def method_missing(msg, *args, &block)
      if persistor.present? and persistor.respond_to?(msg)
        persistor.send(msg, *args, &block)
      else
        super
      end
    end

  end
end
