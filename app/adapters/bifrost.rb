module Bifrost

  def self.entity(share: 'SharedBehavior', **options)
    mod = Module.new
    builder = EntityBuilder.new(share: share, **options)
    mod.instance_variable_set('@bifrost_enytity_builder', builder)

    mod.instance_exec do
      def self.included(descendent)
        @bifrost_enytity_builder.assign(descendent)
      end
    end
    return mod
  end


  class EntityBuilder

    attr_reader :virtus_options, :shared_behavior_name, :persistence_helpers

    def initialize(share: , **options)
      @virtus_options       = options.slice(*virtus_option_keys)
      @shared_behavior_name = share
      @persistence_helpers  = options.fetch(:persistence_helpers, true)
    end

    def virtus_option_keys
      [:finalize, :coerce, :strict, :required, :constructor, :mass_assignment]
    end


    def assign(descendent)
      descendent.class_exec { include ActiveModel::Validations      }
      descendent.class_exec { extend  ActiveModel::Naming           }
      descendent.class_exec { include ActiveModel::Conversion       }
      descendent.send(:include, Virtus.model(virtus_options))
      descendent.class_exec { extend Bifrost::SharedBehaviorHelpers }
      build_shared_behavior(descendent)
      assign_timestamp_attributes(descendent)
      if persistence_helpers
        descendent.class_exec { include Bifrost::Persistence }
      end
    end


    def build_shared_behavior(descendent)
      return if shared_behavior_name == :none or shared_behavior_name == false

      shared_module =
        begin
          descendent.const_get(shared_behavior_name)
        rescue NameError
          descendent.const_set(shared_behavior_name, Module.new)
        end

      shared_module.class_exec do
        extend Bifrost::ClassMacroBuffer
        extend Bifrost::BuffersValidations

        def self.included(descendent)
          # Clean up after ourselves, at the cost of trouncing
          # SharedBehavior::method_missing (i.e. singleton-class-level)
          class_macro_buffer.each do |call_details|
            descendent.send(call_details[:message], *call_details[:args], &call_details[:block])
          end
        end

        def self.method_missing(message, *args, &block)
          if(self.respond_to?(:matches_validations?) and matches_validations?(message))
            record_class_macro({message: message, args: args, block: block})
          else
            super
          end
        end
      end
    end

    def assign_timestamp_attributes(descendent)
      descendent.send(:attribute, 'created_at', DateTime)
      descendent.send(:attribute, 'updated_at', DateTime)
    end

  end


  module ClassMacroBuffer
    def class_macro_buffer
      @class_macro_buffer ||= []
    end

    def record_class_macro(call_details)
      class_macro_buffer << call_details
    end
  end


  # Record calls from methods from:
  # - ActiveModel::Validations::ClassMethods
  # - ActiveModel::Validations::HelperMethods
  module BuffersValidations
    def matches_validations?(message)
      [ # ActiveModel::Validations::ClassMethods
        'attribute_method?',  'clear_validators!',  'validate',
        'validates',          'validates!',         'validates_each',
        'validates_with',     'validators',         'validators_on',
        # ActiveModel::Validations::HelperMethods
        'validates_absence_of',       'validates_acceptance_of',
        'validates_confirmation_of',  'validates_exclusion_of',
        'validates_format_of',        'validates_inclusion_of',
        'validates_length_of',        'validates_numericality_of',
        'validates_presence_of',      'validates_size_of',
      ].include?(message.to_s)
    end
  end

end
