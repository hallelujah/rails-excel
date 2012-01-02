module RailsExcel
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
          def excel_strategy
            @excel_strategy ||= self.class.excel_strategy
          end

          def excel_strategy=(strategy)
            @excel_strategy = strategy
          end

          self.excel_strategy = ::RailsExcel.strategy
        end

      end
    end

  end
end
