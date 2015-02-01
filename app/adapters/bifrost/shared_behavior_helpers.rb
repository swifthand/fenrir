module Bifrost
  module SharedBehaviorHelpers

    def share_behavior(&block)
      shared_module = const_get('SharedBehavior')
      shared_module.class_exec(&block)
      send(:include, shared_module)
    end

  end
end
