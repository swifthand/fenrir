module Bifrost
  class HashPersistor

    def initialize(via: :id)
      @identity_msg       = via
      @storage            = HashWithIndifferentAccess.new
    end


## Persistor Methods ##########################################################

    def persist(entity)
      storage[entity.send(identity_msg)] = entity
      true
    end


    alias_method :persist!, :persist


    def reciprocate_attributes(entity)
      entity.id = entity.object_id
    end

## Repository Methods ##########################################################

    def find(id)
      storage[id]
    end


    def to_a
      storage.values
    end


private ########################################################################

    attr_reader :storage, :identity_msg

  end

## Since this is both a Persistor and Repository ###############################

  HashRepository = HashPersistor

end
