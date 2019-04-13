*** Settings ***
Resource    ${EXECDIR}${/}ARES${/}ARES_KEYWORDS.robot

*** Test Cases ***
Close Run ID After Suite End
    [Documentation]    This is a custom test case used to end ARES session
    Setup Run ID Details    END