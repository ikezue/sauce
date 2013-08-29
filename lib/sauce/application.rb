module Sauce
  class Meteor < Thor
    desc 'app PATH', 'Create a Meteor application'
    def app(*args)
      Sauce::Generators::Meteor::AppGenerator.start args
    end
  end

  class Application < Thor

    def initialize(args = ARGV, opts = {}, cfg = {})
      super
    end

    map ['-v', '--version'] => :version
    desc 'version', 'Show current version'
    def version
      $stdout.puts Sauce::VERSION
    end

    desc 'meteor SUBCOMMAND ...ARGS', 'Create a Meteor application, package or resource'
    subcommand 'meteor', Meteor
  end
end
