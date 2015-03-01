module Bifrost
  class NullPersistor

    def persist(entity, **options)
      true
    end


    def persist!(entity, **options)
      true
    end


    def reciprocate_attributes(entity)
      []
    end

  end
end
