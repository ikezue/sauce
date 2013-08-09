module Sauce
  module Generators
    module Meteor
      class AppGenerator < Generator

        argument :name, desc: 'application name', type: :string
        def initialize(args = ARGV, opts = {}, cfg = {})
          super

          @path = Path(@name).expand
          @template_path = @recipe_path / 'meteor' / 'application' / 'templates'
          @tree = @template_path / '..' / 'tree.yml'

          AppGenerator.source_paths << @template_path
          self.destination_root = @path
        end

        def create_application
          run %{ meteor create #{@name} }
        end

        def remove_generated_files
          remove_file "#{@name}.css"
          remove_file "#{@name}.html"
          remove_file "#{@name}.js"
        end

        def create_project_structure
          Dir.mktmpdir do |dir|
            tree_yaml = Path(dir) / 'tree.yml'
            template @tree, tree_yaml, verbose: false
            Thor::Tree.new(tree_yaml).write
          end
        end
      end
    end
  end
end
