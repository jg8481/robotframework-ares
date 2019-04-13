*** Settings ***
Library     DateTime
Resource    ARES_LISTENER.robot

*** Keywords ***

My Project Suite Setup
    [Documentation]   My custom keyword which I will call using Suite Setup
    [Arguments]   ${test_count}=1

    Run Keyword If  '${SUITE_PRE_RUNNER}' == '0'    Run Keywords
    ...    Setup Run ID Details    START
    ...    AND    Set Global Variable   ${SUITE_PRE_RUNNER}    1

    # post module details
    Post Module Data Details    START    ${test_count}

My Project Suite Teardown
    [Documentation]   My custom keyword which I will call using Suite Teardown
    [Arguments]   ${test_count}=1
    # post module details
    Post Module Data Details    END    ${test_count}

My Project Test Setup
    [Documentation]   My custom keyword which I will call using Test setup
    # following date time are mandatory
    ${current_date}=       Get Current Date    result_format='%Y-%m-%d'
    ${start_date_time}=    Get Current Date
    Set Test Variable    ${current_date}
    Set Test Variable    ${start_date_time}

My Project Test Teardown
    [Documentation]   My custom keyword which I will call using Test teardown
    Post Test Results