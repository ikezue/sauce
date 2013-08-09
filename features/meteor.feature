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
      | appname                                   |
      | appname/.meteor                           |
      | appname/client                            |
      | appname/client/config                     |
      | appname/client/stylesheets                |
      | appname/client/views                      |
      | appname/client/views/partials             |
      | appname/collections                       |
      | appname/lib                               |
      | appname/public                            |
      | appname/server                            |
    And the following files should exist:
      | appname/client/main.coffee                |
      | appname/client/main.html                  |
      | appname/client/config/accounts.coffee     |
      | appname/client/config/routes.coffee       |
      | appname/client/stylesheets/main.sass      |
      | appname/client/views/partials/header.html |
      | appname/client/views/partials/footer.html |
      | appname/collections/.gitkeep              |
      | appname/lib/.gitkeep                      |
      | appname/public/.gitkeep                   |
      | appname/server/publications.coffee        |
    But the following files should not exist:
      | appname/appname.css                       |
      | appname/appname.html                      |
      | appname/appname.js                        |
