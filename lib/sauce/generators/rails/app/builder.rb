require 'rails/generators/rails/app/app_generator'
require 'rvm/with'
require 'helpers/template_variables'
require 'helpers/colored'

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

          def better_errors
            copy_file 'better_errors.rb', 'config/initializers/better_errors.rb'
          end

          def dotenv
            template 'env', '.env'
          end

          def env_development
            template 'env.development', '.env.development'
          end

          def env_production
            template 'env.production', '.env.production'
          end

          def env_staging
            template 'env.staging', '.env.staging'
            template 'staging.rb', 'config/environments/staging.rb'
          end

          def env_test
            template 'env.test', '.env.test'
          end

          # https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
          # http://robots.thoughtbot.com/testing-your-factories-first
          def factory_girl
            copy_file 'factory_specs.rake', 'lib/tasks/factory_specs.rake'
            copy_file 'factories_spec.rb', 'spec/factories_spec.rb'
          end

          def foreman
            run %{ echo port: #{@port} > .foreman }
            copy_file 'Procfile', 'Procfile'
          end

          def git
            run %{ git init }
            run %{ git add . }
            run %{ git commit -m 'Initial commit' }
          end

          def instructions
            say %{\n}
            say %{  A new Rails application has been created in #{@path}.\n}.green

            say %{  Run `foreman start` to start the server.}.magenta
            say %{  Then visit the application at http://#{@name}.dev }.magenta
          end

          def pow
            run %{ echo #{@port} > .port }
            run %{ ln -s #{@path}/.port ~/.pow/#{@name} }
          end

          def rvm
            template 'ruby-version', '.ruby-version'
          end

          # ----------------------------------------------------------------- #

          def bundle
            rvm_run %{ bundle install --without production } unless options[:cucumber]
          end

          def database
            copy_file 'local.database.yml', 'config/database.yml', force: true
            rvm_run %{ rake db:create } unless options[:cucumber]
          end

          def rspec
            rvm_run %{ rails generate rspec:install } unless options[:cucumber]
            replace_file 'spec/spec_helper.rb', copy: 'spec_helper.rb'\
          end

          # https://github.com/rails/spring/blob/master/README.md
          def spring
            rvm_run %{ spring binstub --all } unless options[:cucumber]
          end

          private

          def rvm_run(command)
            stdout = nil
            stderr = nil

            desc = "#{command} from \".\""
            say_status :run, desc, :green

            RVM.with "2.1.0@#{@name}-rails" do |r|
              stdout, stderr = r.execute command
            end

            $stdout.puts stdout
            $stderr.puts stderr
          end
        end
      end
    end
  end
end
