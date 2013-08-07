@cli
Feature: The command line interface

  Scenario: Specifying neither command nor option
    When I run `sauce`
    Then the output should contain "Commands:"

  Scenario Outline: Asking for help
    When I run `<command>`
    Then the output should contain "<output>"
    Examples:
      | command       | output    |
      | sauce -h      | Commands: |
      | sauce --help  | Commands: |
      | sauce help    | Commands: |

  Scenario Outline: Querying current version
    When I run `<command>`
    Then the output should match /^\d+\.\d+\.\d+$/
    Examples:
      | command         |
      | sauce -v        |
      | sauce --version |
      | sauce version   |

  Scenario Outline: Specifying unknown commands
    When I run `<command>`
    Then it should fail with:
      """
      Thor::UndefinedCommandError exception while executing Sauce:
      """
    Examples:
      | command         |
      | sauce badcmd    |
      | sauce crap cmd  |
      | sauce w 3 args  |

  Scenario Outline: Specifying unknown options
    When I run `<command>`
    Then it should fail with:
      """
      Thor::UnknownArgumentError exception while executing Sauce:
      """
    Examples:
      | command             |
      | sauce --ab command  |
      | sauce --verse       |
      | sauce -y            |
