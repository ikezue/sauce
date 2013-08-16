require 'path'

module Sauce
  class Generator < Thor::Group
    include Thor::Actions

    argument :path, desc: 'path to generate application in', type: :string
    def initialize(args = ARGV, opts = {}, cfg = {})
      super
      @path = Path(@path).expand
      @name = @path.base.to_s.downcase
      @recipe_path = Path.file / '..' / '..' / 'recipes'
    end

    private

    def error(message)
      raise Error.new "Error: #{message}"
    end
  end
end
