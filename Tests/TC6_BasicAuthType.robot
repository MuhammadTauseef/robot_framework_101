*** Settings ***
Documentation    This is GET request test case
Resource       ../Resources/resources.robot
Library     Collections
Library     RequestsLibrary

*** Variables ***
${base_url}     https://httpbin.org

*** Test Cases ***
BasicAuthTypeTest
    ${auth}=    create list    user     pass
    Create session  mysession   ${base_url}     auth=${auth}     verify=true
    ${response} =   Get on session     mysession    /get

    ${status_code}=  convert to string    ${response.status_code}
    should be equal    ${status_code}   200