require 'activesupport'
require "rails-excel/version"
require 'rails-excel/delegation'
require 'rails-excel/template_handler'

module RailsExcel
  @available_strategies = Hash.new

  class << self
    module_eval do

      attr_accessor :strategy
      attr_reader :available_strategies

      def add_strategy(name, instance)
        @available_strategies[name.to_sym] = instance
      end

      def configure(&block)
        yield(self)
        ::ActionView::Base.send :include, RailsExcel::Delegation::View
        ::ActionController::Base.send :include,RailsExcel::Delegation::Controller
        ActionView::Template.register_template_handler :rxls, RailsExcel::TemplateHandler
      end

    end
  end

end

module Rails
  module Excel
    class << self
      module_eval do
        def add_strategy(name, instance)
          ActiveSupport::Deprecation.warn("Rails::Excel is deprecated in favor of RailsExcel",caller)
          RailsExcel.add_strategy(name, instance)
        end
        def configure(&block)
          ActiveSupport::Deprecation.warn("Rails::Excel is deprecated in favor of RailsExcel",caller)
          RailsExcel.configure(&block)
        end
      end
    end

  end
end


