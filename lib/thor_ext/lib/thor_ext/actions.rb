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
  end
end
