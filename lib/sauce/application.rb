module Sauce
  class Application < Thor

    def initialize(args = ARGV, opts = {}, cfg = {})
      super
    end

    map ['-v', '--version'] => :version
    desc 'version', 'Show current version'
    def version
      $stdout.puts Sauce::VERSION
    end
  end
end
