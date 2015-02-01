module Bifrost
  module Persistence

    def self.included(descendant)
      descendant.send(:attr_accessor, :persistor)
    end

    def persist(*args, &block)
      persistor.persist(self, *args, &block)
    end

    def persist!(*args, &block)
      persistor.persist!(self, *args, &block)
    end

    def initialize(*args, persistor: NullPersistor.new, **kwargs, &block)
      self.persistor = persistor
      super(*args, **kwargs, &block)
    end

  end
end
