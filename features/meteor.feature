@meteor
Feature: Meteor generators

  Scenario Outline: Asking for help on meteor commands
    When I run `<command>`
    Then the output should contain "<output>"
    Examples:
      | command                   | output                      |
      | sauce meteor help create  | Create a Meteor application |

  Scenario: Creating an initial Meteor application
    When I run `sauce meteor create meteor_app`
    Then the following directories should exist:
      | meteor_app |
