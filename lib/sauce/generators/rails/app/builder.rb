require 'rails/generators/rails/app/app_generator'
require 'helpers/template_variables'

require 'rvm/with'

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

          def env_staging
            template 'staging.rb', 'config/environments/staging.rb'
          end

          # https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
          # http://robots.thoughtbot.com/testing-your-factories-first
          def factory_girl
            copy_file 'factory_specs.rake', 'lib/tasks/factory_specs.rake'
            copy_file 'factories_spec.rb', 'spec/factories_spec.rb'
          end

          def foreman
            run %{ echo #{@port} > .foreman }
          end

          def gems
            RVM.with "2.1.0@#{@name}-rails" do |r|
              puts r.execute 'bundle install --without production'
              puts r.execute 'rails generate rspec:install'
              puts r.execute 'spring binstub --all'
              puts r.execute 'rake db:create:all'

              replace_file 'spec/spec_helper.rb', copy: 'spec_helper.rb'
            end
          end

          def pow
            run %{ echo port: #{@port} > ~/.pow/#{@name} }
          end

          def rvm
            template 'ruby-version', '.ruby-version'
          end
        end
      end
    end
  end
end
