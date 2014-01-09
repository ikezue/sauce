module Sauce
  module Generators
    module ClojureScript
      class AppGenerator < Generator

        def initialize(args = ARGV, opts = [], cfg = {})
          super

          @template_path = @recipe_path / 'clojure_script' / 'application' / 'templates'
          @tree = @template_path / '..' / 'tree.yml'

          AppGenerator.source_paths << @template_path << @path
          self.destination_root = @path
        end

        def create_application
          inside @path.dir do
            run %{ lein new #{@name} }
          end

          inside @path do
            run %{ mkdir -p src/clj src/cljs/#{@name} }
            run %{ mv src/#{@name}/ src/clj/ }
            run %{ mkdir -p resources/public/js resources/public/css }
          end
        end

        def write_project_files
          Dir.mktmpdir do |dir|
            project_clj = Path(dir) / 'project.clj'
            template (@template_path / 'project.clj'), project_clj, verbose: false
            replace_in_file 'project.clj', /^  :dependencies.*\s+$/, IO.read(project_clj)
          end
          copy_file 'compass.rb', 'config/compass.rb'
          template 'bower.json'
          copy_file 'bowerrc', '.bowerrc'
        end

        def write_source_files
          template 'server.clj', "src/clj/#{@name}/server.clj"
          template 'core.cljs', "src/cljs/#{@name}/core.cljs"
          template 'index.html', 'resources/public/index.html'
          copy_file 'foundation.js', 'resources/public/js/vendor/foundation.js'
          copy_file 'app.sass', 'resources/public/sass/app.sass'
          remove_file "src/clj/#{@name}/core.clj"
        end

        def install_foundation
          inside @path do
            run %{ bower install }
          end
        end

        def print_instructions
          say %{\n}
          say %{  A new ClojureScript application has been created in #{@path}.\n}

          say %{  Run `lein cljsbuild auto debug` to auto compile in debug mode.}
          say %{  cljsbuild modes - debug, stage, release - are listed in project.clj.}.

          say %{  Run `lein ring server` to launch the Ring server.}
          say %{  Then visit the application at http://localhost:3000/index.html.}

          say %{  In Light Table, hit Cmd+Ctrl+b to connect to the running application. }
          say %{  Embed the provided script tag in the head of index.html.}
        end
      end
    end
  end
end
