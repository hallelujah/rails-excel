require 'activesupport'
require "rails-excel/version"
require 'rails-excel/delegation'
require 'rails-excel/strategies'
require 'rails-excel/template_handler'

module Rails
  module Excel

    BUILTIN_STRATEGIES = {
      :spreadsheet => Rails::Excel::Strategies::Spreadsheet.new,
      :write_excel => Rails::Excel::Strategies::WriteExcel.new
    } unless const_defined?(:BUILTIN_STRATEGIES)

    class << self
      module_eval do

        attr_accessor_with_default :strategy, :spreadsheet

        attr_reader :available_strategies

        @available_strategies = BUILTIN_STRATEGIES.dup

        def add_strategy(name, klass)
          @available_strategies[name.to_sym] = klass.new
        end

        def configure(&block)
          yield(self)
          ::ActionView::Base.send :include, Rails::Excel::Delegation::View
          ::ActionController::Base.send :include,Rails::Excel::Delegation::Controller
          ActionView::Template.register_template_handler :rxls, Rails::Excel::TemplateHandler
        end

      end
    end
  end
end
