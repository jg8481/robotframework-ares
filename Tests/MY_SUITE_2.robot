*** Settings ***
Resource    ${EXECDIR}${/}ARES${/}ARES_KEYWORDS.robot

# ARES: setup/teardown
Suite Setup      My Project Suite Setup    3
Suite Teardown   My Project Suite Teardown    3
Test Setup       My Project Test Setup
Test Teardown    My Project Test Teardown

*** Test Cases ***
My Fourth Test Case
    Sleep   15s

My Fifth Test Case
    Sleep   5s
    Should Be Equal   Shiva    Adirala

My Sixth Test Case
    Sleep   10s