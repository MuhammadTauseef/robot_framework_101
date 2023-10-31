*** Settings ***
Documentation    These are headers and cookies validation test case
Resource       ../Resources/resources.robot
Library     Collections
Library     RequestsLibrary

*** Variables ***
${base_url}     http://jsonplaceholder.typicode.com


*** Test Cases ***
TestHeaders
    Create session  mysession   ${base_url}
    ${response} =   Get on session     mysession    /photos
    Log to console         ${response.headers}

    ${contentTypeValue}=  get from dictionary    ${response.headers}    Content-Type
    should be equal    ${contentTypeValue}   application/json; charset=utf-8


TestCookies
    Create session  mysession   ${base_url}
    ${response} =   Get on session     mysession    /photos

    ${cookieValue}=     get from dictionary    ${response.cookies}      _cfduid
    log to console    ${cookieValue}