module ActionView
  module TemplateHandlers
    class Excel < TemplateHandler
      include Compilable

      def compile
        %Q{
        _set_controller_content_type(Mime::XLS);
          io = StringIO.new
          Rails::Excel.available_strategies[self.excel_strategy].compile(io) do
            #{template.source}
          end
          self.output_buffer = io.string
        }
      end

    end
  end
end
