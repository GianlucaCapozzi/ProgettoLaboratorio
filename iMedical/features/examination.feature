Feature: Create and Manage Examinations
    As a PATIENT
    I want to select a doctor
    Such that I can book an examination


Scenario: I want to select a clinic
    Given As a PATIENT
    When I click on cerca studio medico button
    Then I should be redirected to clinics' search form
    Given I am on the clinics search page
    When I click on Informazioni button
    Then I should be redirected to clinic show page

Scenario: I want to select a doctor
    Given As a PATIENT
    Given I am on Info page
    When I click on lista medici link
    Then I should be redirected to clinic doctors page
    Given I am on clinic doctors page
    When I click on the first doctor link
    Then I should be redirected to clinic doctor page
