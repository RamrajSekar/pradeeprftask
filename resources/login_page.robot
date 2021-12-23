*** Settings ***
Resource    propertyFile.robot
Resource    common_imports.robot

***Variables***
&{lpLocator}        inputField=//font[contains(normalize-space(),'LABLE-NAME')]//following::input[1]
...                 submitBtn=//input[@value='Submit']
...                 welcomeMsg=//h3[text()='Login Successfully']
...                 errorMsg=//span[contains(text(),'Enter your userName and password correct')]

***Keywords***
Login To Application
    [Arguments]    ${userName}    ${password}
    Wait Until Location Contains    newtours    ${MED_WAIT}
    # Run Keyword And Continue On Failure    Wait Until Element Contains    ${lpLocator.title}    Welcome: Mercury Tours    #${MED_WAIT}
    Enter Text In A Field    ${lpLocator.inputField}    User Name:    ${userName}
    Enter Text In A Field    ${lpLocator.inputField}    Password:    ${password}
    Click Submit Button
    # Run Keyword If    ''==''    Wait Until Element Is Visible    ${lpLocator.welcomeMsg}    ${MED_WAIT}
    # Wait Until Element Is Visible    ${lpLocator.errorMsg}    ${MED_WAIT}
    
Click Submit Button
    Wait Until Element Is Visible    ${lpLocator.submitBtn}    ${MED_WAIT}
    Click Element    ${lpLocator.submitBtn}

# Verify Login Is Success
#     ${invalidLogMsg}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${lpLocator.errorMsg}    ${MED_WAIT}
#     Run Keyword If    ${invalidLogMsg}==False    Wait Until Element Is Visible    ${lpLocator.welcomeMsg}    ${MED_WAIT}

Verify Login Is Success
    [Arguments]    ${expMsg}
    ${invalidLogMsg}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${lpLocator.errorMsg}    ${MED_WAIT}
    Run Keyword If    ${invalidLogMsg}==False    Wait Until Element Is Visible    ${lpLocator.welcomeMsg}    ${MED_WAIT}
    ${actValue}=    Run Keyword If    ${invalidLogMsg}==True    Get Text    ${lpLocator.errorMsg}
    ...                       ELSE    Get Text    ${lpLocator.welcomeMsg}
    Should Be Equal As Strings    ${expMsg}    ${actValue}
    # Update Order Number In Excel