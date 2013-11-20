@cljs
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
      | appname                                         |
      | appname/doc                                     |
      | appname/resources                               |
      | appname/resources/public                        |
      | appname/resources/public/css                    |
      | appname/resources/public/js                     |
      | appname/src                                     |
      | appname/src/clj                                 |
      | appname/src/clj/appname                         |
      | appname/src/cljs                                |
      | appname/src/cljs/appname                        |
      | appname/test                                    |
      | appname/test/appname                            |
    And the following files should exist:
      | appname/LICENSE                                 |
      | appname/README.md                               |
      | appname/doc/intro.md                            |
      | appname/project.clj                             |
      | appname/resources/public/index.html             |
      | appname/src/clj/appname/core.clj                |
      | appname/src/cljs/appname/core.cljs              |
      | appname/test/appname/core_test.clj              |
