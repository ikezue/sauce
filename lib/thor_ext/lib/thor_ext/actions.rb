class Thor
  module Actions
    # Appends content to file, unless file already includes content
    def append_file_once(file_path, content)
      append_file(file_path, content) unless File.read(file_path).include?(content)
    end

    # Effectively removes all content in specified file, leaving it empty
    def erase_file(file)
      remove_file file
      create_file file
    end

    def move_file(source, destination)
      copy_file source, destination
      remove_file source
    end

    def replace_file(file, options = {})
      source = options[:copy] || options[:template]
      return if source.nil?

      remove_file file

      options[:copy] ? copy_file(source, file) : template(source, file)
    end

    def replace_in_file(relative_path, find, replace)
      path = File.join(destination_root, relative_path)
      contents = IO.read(path)
      unless contents.gsub!(find, replace)
        raise "#{find.inspect} not found in #{relative_path}"
      end
      File.open(path, "w") { |file| file.write(contents) }
    end
  end
end
