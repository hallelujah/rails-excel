require 'activesupport'
require "rails-excel/version"
require 'rails-excel/delegation'
require 'rails-excel/template_handler'

module Rails
  module Excel
    class << self
      module_eval do
        %w{add_strategy configure}.each do |m|
          define_method m do |*args|
            ActiveSupport::Deprecation.warn("Rails::Excel is deprecated in favor of RailsExcel",caller)
            RailsExcel.send(m, *args)
          end
        end
      end
    end

  end
end

module RailsExcel

  class << self
    module_eval do

      attr_accessor :strategy
      attr_reader :available_strategies

      def add_strategy(name, instance)
        @available_strategies[name.to_sym] = instance
      end

      def configure(&block)
        @available_strategies = Hash.new
        yield(self)
        ::ActionView::Base.send :include, RailsExcel::Delegation::View
        ::ActionController::Base.send :include,RailsExcel::Delegation::Controller
        ActionView::Template.register_template_handler :rxls, RailsExcel::TemplateHandler
      end

    end
  end

end
