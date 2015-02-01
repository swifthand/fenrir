module Bifrost
  module Persistence

    def persist(*args, &block)
      persistor.persist(self, *args, &block)
    end

    def persist!(*args, &block)
      persistor.persist!(self, *args, &block)
    end

    def initialize(*args, persistor: NullPersistor.new, **kwargs, &block)
      @persistor = persistor
      super(*args, **kwargs, &block)
    end

  end
end
