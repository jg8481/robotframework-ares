*** Settings ***
Resource    ${EXECDIR}${/}ARES${/}ARES_KEYWORDS.robot

# ARES: setup/teardown
Suite Setup      My Project Suite Setup    3
Suite Teardown   My Project Suite Teardown    3
Test Setup       My Project Test Setup
Test Teardown    My Project Test Teardown

*** Test Cases ***
My Seven Test Case
    Sleep   18s
    Should Be True   ${1}>${2}

My Eight Test Case
    Sleep   10s
    Should Be True   ${1}<${2}

My Nine Test Case
    Sleep   10s
    Should Be Equal   Robot    framework