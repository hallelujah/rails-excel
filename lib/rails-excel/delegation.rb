module Rails
  module Excel
    module Delegation

      module View
        def self.included(base)
          base.module_eval do
            delegate :excel_strategy, :to => :controller
          end
        end
      end

      module Controller
        def self.included(base)
          base.module_eval do
            class_inheritable_accessor :excel_strategy, :instance_writer => false
            self.excel_strategy = ::Rails::Excel.strategy
          end

        end
      end

    end
  end
end
