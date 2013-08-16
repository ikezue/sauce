@meteor
Feature: Meteor generators

  Scenario Outline: Asking for help on meteor commands
    When I run `<command>`
    Then the output should contain "<output>"
    Examples:
      | command                   | output                      |
      | sauce meteor help create  | Create a Meteor application |

  Scenario: Creating an initial Meteor application
    When I run `sauce meteor create appname`
    Then the following directories should exist:
      | appname                                                   |
      | appname/.meteor                                           |
      | appname/client                                            |
      | appname/client/config                                     |
      | appname/client/stylesheets                                |
      | appname/client/stylesheets/partials                       |
      | appname/client/views                                      |
      | appname/client/views/partials                             |
      | appname/collections                                       |
      | appname/lib                                               |
      | appname/packages                                          |
      | appname/packages/foundationjs                             |
      | appname/public                                            |
      | appname/server                                            |
    And the following files should exist:
      | appname/client/config/accounts.coffee                     |
      | appname/client/config/compass.rb                          |
      | appname/client/config/routes.coffee                       |
      | appname/client/stylesheets/partials/_normalize.sass       |
      | appname/client/stylesheets/partials/_settings.sass        |
      | appname/client/stylesheets/main.sass                      |
      | appname/client/views/partials/header.html                 |
      | appname/client/views/partials/footer.html                 |
      | appname/client/main.coffee                                |
      | appname/client/main.css                                   |
      | appname/client/main.html                                  |
      | appname/collections/.gitkeep                              |
      | appname/lib/.gitkeep                                      |
      | appname/packages/foundationjs/package.js                  |
      | appname/packages/foundationjs/foundation_init.js          |
      | appname/packages/foundationjs/custom.modernizr.js         |
      | appname/packages/foundationjs/foundation.js               |
      | appname/packages/foundationjs/foundation.abide.js         |
      | appname/packages/foundationjs/foundation.alerts.js        |
      | appname/packages/foundationjs/foundation.clearing.js      |
      | appname/packages/foundationjs/foundation.cookie.js        |
      | appname/packages/foundationjs/foundation.dropdown.js      |
      | appname/packages/foundationjs/foundation.forms.js         |
      | appname/packages/foundationjs/foundation.interchange.js   |
      | appname/packages/foundationjs/foundation.joyride.js       |
      | appname/packages/foundationjs/foundation.magellan.js      |
      | appname/packages/foundationjs/foundation.orbit.js         |
      | appname/packages/foundationjs/foundation.placeholder.js   |
      | appname/packages/foundationjs/foundation.reveal.js        |
      | appname/packages/foundationjs/foundation.section.js       |
      | appname/packages/foundationjs/foundation.tooltips.js      |
      | appname/packages/foundationjs/foundation.topbar.js        |
      | appname/public/robots.txt                                 |
      | appname/server/publications.coffee                        |
      | appname/server/server.coffee                              |
      | appname/Gemfile                                           |
    But the following files should not exist:
      | appname/appname.css                                       |
      | appname/appname.html                                      |
      | appname/appname.js                                        |
      | appname/config.rb                                         |
      | appname/humans.txt                                        |
      | appname/index.html                                        |
      | appname/MIT-LICENSE.txt                                   |
      | appname/robots.txt                                        |
    And the following directories should not exist:
      | appname/javascripts                                       |
