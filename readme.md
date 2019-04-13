# Robotframework ARES

This repo consist of example for using ARES dashboard

What is ARES?

ARES is centralized report developed by ZenQ for QA Community. 
For more info on account, project creation refer [ARES Introduction](https://github.com/testastra/ARES/blob/master/Tutorials/01_Introduction.md)

How to use ARES with Robotframework

 - Push test result to ARES using REST API calls
   - Before all Suite's (create session)
   - Before Suite (create suite session)
   - After Test (push test result data)
   - After Suite (close suite session)
   - After all Suite's (close session)

Examples:

 - Download current repo
 - Copy ARES folder to project
 - Import following lines in suite
   ```
    *** Settings ***
    Resource    ${EXECDIR}${/}ARES${/}ARES_KEYWORDS.robot

    # ARES: setup/teardown
    Suite Setup      My Project Suite Setup    3
    Suite Teardown   My Project Suite Teardown    3
    Test Setup       My Project Test Setup
    Test Teardown    My Project Test Teardown
   ``` 
 - Copy `Z_END_FULL_SUITES.robot` to tests folder (responsible to quit session)
 - Execute tests (all suites)
 - Go to ARES Dashboard to view live execution, historical records

QUICK OVERVIEW

*LIVE EXECUTION*

  <a href="https://ibb.co/QkFJ8Xd"><img src="https://i.ibb.co/bFg6H7J/ARES-LIVE.jpg" alt="ARES-LIVE" border="0"></a>

*DASHBOARD*

   <a href="https://ibb.co/xD7YX41"><img src="https://i.ibb.co/f2x9qck/ARES-DASHBOARD.jpg" alt="ARES-DASHBOARD" border="0" /></a>

*HISTORIC DATA*

   <a href="https://ibb.co/q71TsM7"><img src="https://i.ibb.co/jb4nMvb/ARES-DETAILED.jpg" alt="ARES-DETAILED" border="0"></a>

