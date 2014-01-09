require 'helpers/colored'

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
          copy_file 'gitignore', '.gitignore', force: true
        end

        def write_source_files
          template 'server.clj', "src/clj/#{@name}/server.clj"
          template 'core.cljs', "src/cljs/#{@name}/core.cljs"
          template 'index.html', 'resources/public/index.html'
          copy_file 'foundation.js', 'resources/public/js/vendor/foundation.js'
          copy_file 'app.sass', 'resources/public/sass/app.sass'
          copy_file '_settings.sass', 'resources/public/sass/_settings.sass'
          remove_file "src/clj/#{@name}/core.clj"
        end

        def install_foundation
          inside @path do
            run %{ bower install }
          end
        end

        def print_instructions
          say %{\n}
          say %{  A new ClojureScript application has been created in #{@path}.\n}.green

          say %{  Run `lein cljsbuild auto debug` to auto compile in debug mode.}.magenta
          say %{  cljsbuild modes - debug, stage, release - are listed in project.clj.}.magenta

          say %{  Run `lein ring server` to launch the Ring server.}.yellow
          say %{  Then visit the application at http://localhost:3000/.}.yellow

          say %{  Run `compass watch --config config/compass.rb` to compile app.sass.}.cyan

          say %{  In Light Table, evaluate the last line with Cmd+Enter.}.red
          say %{  Wait for Light Table to connect to the project and retrieve dependencies.}.red
          say %{  When prompted to do so, connect to an external browser.}.yellow
          say %{  Embed the provided script tag in the head of index.html.}.yellow
        end
      end
    end
  end
end
