require 'path'

module Sauce
  class Generator < Thor::Group
    include Thor::Actions

    def initialize(args = ARGV, opts = {}, cfg = {})
      super
      @recipe_path = Path.file / '..' / '..' / 'recipes'
    end

    private

    def error(message)
      raise Error.new "Error: #{message}"
    end
  end
end
