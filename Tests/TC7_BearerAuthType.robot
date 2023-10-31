*** Settings ***
Documentation    This is GET request test case
Resource       ../Resources/resources.robot
Library     Collections
Library     RequestsLibrary

*** Variables ***
${base_url}     https://httpbin.org
${bearerToken}  "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6Ikpva"

*** Test Cases ***
BasicAuthTypeTest
    Create session  mysession   ${base_url}     Authorization=${bearerToken}    verify=true
    ${response} =   Get on session     mysession    /post

    ${status_code}=  convert to string    ${response.status_code}
    should be equal    ${status_code}   200