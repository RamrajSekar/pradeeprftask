*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem
Library    scripts/utilityScripts.py
Library    ExcelLibrary
Library    Collections

*** Variables ***
${BROWSER}      headlesschrome
${BASE_URL}     http://demo.guru99.com/test/newtours/
${DEF_WAIT}     60
${MED_WAIT}     30
${data_file}    ${EXECDIR}\\testData\\TestData.xlsx
${data_sheet}   loginTest

*** Keywords ***
Set Variables
    Set Selenium Timeout    ${DEF_WAIT}
    ${sheet}    ${workBook}=    readExlData    ${data_file}    ${data_sheet}
    Set Suite Variable    ${sheet}
    Set Suite Variable    ${workBook}
    # Set Suite Variable    ${uname}
    # Set Suite Variable    ${pwd}

# Set Test Variables
#     [Arguments]    ${TC}
#     ${uname}    ${pwd}=    Get Test Case Details From Excel    ${sheet}    ${TC}
#     Set Suite Variable    ${uname}
#     Set Suite Variable    ${pwd}
    

Set Browser Driver Path
    ${driverPath}=    get_chromedriver_path
    Copy File    ${driverPath}    ${EXECDIR}\\drivers
    Append To Environment Variable  Path  ${EXECDIR}\\drivers
    ${a}=    Get Environment Variable    Path
    Log Many    ${a}

Launch Browser 
    # [Arguments]    ${headless}=false
    [Arguments]    ${browser}=${BROWSER}    ${url}=${BASE_URL}
    Set Browser Driver Path
    Open Browser    url=${url}    browser=${browser}
    Maximize Browser Window

Common Teardown
    Close All Browsers

Get Test Case Details From Excel
    [Arguments]    ${sheet}=${sheet}    ${testName}=TC1
    ${row_count}=    getExlRowCount    ${sheet}
    ${row_count}=    Evaluate    ${row_count} + 1
    FOR    ${row}    IN RANGE    2    ${row_count}
        ${result}=    getRowVal    ${sheet}    ${row}
        ${testCase}=    Get From Dictionary    ${result}    TC_Name
        ${userName}=    Get From Dictionary    ${result}    username
        ${password}=    Get From Dictionary    ${result}    password
        ${expMsg}=      Get From Dictionary    ${result}    Validation_Message
        Exit For Loop If    '${testCase}'=='${testName}'
    END
    [Return]    ${userName}    ${password}    ${expMsg}

Update Order Number In Excel
    Common Teardown
    [Arguments]    ${testCase}    ${result}
    ${dataInput}=    Run Keyword If    '${result}'=='PASS'    Set Variable    PASS
    ...                        ELSE    Set Variable    FAIL
    updateExlData    sheet=${sheet}    workbook=${workBook}    path=${data_file}    data=${dataInput}    colNo=5    testCase=${testCase}