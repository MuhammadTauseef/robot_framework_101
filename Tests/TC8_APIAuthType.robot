*** Settings ***
Documentation    This is API Auth type request test case
Resource       ../Resources/resources.robot
Library     Collections
Library     RequestsLibrary
Library     OperatingSystem

*** Variables ***
${base_url}     https://httpbin.org
${req_uri}      /get?
${api_key}      43d58fdb7566750e1c553382
*** Test Cases ***
APIAuthTypeTest
    Create session  mysession   ${base_url}   verify=true

    ${params}=   create dictionary    param1=value1     param2=value2       api_key=43d58fdb7566750e1c553382

    ${response} =   Get on session     mysession        ${req_uri}  ${params}

    ${status_code}=  convert to string    ${response.status_code}
    should be equal    ${status_code}   200