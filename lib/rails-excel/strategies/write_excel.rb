require 'writeexcel'
module Rails
  module Excel

    class WriteExcel
      def compile(io,&block)
        workbook = ::WriteExcel::Workbook.new(io)
        yield
        workbook.close
      end
    end

  end
end
