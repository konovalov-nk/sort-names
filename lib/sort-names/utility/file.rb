require 'csv'
require 'fileutils'

module SortNames
  module Utility
    # Class for processing arrays.
    class File
      attr_accessor :limit

      def initialize(limit = 10)
        @limit = limit
      end

      def open_enum(file_name)
        CSV.foreach(file_name, headers: false, col_sep: "\t").to_enum
      end

      def write(file_name, data = [])
        ::File.open(file_name, 'a') do |outfile|
          ::CSV::open(outfile, "a+", col_sep: "\t") do |csv|
            data.each do |row|
              csv << row
            end
          end
        end
      end
    end
  end
end
