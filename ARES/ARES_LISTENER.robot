*** Settings ***

# perform REST API calls using RequestsLibrary
Library     RequestsLibrary

# other useful libraries for performing actions on json
Library     Collections
Library     String
Library     DateTime

# import test data form other file
Resource    ARES_DATA.robot

*** Keywords ***

Setup Run ID Details
    [Documentation]    Keyword used to start / end runID (which is used for entire execution)
    ...                Start Process: Setup Run ID Details | START
    ...                End Process:   Setup Run ID Details | END
    ...                Usage: Call this keyword in suite set-up/teardown

    [Arguments]    ${status}

    # create alias of ARES
    Create Session    ares   ${ARES_API_BASE_URI}

    # set_up body of the post
    &{my_json_data}=    Generate RunID Body    ${status}

    # post data to URI
    ${response}=    Post Request    ares    /createrunid    json=${my_json_data}

    # validate post response status
    Should Be Equal As Strings    ${response.status_code}    200

    # set ${run_id} as suite variable, so it can be used in entire suite
    Set Suite Variable   ${run_id}    ${response.json()['data'][0]['runId']}


Post Module Data Details
    [Documentation]    Keyword used to post suite details (which used for displaying live execution details)
    ...                Start Process: Post Module Data Details | START
    ...                End Process:   Post Module Data Details | END
    ...                Usage: Call this keyword in suite set-up/teardown

    [Arguments]    ${status}    ${tests_count}=1

    # create alias of ARES
    Create Session    ares   ${ARES_API_BASE_URI}

    # set_up body of the post
    &{my_json_data}=    Generate Post Module Body    ${status}    ${tests_count}

    # post data to URI
    ${response}=    Post Request    ares    /addmoduledata    json=${my_json_data}

    # validate post response status
    Should Be Equal As Strings    ${response.status_code}    200


Post Test Results
    [Documentation]    Keyword used to post test results (which used for displaying historical data)
    ...                Usage: Call this keyword in test teardown

    # create alias of ARES
    Create Session    ares   ${ARES_API_BASE_URI}

    # set_up body of the post
    &{my_json_data}=    Generate Post Test Body

    &{headers}=    Create Dictionary  Content-Type=application/json
    ...    usertoken=${USER_TOKEN}    ProjectId=${PROJECT_KEY}

    # post data to URI
    ${response}=    Post Request    ares    /addgraphdata    json=${my_json_data}   headers=${headers}

    # validate post response status
    Should Be Equal As Strings    ${response.status_code}    200

# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * #
# * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * # * #


Generate Post Test Body
    [Documentation]    Keyword to create json body for post test result

    ${end_date_time}=    Get Current Date

    &{child_params}=   Create Dictionary
    ...    runId=${run_id}
    ...    productName=${PRODUCT_NAME}
    ...    moduleName=${SUITE NAME}
    ...    testcaseTitle=${TEST NAME}
    ...    testStatus=${TEST STATUS}
    ...    testData=${TEST_DATA}
    ...    failStacktrace=${TEST MESSAGE}
    ...    testBrowser=${TEST_BROWSER}
    ...    testMachine=${TEST_MACHINE}
    ...    imageLink=${IMAGE_LINK}
    ...    videoLink=${VIDEO_LINK}
    ...    testDevice=${TEST_DEVICE}
    ...    testOs=${TEST_OS}
    ...    testDate=${current_date}
    ...    testStartTime=${start_date_time}
    ...    testEndTime=${end_date_time}
    ...    testSuite=${SUITE NAME}
    ...    runBy=${RUN_BY_USER}
    ...    errorMessage=${TEST MESSAGE}
    ...    executionMode=${EXECUTION_MODE}
    ...    failType=${FAIL_TYPE}

    &{params}=   Create Dictionary
    ...    graphData=${child_params}

    [Return]    &{params}


Generate Post Module Body
    [Documentation]    Keyword to create json body for post module

    [Arguments]   ${status}   ${total_tests}

    ${set_up_status}=    Get API Helper Status   ${status}

    # if status is END the json param should be endtime instead of starttime
    ${time_key}=    Set Variable If
    ...    '${status}'=='START'    starttime
    ...    '${status}'!='START'    endtime

    ${current_date_time}=    Get Current Date

    &{params}=   Create Dictionary
    ...    token=${USER_TOKEN}
    ...    runId=${run_id}
    ...    ws_name=${WORK_SPACE_NAME}
    ...    project_name=${PROJECT_NAME}
    ...    module_name=${SUITE NAME}
    ...    ${time_key}=${current_date_time}
    ...    totaltests=${total_tests}
    ...    status=${set_up_status}

    [Return]    &{params}


Generate RunID Body
    [Documentation]    Keyword to create json body for setup runid

    [Arguments]   ${status}

    ${set_up_status}=    Get API Helper Status   ${status}

    &{params}=   Create Dictionary
    ...    token=${USER_TOKEN}
    ...    ws_name=${WORK_SPACE_NAME}
    ...    project_name=${PROJECT_NAME}
    ...    status=${set_up_status}

    [Return]    &{params}


Get API Helper Status
    [Arguments]    ${status}

    ${set_up_status}=    Set Variable If
    ...    '${status}'=='START'    started
    ...    '${status}'!='START'    ended

    [Return]    ${set_up_status}