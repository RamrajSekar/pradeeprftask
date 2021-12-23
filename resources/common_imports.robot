*** Settings ***
Resource     propertyFile.robot
Library      String

***Keywords***
Enter Text In A Field
    [Arguments]    ${locator}    ${fieldName}    ${inputText}
    ${locator}=    Replace String    ${locator}    LABLE-NAME    ${fieldName}  
    Wait Until Element Is Visible    ${locator}    ${MED_WAIT}
    Input Text    ${locator}    ${inputText}