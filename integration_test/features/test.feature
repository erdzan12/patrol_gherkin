@test
Feature: User can see camera

    Scenario: As a user I can use the camera and accept permissions when asked
        Given I wait until the "home_page" is present
        Then I tap accept permissions
        Then I tap accept permissions