Dir["#{File.dirname(__FILE__)}/sort-names/**/*.rb"].each(&method(:require))

module SortNames
  class Error < StandardError; end

  extend self
  attr_accessor :file, :max_names

  def self.run(arg = {})
    if arg.empty?
      arg[:max_names] = 5
      arg[:input] = 'input.txt'
      arg[:output] = 'final.txt'
    end
    @file = SortNames::Utility::File.new(arg[:max_names])
    @max_names = arg[:max_names].to_i
    @files = Hash.new { |h, k| h[k] = [] }
    @file_count = 0
    @prefix = rand(10000)
    level = 0

    FileUtils.remove_dir('tmp', true)
    Dir.mkdir("tmp")

    # Create sorted files under a "tmp/" directory
    file
        .open_enum(arg[:input])
        .each_slice(max_names) do |rows|
          rows.sort_by! { |row| row.first.downcase }
          write(rows, @file_count += 1)
        end

    if @files[level].size == 1
      cleanup(level, arg[:output])
      stats(level)
      return
    end

    # open @max_names files at the same time and
    #   use k-merge sort to make a new sorted file
    loop do
      level += 1
      @files[level - 1].each_slice(max_names) do |files|
        enumerators = []
        files.each do |f|
          enumerators << file.open_enum(f)
        end

        @file_count += 1
        SortNames::Utility::MergeSort.process(*enumerators)
            .each_slice(max_names) do |rows|
          write(rows, @file_count, level)
        end
      end
      break if @files[level].size == 1
    end

    stats(level)
    cleanup(level, arg[:output])
  end

  private

    def self.write(rows, file_number, level = 0)
      file_name = "tmp/#{@prefix}_temp_sorted_#{level}_#{file_number}.txt"
      @files[level] << file_name unless @files[level].include? file_name

      file.write(file_name, rows)
    end

    def stats(level)
      puts "Finished! Stats:"
      puts "   - partitions created: #{level + 1}"
      puts "   - files created: #{@file_count}"
      puts "   - total space occupied (bytes): #{File.size('tmp')}"
    end

    def cleanup(level, output)
      FileUtils.mv @files[level].first, output
      FileUtils.remove_dir('tmp', true)
    end
end
