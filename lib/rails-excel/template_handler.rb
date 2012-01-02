require 'action_controller'
require 'action_view'
module RailsExcel
  class TemplateHandler

    def self.call(template, *args)
      new.compile(template)
    end

    def compile(template)
      %Q{
          io = StringIO.new
          RailsExcel.available_strategies[self.excel_strategy].compile(io) do |workbook|
        #{template.source}
          end
          self.output_buffer = io.string
      }
    end

  end
end

::Mime::Type.register "application/vnd.ms-excel", :xls
