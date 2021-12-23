*** Settings ***
Resource         propertyFile.robot
Resource         login_page.robot
Suite Setup      Set Variables
# Test Teardown    Common Teardown

*** Test Cases ***
Login WIth Valid User
    [Tags]    1
    Launch Browser  browser=${BROWSER}
    ${uname}    ${pwd}    ${expMsg}=    Get Test Case Details From Excel    testName=TC1
    Login To Application    ${uname}    ${pwd}
    Verify Login Is Success    expMsg=${expMsg}
    [Teardown]    Update Order Number In Excel    TC1    ${TEST STATUS}

Login WIth Invalid User
    [Tags]    1
    Launch Browser  browser=${BROWSER}
    ${uname}    ${pwd}    ${expMsg}=    Get Test Case Details From Excel    testName=TC2
    Login To Application    ${uname}    ${pwd}
    Verify Login Is Success    expMsg=${expMsg}
    [Teardown]    Update Order Number In Excel    TC2    ${TEST STATUS}