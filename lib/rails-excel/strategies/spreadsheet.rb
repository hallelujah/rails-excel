require 'spreadsheet'


module RailsExcel
  module Strategies

    class Spreadsheet
      def compile(io, &block)
        workbook = ::Spreadsheet::Workbook.new
        yield(workbook)
        workbook.write(io)
      end
    end

  end

end

# This extends colors for spreadsheet gem
# See http://dmcritchie.mvps.org/excel/colors.htm#dpalette

colors = %w{
black brown olive_green dark_green dark_teal dark_blue indigo dark_gray
dark_red orange dark__yellow green teal blue blue_gray gray
red light_orange lime sea_green aqua light_blue violet light_gray
pink gold yellow righ_green turquoise sky_blue plu lite_gray
rose tan light_yellow light_green light_turquoise plae_blue lavender white
periwinkle plum_plus ivory lite_turquoise dark_purple coral ocean_blue ice_blue
dark_blue pink_plus yellow_plus turquoise violet dark_red teal_plus blue_plus
}

color_indexes = %w{
1 53 52 51 49 11 55 56
9 46 12 10 14 5 47 16
3 45 43 50 42 41 13 48
7 44 6 4 8 33 54 15
38 40 36 35 34 37 39 2
17 18 19 20 21 22 23 24
25 26 27 28 29 30 31 32
}

color_indexes.each_with_index do |c,i|
  # Do not override already defined colors
  color_num = c.to_i + 7
  Spreadsheet::Excel::Internals::COLOR_CODES[color_num] = colors[i].to_sym unless Spreadsheet::Excel::Internals::COLOR_CODES.key?(color_num)
  Spreadsheet::Excel::Internals::SEDOC_ROLOC[colors[i].to_sym] = color_num unless Spreadsheet::Excel::Internals::COLOR_CODES.key?(colors[i].to_sym)
end

# Add palette colors but not override existing colors
ObjectSpace.each_object(Class)  do |m|
  if m.ancestors.include?(Spreadsheet::Datatypes)
    m::module_eval do
      class << self
        COLORS.replace(COLORS | Spreadsheet::Excel::Internals::SEDOC_ROLOC.keys)
      end
    end
  end
end
