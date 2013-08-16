module Sauce
  module Generators
    module Meteor
      class AppGenerator < Generator

        def initialize(args = ARGV, opts = {}, cfg = {})
          super

          @template_path = @recipe_path / 'meteor' / 'application' / 'templates'
          @tree = @template_path / '..' / 'tree.yml'

          AppGenerator.source_paths << @template_path << @path
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

        def specify_ruby_gemset
          create_file '.ruby_version', "2.0.0@#{@name}-meteor\n"
        end

        def add_compass_and_foundation
          # Create Compass config file in a custom location
          config_file = 'client/config/compass.rb'
          template 'compass.rb', config_file

          # Create Compass/Foundation project
          inside @path do
            run %{compass create . --config #{config_file} --using foundation}
          end

          # Rename stylesheets to main.*
          move_file 'client/app.css', 'client/main.css'
          move_file 'client/stylesheets/app.sass', 'client/stylesheets/main.sass'

          # Move partials to partials directory
          move_file 'client/stylesheets/_normalize.sass', 'client/stylesheets/partials/_normalize.sass'
          move_file 'client/stylesheets/_settings.sass', 'client/stylesheets/partials/_settings.sass'

          # Create a Meteor package for Foundation JavaScripts
          directory 'javascripts/foundation', 'packages/foundationjs'
          move_file 'javascripts/vendor/custom.modernizr.js', 'packages/foundationjs/custom.modernizr.js'
          copy_file 'foundation_init.js', 'packages/foundationjs/foundation_init.js'
          copy_file 'foundation_package.js', 'packages/foundationjs/package.js'

          # Clean up
          remove_file 'config.rb'
          remove_file 'humans.txt'
          remove_file 'index.html'
          remove_file 'MIT-LICENSE.txt'
          remove_file 'robots.txt'
          remove_dir 'javascripts'
        end

        def setup_pow_proxy
          inside @path do
            run %{echo #{Sauce::Generator::BASE_METEOR_PORT + } > ~/.pow/#{@name}}
          end
        end
      end
    end
  end
end
