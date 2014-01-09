@cljs @announce
Feature: ClojureScript generators

  Scenario Outline: Asking for help on ClojureScript commands
    When I run `<command>`
    Then the output should contain "<output>"
    Examples:
      | command               | output                              |
      | sauce cljs help app   | Create a ClojureScript application  |

  Scenario: Creating an initial ClojureScript application
    When I run `sauce cljs app appname`
    Then the following directories should exist:
      | appname                                           |
      | appname/config                                    |
      | appname/doc                                       |
      | appname/resources                                 |
      | appname/resources/public                          |
      | appname/resources/public/components               |
      | appname/resources/public/components/foundation    |
      | appname/resources/public/components/jquery        |
      | appname/resources/public/components/modernizr     |
      | appname/resources/public/css                      |
      | appname/resources/public/js                       |
      | appname/resources/public/js/vendor                |
      | appname/src                                       |
      | appname/src/clj                                   |
      | appname/src/clj/appname                           |
      | appname/src/cljs                                  |
      | appname/src/cljs/appname                          |
      | appname/test                                      |
      | appname/test/appname                              |
    And the following files should exist:
      | appname/.gitignore                                |
      | appname/LICENSE                                   |
      | appname/README.md                                 |
      | appname/bower.json                                |
      | appname/project.clj                               |
      | appname/config/compass.rb                         |
      | appname/doc/intro.md                              |
      | appname/resources/public/index.html               |
      | appname/resources/public/js/vendor/foundation.js  |
      | appname/resources/public/sass/app.sass            |
      | appname/src/clj/appname/server.clj                |
      | appname/src/cljs/appname/core.cljs                |
      | appname/test/appname/core_test.clj                |
