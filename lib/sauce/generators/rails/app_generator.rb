module Sauce
  module Generators
    module Rails
      class AppGenerator < Generator

        def initialize(args = ARGV, opts = [], cfg = {})
          super

          @template_path = @recipe_path / 'rails' / 'application' / 'templates'
          @port = Settings['ports']['rails']
          @ruby = '2.1.0'

          # Source root and paths for Sauce::Generators::Rails::App::Generator.
          App::Generator.source_root @template_path
          App::Generator.source_paths << ::Rails::Generators::AppGenerator.source_root
          App::Generator.source_paths << @template_path

          # Pass relevant instance variables from this instance to instances of
          # App::Builder and App::Generator.
          ['@path', '@port', '@name', '@ruby'].each do |var|
            App::Generator.set_template_variable var, instance_variable_get(var)
            App::Builder.set_template_variable var, instance_variable_get(var)
          end

          # Initialize App::Generator with command line arguments and options.
          App::Generator.start args + opts
        end
      end
    end
  end
end
