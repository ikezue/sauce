@rails @announce
Feature: Rails generators

  Scenario Outline: Asking for help on rails commands
    When I run `<command>`
    Then the output should contain "<output>"
    Examples:
      | command               | output                      |
      | sauce rails help app  | Create a Rails application  |

  Scenario: Creating an initial Rails application
    When I run `sauce rails app appname --cucumber=true`
    Then the following directories should exist:
      | appname                                                   |
      | appname/app                                               |
      | appname/app/assets                                        |
      | appname/app/assets/images                                 |
      | appname/app/assets/javascripts                            |
      | appname/app/assets/stylesheets                            |
      | appname/app/controllers                                   |
      | appname/app/controllers/concerns                          |
      | appname/app/helpers                                       |
      | appname/app/mailers                                       |
      | appname/app/models                                        |
      | appname/app/models/concerns                               |
      | appname/app/views                                         |
      | appname/app/views/layouts                                 |
      | appname/bin                                               |
      | appname/config                                            |
      | appname/config/environments                               |
      | appname/config/initializers                               |
      | appname/config/locales                                    |
      | appname/db                                                |
      | appname/lib                                               |
      | appname/lib/assets                                        |
      | appname/lib/tasks                                         |
      | appname/log                                               |
      | appname/public                                            |
      | appname/spec                                              |
      | appname/tmp                                               |
      | appname/tmp/cache                                         |
      | appname/tmp/cache/assets                                  |
      | appname/vendor                                            |
      | appname/vendor/assets                                     |
      | appname/vendor/assets/javascripts                         |
      | appname/vendor/assets/stylesheets                         |
    And the following files should exist:
      | appname/.foreman                                          |
      | appname/.gitignore                                        |
      | appname/.rspec                                            |
      | appname/.ruby-version                                     |
      | appname/Gemfile                                           |
      | appname/README.md                                         |
      | appname/Rakefile                                          |
      | appname/app/assets/images/.keep                           |
      | appname/app/assets/javascripts/application.js             |
      | appname/app/assets/stylesheets/application.css            |
      | appname/app/controllers/application_controller.rb         |
      | appname/app/controllers/concerns/.keep                    |
      | appname/app/helpers/application_helper.rb                 |
      | appname/app/mailers/.keep                                 |
      | appname/app/models/.keep                                  |
      | appname/app/models/concerns/.keep                         |
      | appname/app/views/layouts/application.html.erb            |
      | appname/bin/bundle                                        |
      | appname/bin/rails                                         |
      | appname/bin/rake                                          |
      | appname/config/application.rb                             |
      | appname/config/boot.rb                                    |
      | appname/config/database.yml                               |
      | appname/config/environment.rb                             |
      | appname/config/environments/development.rb                |
      | appname/config/environments/production.rb                 |
      | appname/config/environments/staging.rb                    |
      | appname/config/environments/test.rb                       |
      | appname/config/initializers/backtrace_silencers.rb        |
      | appname/config/initializers/filter_parameter_logging.rb   |
      | appname/config/initializers/inflections.rb                |
      | appname/config/initializers/mime_types.rb                 |
      | appname/config/initializers/session_store.rb              |
      | appname/config/initializers/wrap_parameters.rb            |
      | appname/config/locales/en.yml                             |
      | appname/config/routes.rb                                  |
      | appname/config/secrets.yml                                |
      | appname/config.ru                                         |
      | appname/db/seeds.rb                                       |
      | appname/lib/assets/.keep                                  |
      | appname/lib/tasks/.keep                                   |
      | appname/lib/tasks/factory_specs.rake                      |
      | appname/log/.keep                                         |
      | appname/log/development.log                               |
      | appname/public/404.html                                   |
      | appname/public/422.html                                   |
      | appname/public/500.html                                   |
      | appname/public/favicon.ico                                |
      | appname/public/robots.txt                                 |
      | appname/spec/spec_helper.rb                               |
      | appname/spec/factories_spec.rb                            |
      | appname/vendor/assets/javascripts/.keep                   |
      | appname/vendor/assets/stylesheets/.keep                   |
    And the following directories should not exist:
      | appname/test                                              |
    But the following files should not exist:
      | appname/public/index.html                                 |
      | appname/README.rdoc                                       |
