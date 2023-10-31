*** Settings ***
Documentation    This is Bearer Auth type request test case
Resource       ../Resources/resources.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem

*** Variables ***
${base_url}     https://httpbin.org
${bearerToken}  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6Ikpva"

*** Test Cases ***
BearerAuthTypeTest
    Create session  mysession   ${base_url}   verify=true

    ${headers}  create dictionary     Authorization=${bearerToken} Content-Type=text/xml
    ${req_body}=    get file    Data/books.xml

    ${response} =   Post on session     mysession    /post  data=${req_body}    headers=${headers}

    ${status_code}=  convert to string    ${response.status_code}
    should be equal    ${status_code}   200