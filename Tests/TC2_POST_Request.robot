*** Settings ***
Documentation    This is POST request test case
Resource       ../Resources/resources.robot
Library     Collections
Library     RequestsLibrary

*** Variables ***
${base_url}     https://httpbin.org

*** Test Cases ***
Create_Something
    Create session  mysession   ${base_url}     verify=true
    ${body}=    create dictionary    username=user  password=passs
    ${header}=    create dictionary    Content-Type=application/json
    ${response} =   Post on session     mysession    /post      ${body}     ${header}

    Log to console      ${response.status_code}
    Log to console      ${response.content}


    ${status_code}=  convert to string    ${response.status_code}
    should be equal    ${status_code}   200


    ${body}=  convert to string    ${response.content}
    should contain    ${body}       user

    ${contentTypeValue}=  get from dictionary    ${response.headers}    Content-Type
    should be equal    ${contentTypeValue}   application/json