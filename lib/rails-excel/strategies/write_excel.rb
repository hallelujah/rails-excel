require 'writeexcel'
module Rails
  module Excel
    module Strategies

      class WriteExcel
        def compile(io,&block)
          workbook = ::WriteExcel.new(io)
          yield(workbook)
          workbook.close
        end
      end

    end
  end
end
