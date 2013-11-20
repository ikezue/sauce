module Sauce
  class ClojureScript < Thor
    desc 'app PATH', 'Create a ClojureScript application'
    def app(*args)
      Sauce::Generators::ClojureScript::AppGenerator.start args
    end
  end

  class Meteor < Thor
    desc 'app PATH', 'Create a Meteor application'
    def app(*args)
      Sauce::Generators::Meteor::AppGenerator.start args
    end
  end

  class Rails < Thor
    desc 'app PATH', 'Create a Rails application'
    def app(*args)
      Sauce::Generators::Rails::AppGenerator.start args
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

    desc 'cljs SUBCOMMAND ...ARGS', 'Create a ClojureScript application'
    subcommand 'cljs', ClojureScript

    desc 'meteor SUBCOMMAND ...ARGS', 'Create a Meteor application, package or resource'
    subcommand 'meteor', Meteor

    desc 'rails SUBCOMMAND ...ARGS', 'Create a Rails application'
    subcommand 'rails', Rails
  end
end
