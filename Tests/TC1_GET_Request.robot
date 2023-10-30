*** Settings ***
Documentation    This is GET request test case
Resource       ../Resources/resources.robot
Library     Collections
Library     RequestsLibrary

*** Keywords ***

*** Variables ***
${base_url}     https://api.publicapis.org
${title}        Axolotl

*** Test Cases ***
Get_entry
    Create session  mysession   ${base_url}     verify=true
    ${response} =   Get on session     mysession   /entries\?title\=${title}
#    Log to console      ${response}
#    Log to console      ${response.content}
#    Log to console      ${response.headers}

    ${status_code}=  convert to string    ${response.status_code}
    should be equal    ${status_code}   200


    ${body}=  convert to string    ${response.content}
    should contain    ${body}   ${title}

    ${contentTypeValue}=  get from dictionary    ${response.headers}    Content-Type
    should be equal    ${contentTypeValue}   application/json