module Bifrost
  module Record

    def self.included(descendant)
      descendant.send(:extend, ClassMethods)
      if descendant.name =~ /record$/
        descendant.table_name = descendant.name.demodulize.underscore.chomp('_record').pluralize
      end
    end


    def as_entity(rebuild: false)
      if rebuild
        @as_enitity   = User.new(**self.attributes.symbolize_keys, persistor: self)
      else
        @as_entity  ||= User.new(**self.attributes.symbolize_keys, persistor: self)
      end
    end


    def persist(entity, *args, &block)
      self.attributes = entity.attributes
      self.save
    end


    def persist!(entity, *args, &block)
      self.attributes = entity.attributes
      self.save!
    end


    module ClassMethods

      def persists_for(entity_class)
        @record_for = entity_class
        begin
          shared_behavior = entity_class.const_get('SharedBehavior')
          self.send(:include, shared_behavior)
        rescue NameError
        end
      end
      alias_method :record_for, :persists_for

    end

  end
end
