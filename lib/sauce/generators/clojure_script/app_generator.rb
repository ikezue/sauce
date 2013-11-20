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

        def modify_project_file
          Dir.mktmpdir do |dir|
            project_clj = Path(dir) / 'project.clj'
            template (@template_path / 'project.clj'), project_clj, verbose: false
            replace_in_file 'project.clj', /^  :dependencies.*\s+$/, IO.read(project_clj)
          end
        end

        def create_additional_file
          template 'core.cljs', "src/cljs/#{@name}/core.cljs"
          template 'index.html', "resources/public/index.html"
        end
      end
    end
  end
end
