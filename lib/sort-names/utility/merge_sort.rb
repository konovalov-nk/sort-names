module SortNames
  module Utility
    # Class for processing arrays.
    class MergeSort
      # @param args : array of sorted strings
      # @return a sorted array
      def self.process(*args, &block)
        args.each do |enum|
          raise ArgumentError.new("#{enum.class} is not an Enumerator") unless enum.is_a?(Enumerator)
        end

        hash = {}
        args.size.times do |array_index|
          _next = args[array_index].next
          hash[array_index] = {
              :data => args[array_index],
              :current => _next,
          }
        end

        Enumerator.new do |y|
          until hash.keys.empty?
            # Finding a minimum element
            entries = hash.entries.map { |k, v| [v[:current], k] }

            min, key = entries.min_by { |entry, *| entry.first.downcase }
            y << min

            # Progressing position on removed element
            begin
              hash[key][:current] = hash[key][:data].next
            rescue StopIteration
              hash.delete(key)
            end
          end
        end
      end
    end
  end
end
