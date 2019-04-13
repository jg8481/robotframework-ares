# ARES DASHBOARD TEST DATA #

*** Variables ***

# ======== ARES API URI's ======== #

${ARES_API_BASE_URI}=    http://testastra.com/graph

# ======== USER TOKEN ============ #
 
${USER_TOKEN}=    XXX SECRET TOKEN XXX

# ======== ARES PROJECT INFO ===== #

${WORK_SPACE_NAME}=    zenq_default

${PROJECT_NAME}=   RFPDemo

${PROJECT_KEY}=   XXX SECRET ID XXX

# ======== OTHER INFO (replace with you data) ======== #

${PRODUCT_NAME}=   ${PROJECT_NAME}

${TEST_DATA}=        ${EMPTY}
${TEST_BROWSER}=     Chrome
${TEST_MACHINE}=     Windows 10 (64 bit)
${IMAGE_LINK}=       ${EMPTY}
${VIDEO_LINK}=       ${EMPTY}
${TEST_DEVICE}=      DESKTOP
${TEST_OS}=          Windows
${RUN_BY_USER}=      Shiva Adirala
${EXECUTION_MODE}=   Sequence
${FAIL_TYPE}=        ${EMPTY}

# variable used to logic to initate setup befor all suites
${SUITE_PRE_RUNNER}=   0