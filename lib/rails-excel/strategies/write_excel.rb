require 'writeexcel'
module RailsExcel
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
