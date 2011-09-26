require 'activesupport'
require "rails-excel/version"
require 'rails-excel/delegation'
require 'rails-excel/strategies'
require 'rails-excel/template_handler'

module Rails
  module Excel

    BUILTIN_STRATEGIES = {
      :spreadsheet => Rails::Excel::Strategies::Spreadsheet,
      :write_excel => Rails::Excel::Strategies::WriteExcel
    } unless const_defined?(:BUILTIN_STRATEGIES)

    class << self
      module_eval do

        attr_accessor :strategy
        attr_reader :available_strategies

        def add_strategy(name, instance)
          @available_strategies[name.to_sym] = instance
        end

        def configure(&block)
          @available_strategies = Hash.new
          BUILTIN_STRATEGIES.each do |k,v|
            add_strategy k, v.new
          end
          yield(self)
          ::ActionView::Base.send :include, Rails::Excel::Delegation::View
          ::ActionController::Base.send :include,Rails::Excel::Delegation::Controller
          ActionView::Template.register_template_handler :rxls, Rails::Excel::TemplateHandler
        end

      end
    end
  end
end
