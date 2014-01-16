require 'rails/generators/rails/app/app_generator'
require 'helpers/template_variables'

module Sauce
  module Generators
    module Rails
      module App
        class Builder < ::Rails::AppBuilder
          # Any method defined in this class will override a method of the same
          # name in Rails::AppBuilder (http://bit.ly/I2wipm).
          include Helpers::TemplateVariables

          def initialize(generator)
            super
            copy_template_variables_to_instance_variables
          end

          def readme
            template 'README.md'
          end

          def gemfile
            copy_file 'local.Gemfile', 'Gemfile'
          end

          def gitignore
            copy_file 'local.gitignore', '.gitignore'
          end

          # ----------------------------------------------------------------- #

          # https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
          # http://robots.thoughtbot.com/testing-your-factories-first
          def factory_girl
            copy_file 'factory_specs.rake', 'lib/tasks/factory_specs.rake'
            copy_file 'factories_spec.rb', 'spec/factories_spec.rb'
          end

          def foreman
            run %{ echo #{@port} > .foreman }
          end

          def postgres
            template 'postgres_database.yml', 'config/database.yml', force: true
          end

          def pow
            run %{ echo port: #{@port} > ~/.pow/#{@name} }
          end

          def rspec
            generate 'rspec:install'
            replace_file 'spec/spec_helper.rb', copy: 'spec_helper.rb'
          end

          def rvm
            template 'ruby-version', '.ruby-version'
          end

          def spring
            run %{ spring binstub --all }
          end
        end
      end
    end
  end
end
