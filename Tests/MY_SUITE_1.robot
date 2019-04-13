*** Settings ***
Resource    ${EXECDIR}${/}ARES${/}ARES_KEYWORDS.robot

# ARES: setup/teardown
Suite Setup      My Project Suite Setup    3
Suite Teardown   My Project Suite Teardown    3
Test Setup       My Project Test Setup
Test Teardown    My Project Test Teardown

*** Test Cases ***
My First Test Case
    Sleep   20s

My Second Test Case
    Sleep   10s

My Third Test Case
    Sleep   10s